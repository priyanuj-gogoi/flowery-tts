import 'dart:io';

// Import the package.
import 'package:flowery_tts/flowery_tts.dart';

// Source: https://en.m.wikipedia.org/wiki/Dart_(programming_language)
const paragraph = '''
Dart is a programming language designed by Lars Bak and Kasper Lund and
developed by Google. It can be used to develop web and mobile apps as
well as server and desktop applications.

Dart is an object-oriented, class-based, garbage-collected language with
C-style syntax. It can compile to machine code, JavaScript, or WebAssembly.
It supports interfaces, mixins, abstract classes, reified generics and
type inference.''';

// Main function.
void main() async {
  // Instantiate a new Flowery class.
  const flowery = Flowery();

  // Convert the given text.
  final audio = await flowery.tts(text: paragraph, voice: 'Anna');

  // Convert the raw audio output as an audio file.
  final file = File('audio.mp3')..writeAsBytesSync(audio);

  // ignore: avoid_print
  print('Saved audio file at "${file.absolute.path}".');
}
