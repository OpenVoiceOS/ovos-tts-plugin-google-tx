# ovos-tts-plugin-google-tx

OVOS TTS plugin that synthesises speech via the undocumented Google Translate speech endpoint, wrapping the `gTTS` library.

## Setup

```
pip install .
```

Runtime deps: `ovos-plugin-manager>=1.0.0,<3.0.0` and `gTTS`.

## Test

No test suite exists. `setup.py` defines no test deps and there is no `tests/` directory. Manual smoke test:

```
python -m ovos_tts_plugin_google_tx
```

The `__main__` block in `ovos_tts_plugin_google_tx/__init__.py` synthesises sample phrases (Dutch, English regional accents, Portuguese) to `.mp3` files in the cwd. This requires network access to Google Translate.

## Lint/Typecheck

None configured.

## Layout

- `ovos_tts_plugin_google_tx/__init__.py` — the entire plugin: `GoogleTranslateTTS(TTS)` and the `REGIONAL_CONFIGS` accent/tld map.
- `ovos_tts_plugin_google_tx/version.py` — version constants consumed by `setup.py`.
- Entry point group: `mycroft.plugin.tts` → `GoogleTranslateTTS`. Config module name: `ovos-tts-plugin-google-tx`.

`get_tts(sentence, wav_file, lang, voice)` standardizes the lang tag, maps known regional tags to a `lang`+`tld` pair via `REGIONAL_CONFIGS`, otherwise strips the region subtag, then calls `gTTS().save()`. `voice` is unsupported. Output is mp3 (`audio_ext="mp3"`). `available_languages` is derived from `gtts.lang.tts_langs()`.

## Conventions (org hard rules)

- Branches: `dev` (work) and `master` (stable). NEVER `main`.
- Never edit `version.py`; gh-automations bump semver from conventional-commit prefixes (`feat:`/`fix:`/`feat!:`).
- New repos private by default.
- Commit identity: JarbasAi <jarbasai@mailfence.com>.
- Reference reusable workflows at `@dev`.
- No Neon / `neon-*` references.
- No meta-commentary (no history, dates, or design narrative) in docs, commits, code comments, or PRs — describe current state only.
- CI is provided by the shared gh-automations workflows.

## Gotchas

- Leverages an undocumented Google Translate endpoint; can break without notice and is unsuitable for production/commercial use.
- CI `build_tests.yml` and `license_tests.yml` call `neongeckocom/.github` and pin reusable workflows at `@master`; `publish_stable.yml`/`release_workflow.yml` call `TigreGotico/gh-automations@master`. Org convention is `OpenVoiceOS/gh-automations` reusable workflows pinned at `@dev`.
- `build_tests.yml` manifest check ignores `test/**` though no tests exist.
- `tld` defaults to `com`; can be overridden in config to route around network blocks of `google.com` or to force accents.
- `lang_check` defaults to `False`, so invalid langs fail only at request time.
