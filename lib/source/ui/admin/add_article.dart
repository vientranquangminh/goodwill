import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:goodwill/gen/colors.gen.dart';
import 'package:goodwill/source/common/extensions/build_context_ext.dart';
import 'package:goodwill/source/common/widgets/custom_button/primary_button.dart';
import 'package:goodwill/source/ui/admin/add_product.dart';
import 'package:goodwill/source/ui/admin/widget/components/appbar_admin.dart';
import 'package:goodwill/source/util/file_helper.dart';

class AddArticle extends StatefulWidget {
  const AddArticle({super.key});

  @override
  State<AddArticle> createState() => _AddArticleState();
}

class _AddArticleState extends State<AddArticle> {
  late List<File> images;

  @override
  void initState() {
    images = [];
    super.initState();
  }

  final TextEditingController _titleTopic = TextEditingController();
  final TextEditingController _content = TextEditingController();
  final TextEditingController _type = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _monthController = TextEditingController();
  final TextEditingController _yearController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200],
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AppBarAdmin(),
            Padding(
              padding: const EdgeInsets.all(40.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                'Add Article',
                                style: TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.w800),
                              ),
                              Text(
                                'Add New Article',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w800),
                              )
                            ]),
                        Container(
                            height: 40,
                            width: MediaQuery.of(context).size.width / 7,
                            margin: const EdgeInsets.all(20),
                            child: PrimaryButton(
                              radius: 16,
                              buttonColor: Colors.black,
                              customFunction: () {},
                              fontSize: 16,
                              text: context.localizations.post,
                              textColor: Colors.white,
                            ))
                      ],
                    ),
                  ),
                  Input(
                      controller: _titleTopic,
                      text: context.localizations.title),
                  Input(controller: _type, text: context.localizations.type),
                  Input(
                      controller: _content,
                      text: context.localizations.content),
                  Input(controller: _dateController, text: 'Date'),
                  Input(controller: _monthController, text: 'Month'),
                  Input(controller: _yearController, text: 'Year'),
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
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
