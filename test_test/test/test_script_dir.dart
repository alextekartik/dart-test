library test_utils.test_script_dir;

import 'dart:io';

String _getScriptPathFromIsolateContent(String scriptContent) {
  String _testScriptPath;
  // Let's look for this line:
  // import "file:///path_to_my_test/test_test.dart" as test;

  String importLineBegin = 'import "file://';
  String importLineEnd = '" as test;';
  String importOnly = 'import "';
  int importOnlyLength = importOnly.length;

  int beginIndex = scriptContent.indexOf(importLineBegin);
  if (beginIndex > -1) {
    int endIndex = scriptContent.indexOf(importLineEnd, beginIndex + importOnlyLength);
    if (endIndex > -1) {
      _testScriptPath = scriptContent.substring(beginIndex + importOnlyLength, endIndex);
    }
    // hack for windows
    _testScriptPath = Uri.parse(_testScriptPath).toFilePath();
  }

  return _testScriptPath;
}

// temp workaround using test package
String get testScriptPath {
  //print(Platform.script.scheme);
  String _testScriptPath;
  try {
    // in dart 1.12, scheme is data:application/dart;charset=utf-8, followed by dart content
    if (Platform.script.scheme == "data") {
      String content = Uri.decodeFull(Platform.script.toString());
      _testScriptPath = _getScriptPathFromIsolateContent(content);

    } else {
      _testScriptPath = Platform.script.toFilePath();

      // handle dart 1.11
      if (_testScriptPath.endsWith("runInIsolate.dart")) {
        String scriptContent = new File.fromUri(Platform.script).readAsStringSync();
        _testScriptPath = _getScriptPathFromIsolateContent(scriptContent);
      }
    }

  } catch (e) {
    stderr.writeln("Make sure you did call test either running 'dart xxx_test.dart' or 'pub run test' or 'pub run test test/xxx_test.dart' but not 'pub run test/xxx_dart'");
    stderr.writeln("Platform script: '${Platform.script}' must be a file path URI");
    throw e;
  }
  return _testScriptPath;
}