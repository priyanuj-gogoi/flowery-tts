## 1.1.0

- Privatize `Voice`, `VoiceLanguageInfo`, and `VoicesResponse` unnamed constructors.
- Correct value type mapping of `VoicesResponse.toMap()`'s `voices` key.
- Deprecate `VoicesResponse.getVoice()` method in favor of `VoicesResponse[]`.
- Mark late properties of `Voice`, `VoiceLanguageInfo`, and `VoicesResponse` as getters.
- Fix charset encoding of diacritic characters in language name.

## 1.0.0

- Initial release.
