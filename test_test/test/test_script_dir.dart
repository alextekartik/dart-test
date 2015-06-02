library test_utils.test_script_dir;

import 'dart:io';
import 'package:path/path.dart';

// temp workaround using test package
String get testScriptDir {
  String scriptFilePath = Platform.script.toFilePath();
  print(scriptFilePath);
  if (scriptFilePath.endsWith("runInIsolate.dart")) {

    // Let's look for this line:
    // import "file:///path_to_my_test/test_test.dart" as test;

    String importLineBegin = 'import "file://';
    String importLineEnd = '" as test;';
    int importLineBeginLength = importLineBegin.length;

    String scriptContent = new File.fromUri(Platform.script).readAsStringSync();

    int beginIndex = scriptContent.indexOf(importLineBegin);
    if (beginIndex > -1) {
      int endIndex = scriptContent.indexOf(importLineEnd, beginIndex + importLineBeginLength);
      if (endIndex > -1) {
        scriptFilePath = scriptContent.substring(beginIndex + importLineBegin.length, endIndex);
      }
    }
  }
  return dirname(scriptFilePath);
}