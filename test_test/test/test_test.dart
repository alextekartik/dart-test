@TestOn("vm")

library test_test;

import 'package:test/test.dart';
import 'package:test/src/backend/invoker.dart';
import 'dart:io';
import 'dart:async';
import 'dart:isolate';
import 'package:path/path.dart';
import 'test_script_dir.dart';

void main() {
  group('Platform', () {
    test('script', () {
      print('Platform.script: ${Platform.script}');
      print(new File(Platform.script.toFilePath()).readAsStringSync());
      var declarer = Zone.current[#test.declarer];
      print(declarer);
      print('testScriptDir: ${testScriptDir}');
      Invoker invoker = Invoker.current;
      print(invoker);
      print(invoker.liveTest.test.name);
      //print('Isolate: ${Isolate.current.}');
      //return new Completer().future;
    });
  });
}
