library key_range_test;

import 'package:unittest/html_config.dart';
import 'package:unittest/unittest.dart';
import 'dart:indexed_db';

main() {
  useHtmlConfiguration();
  
  test('only', () {
    KeyRange keyRange = new KeyRange.only(1);
    expect(keyRange.lower, equals(1));
    expect(keyRange.upper, equals(1));
  });
  
  test('lower', () {
    KeyRange keyRange = new KeyRange.lowerBound(1, true);
    expect(keyRange.lower, equals(1));
    expect(keyRange.lowerOpen, isTrue);
    expect(keyRange.upper, isNull);
    expect(keyRange.upperOpen, isNull);
  });
}