// Copyright (c) 2017, alex. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.
import 'dart:html';

import 'package:angular2/platform/browser.dart';

import 'package:angular_main_component_class_test/app_component.dart';

main() async {
  print("before bootstrap: ${document.querySelector("my-app").classes}");
  await bootstrap(AppComponent);
  print("after bootstrap: ${document.querySelector("my-app").classes}");
}
