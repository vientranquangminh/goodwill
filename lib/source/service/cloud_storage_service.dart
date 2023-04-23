import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path/path.dart';

import 'package:goodwill/source/util/file_helper.dart';

class CloudStorageService {
  static final _storageRef = FirebaseStorage.instance.ref();

  static Future<TaskSnapshot?> uploadImage(File imageFile,
      {required String destination}) async {
    if (imageFile.existsSync()) {
      try {
        final uploadTask =
            await _storageRef.child(destination).putFile(imageFile);

        // TODO: Handle when uploading images

        return uploadTask;
      } on FirebaseException catch (e) {
        debugPrint('Uploading Image: ${e.message}');
      }
    } else {
      Fluttertoast.showToast(msg: "The file does not exist");
    }
    return null;
  }

  static Future<String?> getDownloadUrl(String sourcePath) async {
    try {
      return _storageRef.child(sourcePath).getDownloadURL();
    } on FirebaseException catch (e) {
      debugPrint('Getting Image: ${e.message}');
    }
  }

  static Future<String> getSampleDownloadUrl() async {
    return await getDownloadUrl("keyboard.png") ?? '';
  }
}
