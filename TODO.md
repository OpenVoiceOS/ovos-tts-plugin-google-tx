# TODO

## Open issues

- [ ] #26 Dependency Dashboard (Renovate)

## Gaps

- [ ] No test suite (no `tests/`); `build_tests.yml` manifest ignores a non-existent `test/**`.
- [ ] CI references Neon: `build_tests.yml` and `license_tests.yml` use `neongeckocom/.github/.github/workflows/...@master`. Migrate to `OpenVoiceOS/gh-automations` reusable workflows.
- [ ] Reusable workflows in `publish_stable.yml` / `release_workflow.yml` point at `TigreGotico/gh-automations@master` and are pinned at `@master`; org convention is `OpenVoiceOS/gh-automations` at `@dev`.
- [ ] No coverage workflow.
- [ ] No `opm-check` workflow despite declaring a `mycroft.plugin.tts` entry point.
- [ ] Packaging uses legacy `setup.py` + `requirements.txt`; no `pyproject.toml`.
- [ ] Scratch artifact `gtts.mp3` is tracked but not referenced anywhere (only `gtts.png` is used in the README).
- [ ] `ovos_tts_plugin_google_tx.egg-info/` directory present in the working tree (gitignored; should not be committed).

## Code TODOs

None found.
