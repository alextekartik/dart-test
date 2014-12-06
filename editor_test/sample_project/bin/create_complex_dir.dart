import 'package:tekartik_io_tools/file_utils.dart';
import 'package:tekartik_core/dev_utils.dart';
import 'package:tekartik_io_tools/platform_utils.dart';
import 'package:path/path.dart';
import 'dart:async';

main() {

  // src is the project (../..)
  String rootSrcDir = dirname(scriptDirPath);
  String projectName = basename(rootSrcDir);
  // output to ../../tmp
  String rootDstDir = join(dirname(rootSrcDir), 'tmp');
  //String outDir = join(dirname(dirname(scriptDirPath)), 'tmp');

  emptyOrCreateDirSync(rootDstDir);

  // create the project copying the relevant sources (i.e. not the packages folder)
  // return the new source dir
  Future<String> _createSourceProject() {
    String dstDir = join(rootDstDir, projectName);
    String srcDir = rootSrcDir;
    return deployEntitiesIfNewer(srcDir, dstDir, ['pubspec.yaml', 'build.dart', join("lib", "main_app.dart"), join("lib", "main_app.html"), join("web", "index.html")]).then((_) {
      return dstDir;
    });
  }

  return _createSourceProject().then((srcDir) {
    // create a bunch of copy in folders and subfolders
    List<Future> list = [];
    for (int i = 0; i < 100; i++) {
      String dst = join(rootDstDir, "prj${i}");
      list.add(linkOrCopyFilesInDirIfNewer(srcDir, dst));

      dst = join(rootDstDir, "sub${i}", "prj${i}");
      list.add(linkOrCopyFilesInDirIfNewer(srcDir, dst));

      dst = join(rootDstDir, "sub", "prj${i}");
      list.add(linkOrCopyFilesInDirIfNewer(srcDir, dst));

      dst = join(rootDstDir, "sub", "sub", "prj${i}");
      list.add(linkOrCopyFilesInDirIfNewer(srcDir, dst));
    }
    return Future.wait(list);
  });

//  print(srcDir);
//  print(rootDstDir);
//  emptyOrCreateDirSync(rootDstDir);
//  List<Future> list = [];
//  for (int i = 0; i < 15; i++) {
//    String dst = join(rootDstDir, "dir${i}");
//    list.add(linkOrCopyFilesInDirIfNewer(srcDir, dst));
//  }

}
