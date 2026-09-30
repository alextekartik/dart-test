# dart-test

Simple Dart experiments, kept as a pub workspace (`dart pub get` at the root).

## audio_test

A web audio sample (`dart:web_audio`): play a generated note, a file, an
oscillator. Build with `dart run build_runner serve` from `audio_test/` (or
`dart compile js web/audio_test.dart`).

## key_range_test

Test of the `dart:indexed_db` `KeyRange` getters (`lower`, `upper`, `lowerOpen`,
`upperOpen`), written in 2015 when some of them crashed. Run with
`dart test -p chrome` from `key_range_test/`.

## lib_test

`mylib` and `myapp`: an app depending on a lib by path. `dart run bin/myapp.dart`
from `lib_test/myapp/`.

## Removed on 2026-09-30

Dart 1 era experiments that could not move to Dart 3: angular, polymer and
core/paper elements demos, bootstrap carousel, Google custom search, the
`route` package, `googleapis_auth` with `dart_to_js_script_rewriter`, the
`window.indexedDB.getDatabaseNames` test (API removed from browsers), a 2018
dart2js bug repro (fixed), and `test_test` (its script path hack relied on
`Platform.script` pointing at the test file, which the test runner has not done
since Dart 2).
