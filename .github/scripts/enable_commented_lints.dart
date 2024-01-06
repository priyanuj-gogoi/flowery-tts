#! /usr/bin/env dart
// ignore_for_file: avoid_print

import 'dart:io';

void main() {
  final version = Platform.version;

  final major = int.parse(version[0]);
  final minor = int.parse(version[2]);

  if (major >= 3 && (major > 3 || minor >= 1)) {
    const paddingWithDash = '    -';

    final buffer = StringBuffer()
      ..writeln('$paddingWithDash no_self_assignments')
      ..writeln('$paddingWithDash no_wildcard_variable_uses');

    var isAnnotateRedeclaresEnabled = false;

    if (major > 3 || minor >= 2) {
      buffer.write('$paddingWithDash annotate_redeclares');
      isAnnotateRedeclaresEnabled = true;
    }

    try {
      final currentDirPath = Directory.current.path;

      final path = StringBuffer(currentDirPath)
        ..write(Platform.pathSeparator)
        ..write('analysis_options.yaml');

      final file = File(path.toString());

      if (!file.existsSync()) {
        print(
          'Error: Failed to find "analysis_options.yaml" file in the '
          'current working directory "$currentDirPath".',
        );
        exit(1);
      }

      file.writeAsStringSync(buffer.toString(), mode: FileMode.append);

      print('Added "no_self_assignments" lint!');
      print('Added "no_wildcard_variable_uses" lint!');

      if (isAnnotateRedeclaresEnabled) {
        print('Added "annotate_redeclares" lint!');
      }
    } on PathAccessException catch (error) {
      final buffer = StringBuffer('Error: ')
        ..write(error.message)
        ..write(error.path == null ? '.' : ' "${error.path!}".')
        ..write(error.osError == null ? '' : ' ${error.osError!.message}.');

      print(buffer);
      exit(error.osError?.errorCode ?? 1);
    }
  }
}
