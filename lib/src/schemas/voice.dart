import 'package:flowery_tts/src/enums.dart';
import 'package:flowery_tts/src/schemas/voice_language_info.dart';

/// A model of `TTSVoice` schema which contains voice information.
class Voice {
  const Voice._({
    required this.name,
    required this.gender,
    required this.source,
    required this.language,
  });

  /// {@template flowery.fromMap}
  /// Create a new instance of this class from a Map.
  /// {@endtemplate}
  factory Voice.fromMap(Map<String, dynamic> map) => Voice._(
        name: map['name'] as String,
        gender: Gender.values.byName(map['gender'] as String),
        source: map['source'] as String,
        language: VoiceLanguageInfo.fromMap(
          map['language'] as Map<String, dynamic>,
        ),
      );

  /// Name of the voice speaker.
  final String name;

  /// The gender of this voice.
  final Gender gender;

  /// Name of the source from where this voice was taken.
  final String source;

  /// The assigned language of this voice.
  final VoiceLanguageInfo language;

  /// Whether this voice's gender is male.
  bool get isMale => gender == Gender.Male;

  /// Whether this voice's gender is female.
  bool get isFemale => gender == Gender.Female;

  /// {@template flowery.toMap}
  /// A map representation of this object.
  /// {@endtemplate}
  Map<String, Object> toMap() => {
        'name': name,
        'gender': gender.name,
        'source': source,
        'language': language.toMap(),
      };

  // The reuse of default toString()'s first documentation line
  // is intentional here to hide it's other inherited parts.

  /// {@template flowery.toString}
  /// A string representation of this object.
  /// {@endtemplate}
  @override
  String toString() => 'Voice(name: $name, gender: $gender, '
      'source: $source, language: $language)';
}
