/// The base class of all exceptions of this library.
///
/// This exception is based of `TTSVoice` schema and
/// can also be thrown for general error cases as well.
class FloweryException implements Exception {
  /// {@template flowery.exception}
  /// Create a new instance of this exception.
  /// {@endtemplate}
  const FloweryException(this.error);

  /// The message describing about this exception.
  final String error;

  /// {@macro flowery.toString}
  @override
  String toString() => 'FloweryException: $error';
}

/// Thrown when invalid data is provided in the API input.
///
/// This exception is based of `TTSInvalidArguments` schema.
class InvalidArgumentsException extends FloweryException {
  /// {@macro flowery.exception}
  const InvalidArgumentsException(super.error);

  @override
  String toString() => 'InvalidArgumentsException: $error';
}

/// Thrown when a required field/input is not provided to the API.
///
/// This exception is based of `TTSValidationException` schema.
class ValidationException extends FloweryException {
  /// {@macro flowery.exception}.
  const ValidationException(super.error);

  @override
  String toString() => 'ValidationException: $error';
}
