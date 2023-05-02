import 'dart:io';

import 'package:flutter/material.dart';
import 'package:goodwill/source/data/model/product_model.dart';
import 'package:goodwill/source/service/cloud_storage_service.dart';
import 'package:goodwill/source/service/product_service.dart';
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
      filePaths.add(await res?.ref.getDownloadURL() ?? '');
    }

    return filePaths;
  }

  Future<void> _submit() async {
    var myProduct = ProductModel.sample;

    myProduct.images = await _uploadImagesToStorage();

    ProductService.addProduct(myProduct);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          TextButton(
            onPressed: () {},
            child: const Text('Test'),
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
