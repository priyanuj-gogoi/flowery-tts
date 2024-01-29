/// A representation of `TTSVoiceLanguageInfo` schema.
class VoiceLanguageInfo {
  VoiceLanguageInfo._({required this.name, required this.code})
      : _nameSplits = name.split('(');

  /// {@macro flowery.fromMap}
  factory VoiceLanguageInfo.fromMap(Map<String, dynamic> map) =>
      VoiceLanguageInfo._(
        name: map['name'] as String,
        code: map['code'] as String,
      );

  /// Name of the language; with optional country name.
  final String name;

  /// Code name of the language.
  final String code;

  final List<String> _nameSplits;

  /// Name of the language without country name.
  String get nameWithoutCountry => _nameSplits.first.trimRight();

  /// Name of the country.
  String? get country =>
      _nameSplits.length == 1 ? null : _nameSplits.last.split(')').first;

  /// {@macro flowery.toMap}
  Map<String, String> toMap() => {'name': name, 'code': code};

  /// {@macro flowery.toString}
  @override
  String toString() => 'VoiceLanguageInfo(name: $name, code: $code)';
}
