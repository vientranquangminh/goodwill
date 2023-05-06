import 'dart:io';

import 'package:flutter/material.dart';
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
          destination: FileHelper.getStorageArticleImagePath(image));
      filePaths.add(await res?.ref.getDownloadURL() ?? '');
    }

    return filePaths;
  }

  Future<String> _uploadSingleImageToStorage() async {
    String filePath = "";
    File image = images[0];

    var res = await CloudStorageService.uploadImage(image,
        destination: FileHelper.getStorageArticleImagePath(image));
    return await res?.ref.getDownloadURL() ?? '';
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
          Expanded(
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
          Expanded(
            child: Center(
              child: Container(
                decoration: const BoxDecoration(color: Colors.blueAccent),
                child: TextButton(
                    onPressed: () {
                      _submit();
                    },
                    child: const Text(
                      'Submit posts',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
              ),
            ),
          )
        ],
      ),
    );
  }
}
