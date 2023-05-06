import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:goodwill/gen/colors.gen.dart';
import 'package:goodwill/source/common/extensions/build_context_ext.dart';
import 'package:goodwill/source/common/widgets/app_bar/custom_app_bar.dart';
import 'package:goodwill/source/data/model/product_model.dart';
import 'package:goodwill/source/service/cloud_storage_service.dart';
import 'package:goodwill/source/service/product_service.dart';
import 'package:goodwill/source/ui/page/post/widgets/rounded_container.dart';
import 'package:goodwill/source/util/file_helper.dart';
import 'package:intl/intl.dart';

class Post extends StatefulWidget {
  const Post({super.key});

  @override
  State<Post> createState() => _PostState();
}

class _PostState extends State<Post> {
  String? dropdownValue;
  bool valueFirst = false;
  List<File> images = [];
  //final TextEditingController _CategoryController = TextEditingController();
  final TextEditingController _TitleController = TextEditingController();
  final TextEditingController _PriceController = TextEditingController();
  final TextEditingController _DescriptionController = TextEditingController();
  final TextEditingController _AddressController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  var formatter = NumberFormat('#,##,000');
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
          child: Form(
            key: _formKey,
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
                    child: DropdownButtonFormField<String>(
                      value: dropdownValue,
                      elevation: dropdownValue.hashCode,
                      hint: Text(context.localizations.category),
                      isDense: true,
                      onChanged: (value) =>
                          setState(() => dropdownValue = value!),
                      validator: (value) =>
                          value == null ? 'field required' : null,
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
                              'Images: ${images.length}/6',
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
                TextFormField(
                  keyboardType: TextInputType.text,
                  controller: _TitleController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.all(
                        Radius.circular(16),
                      ),
                    ),
                    labelText: 'Example: Bags',
                  ),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please enter your Title';
                    } else if (value![0] == ' ') {
                      return 'Please enter your Title';
                    } else {
                      return null;
                    }
                  },
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
                TextFormField(
                  keyboardType: TextInputType.number,
                  // inputFormatters: [
                  //   ThousandsSeparatorInputFormatter(),
                  // ],
                  controller: _PriceController,
                  validator: (value) {
                    for (int i = 0; i < value!.length; i++) {
                      if (value[i] == ' ') {
                        return 'Please enter your Price';
                      }
                    }
                    bool _isNumeric(String result) {
                      if (result == null) {
                        return false;
                      }
                      return int.tryParse(result) != null;
                    }

                    // if (value?.isEmpty ?? true) {
                    //   return 'Please enter your Price';
                    // }
                    if (_isNumeric(value!) == false) {
                      return 'Please enter your Price';
                    } else {
                      return null;
                    }
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                    ),
                    labelText: 'Example: 30000',
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  maxLength: 1500,
                  maxLines: 7,
                  controller: _DescriptionController,
                  textInputAction: TextInputAction.newline,
                  decoration: const InputDecoration(
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
                  'Address ',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  controller: _AddressController,
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please enter Address';
                    } else if (value![0] == ' ') {
                      return 'Please enter Address';
                    } else {
                      return null;
                    }
                  },
                  decoration: const InputDecoration(
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
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Post(),
                            ));
                      },
                      child: const Text('Cancle'),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          minimumSize: const Size(80, 40),
                          primary: Colors.black,
                          onPrimary: Colors.white),
                      onPressed: () {
                        debugPrint(dropdownValue);
                        debugPrint(_TitleController.text);
                        debugPrint(_PriceController.text);
                        debugPrint(_DescriptionController.text);
                        debugPrint(_AddressController.text);
                        debugPrint('-------------------------');
                        if (_formKey.currentState!.validate()) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('oke')),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('not oke')),
                          );
                        }
                      },
                      child: const Text('Post'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ThousandsSeparatorInputFormatter extends TextInputFormatter {
  static const separator = ',';

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // TODO: implement formatEditUpdate
    if (newValue.text.length == 0) {
      return newValue.copyWith(text: '');
    }
    String oldValueText = oldValue.text.replaceAll(separator, '');
    String newValueText = newValue.text.replaceAll(separator, '');

    if (oldValue.text.endsWith(separator) &&
        oldValue.text.length == newValue.text.length + 1) {
      newValueText = newValueText.substring(0, newValueText.length - 1);
    }

    // Only process if the old value and new value are different
    if (oldValueText != newValueText) {
      int selectionIndex =
          newValue.text.length - newValue.selection.extentOffset;
      final chars = newValueText.split('');

      String newString = '';
      for (int i = chars.length - 1; i >= 0; i--) {
        if ((chars.length - 1 - i) % 3 == 0 && i != chars.length - 1)
          newString = separator + newString;
        newString = chars[i] + newString;
      }

      return TextEditingValue(
        text: newString.toString(),
        selection: TextSelection.collapsed(
          offset: newString.length - selectionIndex,
        ),
      );
    }

    // If the new value and old value are the same, just return as-is
    return newValue;
  }
}
