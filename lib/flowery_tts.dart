/// Wraps Flowery Text-to-Speech API.
///
/// - [Website](https://flowery.pw)
/// - [API Docs](https://flowery.pw/docs)
/// - [OpenAPI Specification][1]
///
/// [1]: https://editor.swagger.io/?url=https://api.flowery.pw/openapi.json
library;

export 'src/enums.dart';
export 'src/exceptions.dart';
export 'src/flowery.dart';

// API Models
export 'src/schemas/voice.dart';
export 'src/schemas/voice_language_info.dart';
export 'src/schemas/voices_response.dart';
