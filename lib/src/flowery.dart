import 'dart:convert';
import 'dart:typed_data';

import 'package:http/http.dart';

import 'enums.dart';
import 'exceptions.dart';
import 'models.dart';

/// The main class of this library.
class Flowery {
  /// Create a new instance of this class.
  ///
  /// If a [Client] instance is provided in `httpClient` parameter,
  /// do make sure to [close] the client after all requests are done.
  /// Check [Client.close] for more details.
  const Flowery({final Client? httpClient}) : _httpClient = httpClient;

  final Client? _httpClient;

  Future<Uint8List> _request(
    final String path, [
    final Map<String, String>? queryParams,
  ]) async {
    final Response(
      :body,
      :bodyBytes,
      :request,
      :statusCode,
    ) = await (_httpClient?.get ?? get)(
      apiUrl.replace(path: 'v$apiVersion/$path', queryParameters: queryParams),
      headers: {'user-agent': 'flowery_tts/$version'},
    );

    if (statusCode == 200) return bodyBytes;
    final url = request!.url;

    switch (statusCode) {
      case 404:
        throw FloweryException('Invalid route: "$url".');
      case 405:
        throw FloweryException('HTTP GET method not allowed on route "$url".');
      default:
        late final Map<String, dynamic> json;

        try {
          json = jsonDecode(body) as Map<String, dynamic>;
        } on FormatException {
          throw const FloweryException(
            'Failed to parse response body as JSON!',
          );
        }

        final error = json['error'] as String;

        throw switch (statusCode) {
          400 => InvalidArgumentsException(error),
          422 => ValidationException(error),
          500 => FloweryException(error),
          _ => FloweryException('Unhandled status code: $statusCode.')
        };
    }
  }

  /// Close the underlying API client.
  ///
  /// This method should to be called only when a [Client]
  /// was provided in [Flowery()]'s `httpClient` parameter.
  void close() => _httpClient?.close();

  /// Convert this `text` into a raw audio speech.
  ///
  /// The output of audio type is `mono`.
  /// Validation of inputs are handled by the API.
  Future<Uint8List> tts({
    // The text to convert. It has a maximum of 2000 characters length limit.
    required final String text,

    // Name of the voice speaker.
    required final String voice,

    // Whether to translate the given non-english language text
    // to English. By default, it's false.
    final bool? translate,

    // A specific duration of leading & trailing silence sound to wrap
    // to the speech. The duration must not be more than 10 seconds.
    // By default, it's 0.
    final Duration? silence,

    // The format of audio type to output. By default, it's mp3.
    final AudioFormat? audioFormat,

    // The speed rate of the speech. Value must be in-between
    // 0.5 to 100. By default, it's 1.0.
    final double? speed,
  }) async {
    if (text.trimLeft().isEmpty) {
      throw const InvalidArgumentsException(
        'No valid text was provided in "text" parameter.',
      );
    }

    if (voice.trimLeft().isEmpty) {
      throw const InvalidArgumentsException(
        'Expected a non-empty string in "voice" parameter.',
      );
    }

    return _request('tts', {
      'text': text,
      'voice': voice,
      if (translate != null) 'translate': translate.toString(),
      if (silence != null) 'silence': silence.inMilliseconds.toString(),
      if (audioFormat != null) 'audio_format': audioFormat.name,
      if (speed != null) 'speed': speed.toStringAsFixed(1),
    });
  }

  /// Get information of all voices.
  Future<VoicesResponse> voices() async {
    final response = await _request('tts/voices');
    final json = jsonDecode(utf8.decode(response)) as Map<String, dynamic>;
    return VoicesResponse.fromMap(json);
  }

  /// OpenAPI specification URL of the API.
  static final apiOpenApiUrl = apiUrl.replace(path: 'openapi.json');

  /// Base URL of the API.
  static final apiUrl = Uri.https('api.flowery.pw');

  /// The API version being used.
  static const apiVersion = '1';

  /// The current version of this package.
  static const version = '1.2.0';
}
