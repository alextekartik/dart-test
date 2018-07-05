import 'dart:async';
import 'package:test/test.dart';

bool callbackIsNull;

class Test2 {
  Future test(void callback()) async {
    callbackIsNull = callback == null;
    return new Future.value();
  }
}

class Test {
  Future test(
    int param,
    void callback(),
  ) async {
    // check params
    if ((param == null) != (callback == null)) {
      throw new ArgumentError('param and callback must be specified together');
    }

    await new Test2().test(callback);
  }
}

void main() {
  test('bug', () async {
    callbackIsNull = true;
    void callback() {
      print("callback");
    }

    await new Test().test(1, callback);
    expect(callbackIsNull, isFalse);
  });
}
