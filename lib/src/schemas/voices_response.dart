import 'package:flowery_tts/src/schemas/voice.dart';

/// A representation of `TTSVoicesResponse` schema.
class VoicesResponse {
  const VoicesResponse._({required this.count, required this.voices});

  /// {@macro flowery.fromMap}
  factory VoicesResponse.fromMap(Map<String, dynamic> map) => VoicesResponse._(
        count: map['count'] as int,
        voices: [
          for (final voice in map['voices'] as List)
            Voice.fromMap(voice as Map<String, dynamic>),
        ],
      );

  /// The total number of voices. Prefer this over `voices.length`.
  final int count;

  /// A list of voices.
  final List<Voice> voices;

  /// A list of female voices.
  List<Voice> get femaleVoices => [
        for (final voice in voices)
          if (voice.isFemale) voice,
      ];

  /// A list of male voices.
  List<Voice> get maleVoices => [
        for (final voice in voices)
          if (voice.isMale) voice,
      ];

  /// A list of language codes.
  List<String> get languageCodes =>
      {for (final voice in voices) voice.language.code}.toList();

  /// A list of language names.
  List<String> get languageNames =>
      {for (final voice in voices) voice.language.nameWithoutCountry}.toList();

  /// A list of voice sources.
  List<String> get sources =>
      {for (final voice in voices) voice.source}.toList();

  /// A list of speaker names.
  List<String> get speakers =>
      {for (final voice in voices) voice.name}.toList();

  /// {@macro flowery.getVoice}
  @Deprecated('Use get operator instead.')
  Voice? getVoice(String name) => this[name];

  /// {@macro flowery.toMap}
  Map<String, Object> toMap() => {
        'count': count,
        'voices': [for (final voice in voices) voice.toMap()],
      };

  /// {@macro flowery.toString}
  @override
  String toString() => 'VoicesResponse(count: $count, voices: $voices)';

  /// {@template flowery.getVoice}
  /// Fetch a [Voice] instance using it's `name` (case-insensitive).
  ///
  /// Return `null`, if it doesn't exists.
  /// {@endtemplate}
  Voice? operator [](String name) {
    for (final voice in voices) {
      if (voice.name.toLowerCase() == name.toLowerCase()) return voice;
    }
    return null;
  }
}
