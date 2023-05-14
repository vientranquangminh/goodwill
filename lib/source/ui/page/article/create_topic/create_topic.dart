import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:goodwill/gen/colors.gen.dart';
import 'package:goodwill/source/common/extensions/build_context_ext.dart';
import 'package:goodwill/source/common/widgets/app_toast/app_toast.dart';
import 'package:goodwill/source/data/model/article_model.dart';
import 'package:goodwill/source/service/article_service.dart';
import 'package:goodwill/source/service/auth_service.dart';
import 'package:goodwill/source/ui/page/article/custom_topic/custom_topic.dart';
import 'package:goodwill/source/util/file_helper.dart';
import 'package:goodwill/source/service/cloud_storage_service.dart';

import 'component/container_content.dart';

const List<String> item = ['Donate', 'Buy'];

class CreateTopic extends StatefulWidget {
  const CreateTopic({super.key});

  @override
  State<CreateTopic> createState() => _CreateTopicState();
}

class _CreateTopicState extends State<CreateTopic> {
  late List<File> images;

  @override
  void initState() {
    images = [];
    super.initState();
  }

  final TextEditingController _titleTopic = TextEditingController();
  final TextEditingController _content = TextEditingController();
  File? image;
  String? getTextTopic;
  String type = '';
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            context.localizations.createNewTopic,
            style: const TextStyle(color: Colors.black, fontSize: 20),
          ),
          backgroundColor: Colors.transparent,
          leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              )),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.localizations.topicTitle,
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _titleTopic,
                  decoration: InputDecoration(
                      prefixIcon:
                          const Icon(Icons.topic_rounded, color: Colors.black),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.black, width: 2.0),
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16)),
                      hintText: context.localizations.yourTopicTitle,
                      hintStyle: const TextStyle(
                          color: Colors.grey,
                          fontSize: 15,
                          fontWeight: FontWeight.w400)),
                ),
                const SizedBox(height: 30),
                Text(
                  context.localizations.type,
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 10),
                SizedBox(
                    height: 40,
                    child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: item.length,
                        itemBuilder: (context, index) {
                          type = item[selectedIndex];
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedIndex = index;
                              });
                            },
                            child: CustomTopicContainer(
                              hour: item[index],
                              buttonColor: selectedIndex == index
                                  ? Colors.black
                                  : Colors.white,
                              textColor: selectedIndex == index
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          );
                        })),
                const SizedBox(height: 25),
                Text(
                  context.localizations.image,
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.w500),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 20.h),
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(12.r)),
                    border: Border.all(
                        color: ColorName.black,
                        style: BorderStyle.solid,
                        width: 1),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              '${context.localizations.image}: ',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: (images.isEmpty || images.length > 6)
                                      ? Colors.red
                                      : Colors.green),
                            ),
                          ),
                          const Spacer(),
                          IconButton(
                            onPressed: () {
                              FileHelper.browseImages(handleFiles: (files) {
                                setState(() {
                                  images = files;
                                });
                              });
                            },
                            icon: const Icon(Icons.camera_alt),
                          ),
                        ],
                      ),
                      GridView.builder(
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 4),
                        itemCount: images.length,
                        itemBuilder: (context, int index) {
                          return SizedBox(
                            width: 100,
                            height: 100,
                            child: Container(
                              margin: const EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                border: Border.all(
                                  color: Colors.grey,
                                  width: 2.0,
                                ),
                              ),
                              child: Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(
                                      child: (index <= 5)
                                          ? Image.file(
                                              images[index],
                                              fit: BoxFit.cover,
                                            )
                                          : Opacity(
                                              opacity: 0.4,
                                              child: Image.file(
                                                images[index],
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                    ),
                                  ),
                                  Positioned(
                                    top: -20,
                                    right: -20,
                                    child: IconButton(
                                      icon: const Icon(Icons.cancel),
                                      onPressed: () {
                                        setState(() {
                                          images.removeAt(index);
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                Text(
                  context.localizations.content,
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 10),
                ContainerOfContent(
                  content: _content,
                ),
                SizedBox(height: MediaQuery.of(context).size.height / 22),
                SizedBox(
                    width: double.infinity,
                    child: RawMaterialButton(
                      elevation: 0.0,
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100.0)),
                      fillColor: const Color.fromARGB(255, 0, 0, 0),
                      onPressed: () async {
                        if (images.isEmpty) {
                          Fluttertoast.showToast(
                              msg: 'Please choose one picture');
                          return;
                        }
                        String? type = item[selectedIndex].toLowerCase();
                        String? title = _titleTopic.text;
                        String? content = _content.text;
                        File image = images[0];

                        var res = await CloudStorageService.uploadImage(image,
                            destination:
                                FileHelper.getStorageArticleImagePath(image));
                        ArticleModel articleModel = ArticleModel(
                            title: title,
                            ownerId: AuthService.userId,
                            type: type,
                            createdAt: DateTime.now(),
                            image: res,
                            content: content);

                        ArticleService.addArticle(articleModel).then((value) {
                          Navigator.pop(context);
                          AppToasts.showToast(
                              context: context, title: 'Post Topic Success');
                        }).catchError((error) {
                          AppToasts.showErrorToast(
                              title: 'Can not post topic', context: context);
                        });
                      },
                      child: Text(context.localizations.upload,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w500)),
                    ))
              ],
            ),
          ),
        ));
  }
}
