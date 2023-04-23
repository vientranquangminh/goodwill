import 'dart:io';
import 'package:path/path.dart' as p;

class FileHelper {
  FileHelper._();

  static Future<File> changeFileNameOnly(File file, String newFileName) {
    var path = file.path;
    var lastSeparator = path.lastIndexOf(Platform.pathSeparator);
    var newPath = path.substring(0, lastSeparator + 1) + newFileName;
    return file.rename(newPath);
  }

  static String getFileExtension(File file) {
    return p.extension(file.path);
  }
}
