@TestOn('browser')
library;

import 'dart:indexed_db';

import 'package:test/test.dart';

void main() {
  test('only', () {
    var keyRange = KeyRange.only(1);
    expect(keyRange.lower, equals(1));
    expect(keyRange.upper, equals(1));
  });

  test('lower', () {
    var keyRange = KeyRange.lowerBound(1, true);
    expect(keyRange.lower, equals(1));
    expect(keyRange.lowerOpen, isTrue);
    expect(keyRange.upper, isNull); // Aw snap! crash (2015)
    expect(keyRange.upperOpen, isTrue); // Somehow this is true by default
  });

  test('upper', () {
    var keyRange = KeyRange.upperBound(1, true);
    expect(keyRange.upper, equals(1));
    expect(keyRange.upperOpen, isTrue);
    expect(keyRange.lower, isNull); // Aw snap! crash (2015)
    expect(keyRange.lowerOpen, isTrue); // Somehow this is true by default
  });

  test('bound', () {
    var keyRange = KeyRange.bound(1, 2);
    expect(keyRange.lower, equals(1));
    expect(keyRange.lowerOpen, isFalse);
    expect(keyRange.upper, equals(2));
    expect(keyRange.upperOpen, isFalse);
  });
}
