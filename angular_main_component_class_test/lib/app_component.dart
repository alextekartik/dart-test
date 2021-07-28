// Copyright (c) 2017, alex. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:angular2/core.dart';
import 'package:angular_components/angular_components.dart';

import 'hello_dialog/hello_dialog.dart';

@Component(
  selector: 'my-app',
  styleUrls: ['app_component.css'],
  templateUrl: 'app_component.html',
  directives: [materialDirectives, HelloDialog],
  providers: [materialProviders],
)
class AppComponent {
  // Nothing here yet. All logic is in HelloDialog.
}
