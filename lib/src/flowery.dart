import 'dart:convert';
import 'dart:html' if (dart.library.io) 'dart:io';
import 'dart:typed_data';

import 'package:flowery_tts/src/enums.dart';
import 'package:flowery_tts/src/exceptions.dart';
import 'package:flowery_tts/src/schemas/voices_response.dart';

import 'package:http/http.dart';

/// The main class of this library.
class Flowery {
  /// Create a new instance of this class.
  const Flowery();

  Future<Response> _fetch(String path, [Map<String, String>? query]) async {
    final response = await get(
      apiUrl.replace(path: 'v$apiVersion/$path', queryParameters: query),
      headers: {'user-agent': 'flowery_tts/$version'},
    );

    if (response.statusCode != HttpStatus.ok) {
      final BaseRequest(:method, :url) = response.request!;
      final body = jsonDecode(response.body) as Map<String, dynamic>;

      throw switch (response.statusCode) {
        HttpStatus.badRequest =>
          InvalidArgumentsException(body['error'] as String),
        HttpStatus.notFound =>
          FloweryException('Invalid request route: "$url".'),
        HttpStatus.methodNotAllowed => FloweryException(
            'HTTP $method method isn\'t allowed on route "$url".',
          ),
        HttpStatus.unprocessableEntity => ValidationException(
            'Request to "$url" has failed due to some fields were '
            'not provided or were given invalid inputs.',
          ),
        HttpStatus.internalServerError =>
          FloweryException(body['error'] as String),
        _ => const FloweryException(
            'An unknown error has occurred while processing this request.',
          )
      };
    }

    return response;
  }

  /// Convert the provided `text` into speech.
  ///
  /// The output of audio type is `mono`.
  Future<Uint8List> tts({
    // The text to convert. It has a maximum of 2000 characters length limit.
    required String text,

    // Name of the voice speaker.
    required String voice,

    // Whether to translate the given non-english language text
    // to English. By default, it's false.
    bool? translate,

    // A specific duration of leading & trailing silence sound to wrap
    // to the speech. The duration must not be more than 10 seconds.
    // By default, it's 0.
    Duration? silence,

    // The format of audio type to output. By default, it's mp3.
    AudioFormat? audioFormat,

    // The speed rate of the speech. Value must be in-between
    // 0.5 to 100. By default, it's 1.0.
    double? speed,
  }) async {
    if (text.trimLeft().isEmpty) {
      throw const InvalidArgumentsException(
        'No valid text was provided in "text" parameter.',
      );
    }

    if (voice.trimLeft().isEmpty) {
      throw const InvalidArgumentsException(
        'You\'ve provided an empty string in "voice" parameter.',
      );
    }

    final response = await _fetch('tts', {
      'text': text,
      'voice': voice,
      if (translate != null) 'translate': translate.toString(),
      if (silence != null) 'silence': silence.inMilliseconds.toString(),
      if (audioFormat != null) 'audio_format': audioFormat.name,
      if (speed != null) 'speed': speed.toStringAsFixed(1),
    });

    return response.bodyBytes;
  }

  /// Fetch information of all available voices.
  Future<VoicesResponse> voices() async {
    final response = await _fetch('tts/voices');

    // Here, http package chooses ISO-8859-1 encoding instead of UTF-8 due to
    // the charset parameter missing in Content-Type response header and which
    // in turn leads to some characters not being correctly represented.
    // For example, å gets converted to Ã¥.
    //
    // To mitigate this issue, we've explicitly decoded raw UTF-8 bytes.
    final json =
        jsonDecode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;

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
