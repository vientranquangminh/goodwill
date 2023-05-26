import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:goodwill/gen/colors.gen.dart';
import 'package:goodwill/source/common/extensions/build_context_ext.dart';
import 'package:goodwill/source/common/widgets/custom_button/primary_button.dart';
import 'package:goodwill/source/ui/admin/widget/components/appbar_admin.dart';
import 'package:goodwill/source/util/file_helper.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  List<Uint8List?> images = [];
  final TextEditingController _categoryController = TextEditingController();

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
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
                                'Add Product',
                                style: TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.w800),
                              ),
                              Text(
                                'Add New Product',
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
                      controller: _categoryController,
                      text: context.localizations.category),
                  Input(
                      controller: _titleController,
                      text: context.localizations.title),
                  Input(
                      controller: _priceController,
                      text: context.localizations.price),
                  Input(
                      controller: _descriptionController,
                      text: context.localizations.description),
                  Input(
                      controller: _addressController,
                      text: context.localizations.address),
                  Input(controller: _dateController, text: 'Day'),
                  Input(controller: _monthController, text: 'Month'),
                  Input(controller: _yearController, text: 'Year'),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 0.h),
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
                                context.localizations
                                    .selectedImage(images.length),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                            ),
                            const Spacer(),
                            IconButton(
                              onPressed: () {
                                FileHelper.browseWebImages(
                                    handleFiles: (files) {
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
                            return Container(
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
                                          // ? Image.file(
                                          //     images[index],
                                          //     fit: BoxFit.cover,
                                          //   )
                                          ? Image.memory(
                                              images[index]!,
                                              fit: BoxFit.cover,
                                            )
                                          : Opacity(
                                              opacity: 0.4,
                                              // child: Image.file(
                                              //   images[index],
                                              //   fit: BoxFit.cover,
                                              // ),
                                              child: Image.memory(
                                                images[index]!,
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

class Input extends StatelessWidget {
  const Input({
    super.key,
    required this.text,
    required this.controller,
  });

  final TextEditingController controller;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
            hintText: text,
            border: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.black, width: 2.0),
                borderRadius: BorderRadius.circular(8))),
      ),
    );
  }
}
