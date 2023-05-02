import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:goodwill/gen/assets.gen.dart';
import 'package:goodwill/gen/colors.gen.dart';
import 'package:goodwill/source/common/extensions/build_context_ext.dart';
import 'package:goodwill/source/common/widgets/app_bar/custom_app_bar.dart';
import 'package:goodwill/source/data/model/product_model.dart';
import 'package:goodwill/source/service/cloud_storage_service.dart';
import 'package:goodwill/source/service/product_service.dart';
import 'package:goodwill/source/ui/page/post/widgets/rounded_container.dart';
import 'package:goodwill/source/util/file_helper.dart';

enum people { Individual, Professional }

class Post extends StatefulWidget {
  const Post({super.key});

  @override
  State<Post> createState() => _PostState();
}

class _PostState extends State<Post> {
  String? dropdownValue;
  bool valueFirst = false;
  List<File> images = [];
  // var Controller = TextEditingController();
  var items = [
    'Clothes',
    'Shoes',
    'Bags',
    'Electronic',
    'Watch',
    'Jewelry',
    'Kitchen',
    'Toys',
  ];

  List<String> selections = ['Used', 'New'];
  int selectedIndex = 0;
  people? _people;

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
    return Scaffold(
      backgroundColor: ColorName.white,
      appBar: CustomAppBar(
        titleColor: ColorName.black,
        backgroundColor: ColorName.white,
        leading: PlatformIconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => context.pop(),
        ),
        title: context.localizations.upload,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Category',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 5.h,
              ),
              InputDecorator(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                isEmpty: dropdownValue == '',
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: dropdownValue,
                    hint: Text(context.localizations.category),
                    isDense: true,
                    onChanged: (value) {
                      setState(() {
                        dropdownValue = value!;
                      });
                    },
                    items: items.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Container(
                padding: const EdgeInsets.all(10),
                alignment: Alignment.topLeft,
                width: double.infinity,
                color: const Color.fromARGB(255, 223, 223, 223),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(context.localizations.details.toUpperCase()),
                    const Text('View more about ..........'),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 20.h),
                // height: 120.h,
                // width: double.infinity,
                padding: EdgeInsets.all(8.0),
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
                            'Images: ${images.length}/6',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: (images.isEmpty || images.length > 6)
                                    ? Colors.red
                                    : Colors.green),
                          ),
                        ),
                        Spacer(),
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
                                      // TODO: Remove image from gridview
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
              SizedBox(
                height: 10.h,
              ),
              const Text(
                'Status',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10.h,
              ),
              SizedBox(
                height: 40,
                width: 500,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: selections.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedIndex = index;
                        });
                      },
                      child: RoundedContainer(
                        padding: 10.w,
                        title: selections[index],
                        color: selectedIndex == index
                            ? ColorName.black
                            : const Color.fromARGB(255, 231, 231, 231),
                        radius: 16.r,
                        titleStyle: TextStyle(
                            color: selectedIndex == index
                                ? Colors.white
                                : Colors.black),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                Checkbox(
                    checkColor: Colors.white,
                    activeColor: Colors.black,
                    value: valueFirst,
                    onChanged: (val) {
                      setState(() {
                        valueFirst = val!;
                      });
                    }),
                const Text('I want to give away for free.'),
              ]),
              SizedBox(
                height: 10.h,
              ),
              const Text(
                'Title',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10.h,
              ),
              const TextField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.all(
                      Radius.circular(16),
                    ),
                  ),
                  labelText: 'Example: Bags',
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              const Text(
                'Prices',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10.h,
              ),
              const TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                  ),
                  labelText: 'Example: 30000',
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              const TextField(
                maxLength: 1500,
                maxLines: 7,
                textInputAction: TextInputAction.newline,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                  ),
                  labelText: 'Detailed Description',
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              const Text(
                'Seller information',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10.h,
              ),
              const TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                  ),
                  labelText: 'Seller information',
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              const Text(
                'Address ',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 8,
              ),
              const TextField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                  ),
                  labelText: 'Da Nang',
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(80, 40),
                      primary: Colors.black,
                      onPrimary: Colors.white,
                    ),
                    onPressed: () {},
                    child: const Text('Preview'),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size(80, 40),
                        primary: Colors.black,
                        onPrimary: Colors.white),
                    onPressed: () {},
                    child: const Text('Post'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
