## 1.1.0

- Privatize `Voice`, `VoiceLanguageInfo`, and `VoicesResponse` unnamed constructors.
- Fix serialization of `VoicesResponse.toMap()`'s `voices` key.
- Deprecate `VoicesResponse.getVoice()` method in favor of `VoicesResponse[]`.
- Mark late properties of `Voice`, `VoiceLanguageInfo`, and `VoicesResponse` as getters.
- Fix character encoding of certain language names which were not correctly represented.

## 1.0.0

- Initial release.
