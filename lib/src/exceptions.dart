/// A representation of "TTSError" schema.
class FloweryException implements Exception {
  /// Create a new [FloweryException] instance.
  const FloweryException(this.error);

  /// The message describing about this exception.
  final String error;

  /// {@macro flowery.toString}
  @override
  String toString() => 'FloweryException: $error';
}

/// A representation of "TTSInvalidArguments" schema.
class InvalidArgumentsException extends FloweryException {
  /// Create a new [InvalidArgumentsException] instance.
  const InvalidArgumentsException(super.error);

  @override
  String toString() => 'InvalidArgumentsException: $error';
}

/// A representation of "ValidationError" schema.
class ValidationException extends FloweryException {
  /// Create a new [ValidationException] instance.
  const ValidationException(super.error);

  @override
  String toString() => 'ValidationException: $error';
}
