import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:goodwill/source/service/auth_service.dart';
import 'package:path/path.dart' as p;

class FileHelper {
  FileHelper._();

  static Future<File> changeFileNameOnly(File file, String newFileName) {
    var path = file.path;
    var lastSeparator = path.lastIndexOf(Platform.pathSeparator);
    var newPath = path.substring(0, lastSeparator + 1) + newFileName;
    return file.rename(newPath);
  }

  static String getStorageAvatarPath(File file, {String? userEmail}) {
    userEmail ??= AuthService.user?.email;
    String extension = FileHelper.getFileExtension(file);
    String dest = 'images/users/$userEmail/profilePicture/avatar$extension';

    return dest;
  }

  static String getStorageProductImagePath(File file, {String? userEmail}) {
    userEmail ??= AuthService.user?.email;
    // String extension = FileHelper.getFileExtension(file);
    String fileName = p.basename(file.path);
    String dest = 'images/users/$userEmail/products/$fileName';

    return dest;
  }

  static String getStorageArticleImagePath(File file, {String? userEmail}) {
    userEmail ??= AuthService.user?.email;
    String fileName = p.basename(file.path);
    String dest = 'images/users/$userEmail/articles/$fileName';

    return dest;
  }

  static String getFileExtension(File file) {
    return p.extension(file.path);
  }

  static void browseSingleImage({Function(File)? handleFile}) async {
    final res = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.image,
    );
    if (res == null) {
      Fluttertoast.showToast(msg: "Fail to browse this image");
      return;
    }

    String filePath = res.files.single.path!;
    File file = File(filePath);
    if (!file.existsSync()) {
      debugPrint('File does not exist');
      return;
    }
    (handleFile != null) ? handleFile(file) : null;
  }

  static void browseImages({Function(List<File>)? handleFiles}) async {
    final res = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.image,
    );
    if (res == null) {
      Fluttertoast.showToast(msg: "Fail to browse this images");
      return;
    }

    try {
      List<File> files = res.files.map((file) => File(file.path!)).toList();
      (handleFiles != null) ? handleFiles(files) : null;
    } on Exception catch (e) {
      debugPrint('Fail to browse images, ${e.toString()}');
    }
  }
}
