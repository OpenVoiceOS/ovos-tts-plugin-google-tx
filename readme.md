## Description
Mycroft TTS plugin for [gTTS](https://github.com/pndurette/gTTS)

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

```json
  "tts": {
    "module": "ovos-tts-plugin-google-tx",
    "ovos-tts-plugin-google-tx": {
      "lang": "es"
    }
 
```
