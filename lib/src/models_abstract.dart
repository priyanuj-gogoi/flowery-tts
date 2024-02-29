import 'enums.dart';

/// A model of `TTSVoice` schema.
abstract interface class TTSVoice {
  /// The gender of this voice.
  Gender get gender;

  /// The preferred language for this voice.
  TTSVoiceLanguageInfo get language;

  /// Name of the voice speaker.
  String get name;

  /// Name of the voice source.
  String get source;
}

/// A model of `TTSVoiceLanguageInfo` schema.
abstract interface class TTSVoiceLanguageInfo {
  /// Code name of the language.
  String get code;

  /// Name of the language with optionally including its region.
  String get name;
}

/// A model of `TTSVoicesResponse` schema.
abstract interface class TTSVoicesResponse {
  /// The number of [TTSVoice] instances in [voices].
  int get count;

  /// A complete list of available voices.
  List<TTSVoice> get voices;
}
