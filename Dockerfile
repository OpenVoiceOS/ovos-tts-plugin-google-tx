# Google Translate's free TTS endpoint (gTTS) served through ovos-tts-server's
# ElevenLabs-compatible API. A self-contained image: any client that speaks the
# ovos-tts-server / ElevenLabs API can hit it, and it can be A/B-tested against other
# ovos-tts-server voices (edge-tts, phoonnx, ...) by pointing at a different port.
#
# gTTS calls translate.google.com to synthesize speech, so this container needs
# network access (it is not an offline/air-gapped voice). No API key is required.
FROM python:3.14-slim

# ffmpeg: gTTS emits mp3; ovos-tts-server transcodes non-WAV plugin output to WAV.
RUN apt-get update && apt-get install -y --no-install-recommends \
        ffmpeg \
        git \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY . /app

# the plugin + the OVOS TTS server. setuptools<81 keeps ovos-plugin-manager's
# pkg_resources usage working. ovos-tts-server>=1.13.5a1 carries the non-WAV transcode
# fix (gTTS emits mp3); the alpha floor lets pip resolve the prerelease without --pre.
RUN pip install --no-cache-dir --upgrade pip \
    && pip install --no-cache-dir "setuptools<81" "." "ovos-tts-server>=1.13.5a1"

# Default language, overridable with the GTTS_LANG build arg (any gTTS lang works).
ARG GTTS_LANG=en
RUN useradd -m -u 1000 ovos \
    && mkdir -p /home/ovos/.config/mycroft \
    && printf '{\n  "tts": {\n    "module": "ovos-tts-plugin-google-tx",\n    "ovos-tts-plugin-google-tx": {\n      "lang": "%s"\n    }\n  }\n}\n' "${GTTS_LANG}" \
        > /home/ovos/.config/mycroft/mycroft.conf \
    && chown -R 1000:1000 /home/ovos/.config
USER 1000

EXPOSE 9666
ENTRYPOINT ["ovos-tts-server", "--engine", "ovos-tts-plugin-google-tx", \
            "--host", "0.0.0.0", "--port", "9666", "--cache"]
