library key_range_test;

import 'package:unittest/html_config.dart';
import 'package:unittest/unittest.dart';
import 'dart:html';

main() {
  useHtmlConfiguration();
  
  test('database name', () {
    print('salut');
    return window.indexedDB.getDatabaseNames().then((List<String> names) {
      print(names.runtimeType);
      print(names.length);
      for (String name in names) {
        print(name);
      }
    });
  });
}