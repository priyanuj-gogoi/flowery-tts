// ignore_for_file: constant_identifier_names

/// The various supported audio output formats.
enum AudioFormat {
  /// Advanced Audio Codec, a widely used audio format known
  /// for its efficiency in delivering high-quality sound at
  /// lower bitrates, often used in streaming and mobile devices.
  aac._(),

  /// Free Lossless Audio Codec, a lossless compression format that
  /// preserves audio quality without sacrificing file size.
  flac._(),

  /// Common audio format using lossy compression, widely supported and
  /// known for its good balance between file size and audio quality.
  mp3._(),

  /// OGG container format with Opus audio codec, providing high-quality
  /// and low-latency compression suitable for various applications.
  ogg_opus._(),

  /// OGG container format with Vorbis audio codec, offering a good
  /// balance between audio quality and file size in a free and open format.
  ogg_vorbis._(),

  /// Waveform Audio File Format, an uncompressed audio format
  /// often used for high-quality, professional audio recordings.
  wav._();

  const AudioFormat._();
}

/// The different types of voice gender.
enum Gender {
  /// A girl, a lady, or a woman.
  Female._(),

  /// A boy, a guy, or a man.
  Male._();

  const Gender._();
}
