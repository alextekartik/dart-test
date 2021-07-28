@TestOn("browser")
library key_range_test;

import 'package:test/test.dart';
import 'dart:indexed_db';

main() {
  test('only', () {
    KeyRange keyRange = new KeyRange.only(1);
    expect(keyRange.lower, equals(1));
    expect(keyRange.upper, equals(1));
  });

  test('lower', () {
    KeyRange keyRange = new KeyRange.lowerBound(1, true);
    expect(keyRange.lower, equals(1));
    expect(keyRange.lowerOpen, isTrue);
    expect(keyRange.upper, isNull); // Aw snap! crash
    expect(keyRange.upperOpen, isTrue); // Somehow this is true by default
  });

  test('upper', () {
    KeyRange keyRange = new KeyRange.upperBound(1, true);
    expect(keyRange.upper, equals(1));
    expect(keyRange.upperOpen, isTrue);
    expect(keyRange.lower, isNull); // Aw snap! crash
    expect(keyRange.lowerOpen, isTrue); // Somehow this is true by default
  });

  test('bound', () {
    KeyRange keyRange = new KeyRange.bound(1, 2);
    expect(keyRange.lower, equals(1));
    expect(keyRange.lowerOpen, isFalse);
    expect(keyRange.upper, equals(2));
    expect(keyRange.upperOpen, isFalse);
  });
}
