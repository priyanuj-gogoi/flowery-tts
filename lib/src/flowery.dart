import 'dart:convert';
import 'dart:typed_data';

import 'package:flowery_tts/src/enums.dart';
import 'package:flowery_tts/src/exceptions.dart';
import 'package:flowery_tts/src/schemas/voices_response.dart';

import 'package:http/http.dart';

/// Main class for interacting with the API.
class Flowery {
  /// Create a new [Flowery] instance.
  const Flowery();

  Future<Response> _fetch(String path, [Map<String, String>? query]) async {
    final response = await get(
      apiUrl.replace(path: 'v$apiVersion/$path', queryParameters: query),
      headers: {'user-agent': 'flowery_tts/$version'},
    );

    if (response.statusCode != 200) {
      final BaseRequest(:method, :url) = response.request!;
      final body = jsonDecode(response.body) as Map<String, dynamic>;

      throw switch (response.statusCode) {
        400 => InvalidArgumentsException(body['error'] as String),
        404 => FloweryException('Invalid request route: "$url".'),
        405 => FloweryException(
            'HTTP $method method isn\'t allowed on route "$url".',
          ),
        422 => ValidationException(
            'Request to "$url" has failed due to some fields were '
            'not provided or were given invalid inputs.',
          ),
        500 => FloweryException(body['error'] as String),
        _ => const FloweryException(
            'An unknown error has occurred while processing this request.',
          )
      };
    }

    return response;
  }

  /// Convert the provided `text` into speech (mono audio).
  ///
  /// **text** - The text to convert (max. `2000` characters limit).
  ///
  /// **voice** - Name of the voice speaker.
  ///
  /// **translate** - Whether to translate non-english `text` to
  /// English speech. Defaults to `false`.
  ///
  /// **silence** - Wrap the speech with a leading & trailing silent sound.
  /// The duration must not be greater than `10` seconds. Defaults to `0`.
  ///
  /// **audioFormat** - The format of audio to output.
  /// Defaults to [AudioFormat.mp3].
  ///
  /// **speed**: The speed of the speech. Value must be or in
  /// between `0.5` & `100`. Defaults to `1.0`.
  Future<Uint8List> tts({
    required String text,
    required String voice,
    bool? translate,
    Duration? silence,
    AudioFormat? audioFormat,
    double? speed,
  }) async {
    final response = await _fetch('tts', {
      'text': text,
      'voice': voice,
      if (translate != null) 'translate': translate.toString(),
      if (silence != null) 'silence': silence.inMilliseconds.toString(),
      if (audioFormat != null) 'audio_format': audioFormat.name,
      if (speed != null) 'speed': speed.toString(),
    });

    return response.bodyBytes;
  }

  /// Get information about Flowery voices.
  Future<VoicesResponse> voices() async {
    final response = await _fetch('tts/voices');
    final json = jsonDecode(response.body) as Map<String, dynamic>;

    return VoicesResponse.fromMap(json);
  }

  /// OpenAPI specification URL of the API.
  static final apiOpenApiUrl = apiUrl.replace(path: 'openapi.json');

  /// Base URL of the API.
  static final apiUrl = Uri.https('api.flowery.pw');

  /// The API version being used.
  static const apiVersion = '1';

  /// The current version of this package.
  static const version = '1.1.0';
}
