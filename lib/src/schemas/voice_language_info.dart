/// A representation of `TTSVoiceLanguageInfo` schema.
class VoiceLanguageInfo {
  /// {@template flowery.voiceLanguageInfo}
  /// Create a new [VoiceLanguageInfo] instance
  /// {@endtemplate}.
  VoiceLanguageInfo({required this.name, required this.code});

  /// {@macro flowery.voiceLanguageInfo} {@macro flowery.fromMap}
  factory VoiceLanguageInfo.fromMap(Map<String, dynamic> map) =>
      VoiceLanguageInfo(
        name: map['name'] as String,
        code: map['code'] as String,
      );

  /// Name of the language; with optional country name.
  final String name;

  /// Code name of the language.
  final String code;

  late final _nameSplits = name.split('(');

  /// Name of the language without country name.
  late final nameWithoutCountry = _nameSplits.first.trimRight();

  /// Name of the country.
  late final country =
      _nameSplits.length == 1 ? null : _nameSplits.last.split(')').first;

  /// {@macro flowery.toMap}
  Map<String, String> toMap() => {'name': name, 'code': code};

  /// {@macro flowery.toString}
  @override
  String toString() => 'VoiceLanguageInfo(name: $name, code: $code)';
}
