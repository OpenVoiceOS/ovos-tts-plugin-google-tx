## Description
OVOS TTS plugin for [gTTS](https://github.com/pndurette/gTTS)

### Disclaimer

[gTTS](https://github.com/pndurette/gTTS) is *not* affiliated with Google or Google Cloud. Breaking upstream changes *can* occur without notice. This project is leveraging the undocumented [Google Translate](https://translate.google.com) speech functionality and is *different* from [Google Cloud Text-to-Speech](https://cloud.google.com/text-to-speech/).

Usage of this plugin is in a somewhat legal grey area, it does exactly what your browser does when it presses the speak button in google translate. 

It can stop working at any time and should never be used in production or commercially!

![](./gtts.png)

## Install

`pip install ovos-tts-plugin-google-tx`

## Configuration

```json
  "tts": {
    "module": "ovos-tts-plugin-google-tx"
  }
 
```

### Extra options

you can override the language, otherwise system lang is used

the `tld` option can also be set to [force accents](https://gtts.readthedocs.io/en/latest/module.html#localized-accents) and is also useful when ``google.com`` might be blocked within a network but a local or different Google host not

```json
  "tts": {
    "module": "ovos-tts-plugin-google-tx",
    "ovos-tts-plugin-google-tx": {
      "lang": "pt-PT",
      "tld": "pt"
    }
```


