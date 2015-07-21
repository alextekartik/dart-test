@TestOn("vm")

library test_test;

import 'package:test/test.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'test_script_dir.dart';

void main() {
  group('Platform', () {
    test('script', () {
      /*
      print('Platform.script: ${Platform.script}');
      print(new File(Platform.script.toFilePath()).readAsStringSync());
      var declarer = Zone.current[#test.declarer];
      print(declarer);
      print('testScriptDir: ${testScriptDir}');
      Invoker invoker = Invoker.current;
      print(invoker);
      print(invoker.liveTest.test.name);
      */
      expect(basename(testScriptPath), 'test_test.dart');
      expect(FileSystemEntity.isFileSync(testScriptPath), isTrue);
      //print('Isolate: ${Isolate.current.}');
      //return new Completer().future;
    });
  });
}
