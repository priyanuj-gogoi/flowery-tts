import 'package:flowery_tts/src/enums.dart';
import 'package:flowery_tts/src/schemas/voice_language_info.dart';

/// A representation of `TTSVoice` schema.
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

  /// Name of the speaker.
  final String name;

  /// The type of voice gender.
  final Gender gender;

  /// Name of the voice source; where it was taken from.
  final String source;

  /// The assigned language of the voice.
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

  // The use of same first doc line of `toString()` here is intentional.
  // This is for hiding the other `toString()` default documentations.

  /// {@template flowery.toString}
  /// A string representation of this object.
  /// {@endtemplate}
  @override
  String toString() => 'Voice(name: $name, gender: $gender, '
      'source: $source, language: $language)';
}
