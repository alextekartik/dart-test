// Copyright (c) 2014, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:tekartik_io_tools/file_utils.dart';
import 'package:tekartik_io_tools/platform_utils.dart';
import 'package:path/path.dart';
main() {
  String dir = dirname(scriptDirPath);
  return dirSize(dir).then((int size) {
    print("project dir size: ${size}");
  });
}
