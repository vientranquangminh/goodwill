import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:goodwill/source/data/model/article_model.dart';
import 'package:goodwill/source/service/article_service.dart';
import 'package:goodwill/source/service/cloud_storage_service.dart';
import 'package:goodwill/source/ui/page/article/dummy/list_article.dart';
import 'package:goodwill/source/util/file_helper.dart';

class Post extends StatefulWidget {
  const Post({super.key});

  @override
  State<Post> createState() => _PostState();
}

class _PostState extends State<Post> {
  late List<File> images;

  @override
  void initState() {
    images = [];
    super.initState();
  }

  Future<List<String>> _uploadImagesToStorage() async {
    List<String> filePaths = [];
    for (var image in images) {
      var res = await CloudStorageService.uploadImage(image,
          destination: FileHelper.getStorageProductImagePath(image));
      filePaths.add(res ?? '');
    }

    return filePaths;
  }

  Future<String> _uploadSingleImageToStorage() async {
    String filePath = "";
    File image = images[0];

    var res = await CloudStorageService.uploadImage(image,
        destination: FileHelper.getStorageArticleImagePath(image));
    return await res ?? '';
  }

  Future<void> _submit() async {
    var myArticle = ArticleModel.sample;

    myArticle.image = await _uploadSingleImageToStorage();

    ArticleService.addArticle(myArticle);
  }

  void _uploadSampleArticles() {
    listArticles.forEach(ArticleService.addArticle);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          TextButton(
            onPressed: () {
              _uploadSampleArticles();
            },
            child: const Text('Upload sample articles'),
          ),
          TextButton(
            onPressed: () {
              FileHelper.browseImages(handleFiles: (files) {
                setState(() {
                  images = files;
                });
              });
            },
            child: const Text('Browse Images'),
          ),
          SizedBox(
            height: 10.h,
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3),
              itemCount: images.length,
              itemBuilder: (context, int index) {
                return Card(
                  child: Image.file(images[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
