import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:goodwill/gen/assets.gen.dart';
import 'package:goodwill/gen/colors.gen.dart';
import 'package:goodwill/source/common/extensions/build_context_ext.dart';
import 'package:goodwill/source/common/extensions/text_style_ext.dart';
import 'package:goodwill/source/common/widgets/app_bar/custom_app_bar.dart';
import 'package:goodwill/source/common/widgets/app_toast/app_toast.dart';
import 'package:goodwill/source/data/model/product_model.dart';
import 'package:goodwill/source/service/auth_service.dart';
import 'package:goodwill/source/service/cloud_storage_service.dart';
import 'package:goodwill/source/service/product_service.dart';
import 'package:goodwill/source/ui/page/post/widgets/rounded_container.dart';
import 'package:goodwill/source/util/constant.dart';
import 'package:goodwill/source/util/file_helper.dart';
import 'package:intl/intl.dart';

class Post extends StatefulWidget {
  const Post({super.key});

  @override
  State<Post> createState() => _PostState();
}

class _PostState extends State<Post> {
  int quantity = 1;

  String? dropdownValue;
  bool isFree = false;
  List<File> images = [];
  //final TextEditingController _CategoryController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  var formatter = NumberFormat('#,##,000');

  int selectedIndex = 0;
  Future<List<String>> _uploadImagesToStorage() async {
    List<String> filePaths = [];
    for (var image in images) {
      var imagePath = await CloudStorageService.uploadImage(image,
          destination: FileHelper.getStorageProductImagePath(image));
      filePaths.add(imagePath ?? Constant.SAMPLE_AVATAR_URL);
    }

    return filePaths;
  }

  Future<void> _submit() async {
    var myProduct = ProductModel.sample;

    myProduct.images = await _uploadImagesToStorage();

    ProductService.addProduct(myProduct);
  }

  Future<String> _getCurrentPositionFromCoordinates() async {
    Position position = await _getCurrentLocation();
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    return '${placemarks[0].subThoroughfare} ${placemarks[0].thoroughfare}, ${placemarks[0].subAdministrativeArea}. ${placemarks[0].administrativeArea}';
  }

  Future<Position> _getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Locator service is not allowed');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Something went wrong');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error('This feature is permanently denined');
    }
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  @override
  Widget build(BuildContext context) {
    var items = [
      context.localizations.clothes,
      context.localizations.shoes,
      context.localizations.bags,
      context.localizations.electronic,
      context.localizations.watch,
      context.localizations.jewelry,
      context.localizations.kitchen,
      context.localizations.toys,
    ];
    List<String> selections = [
      context.localizations.used,
      context.localizations.genericNew,
    ];
    return Scaffold(
      backgroundColor: ColorName.white,
      appBar: CustomAppBar(
        titleColor: ColorName.black,
        backgroundColor: ColorName.white,
        leading: Assets.svgs.mainIcon.svg(),
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
                Text(context.localizations.category,
                    style: context.blackS16W700),
                SizedBox(
                  height: 5.h,
                ),
                InputDecorator(
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                  ),
                  isEmpty: dropdownValue == '',
                  child: DropdownButtonHideUnderline(
                    child: Container(
                      height: 50,
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius:
                              BorderRadius.all(Radius.circular(10.r))),
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
                        style: const TextStyle(
                          fontSize: 16.0,
                          color: Colors.black,
                        ),
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 0.0),
                          filled: true,
                          border: InputBorder.none,
                          fillColor:
                              Colors.transparent, // Optional background color
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  alignment: Alignment.topLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        context.localizations.image,
                        style: context.blackS16W700,
                      ),
                    ],
                  ),
                ),
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
                          );
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Text(
                  context.localizations.status,
                  style: context.blackS16W700,
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
                      value: isFree,
                      onChanged: (val) {
                        setState(() {
                          isFree = val!;
                        });
                        isFree
                            ? _priceController.text = '0'
                            : _priceController.clear();
                      }),
                  Text(context.localizations.giveAway),
                ]),
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  context.localizations.title,
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10.h,
                ),
                TextFormField(
                  keyboardType: TextInputType.text,
                  controller: _titleController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.all(
                        Radius.circular(16),
                      ),
                    ),
                    labelText: context.localizations.titleLabel,
                  ),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return context.localizations.enterTitle;
                    } else if (value![0] == ' ') {
                      return context.localizations.enterTitle;
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  context.localizations.price,
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10.h,
                ),
                TextFormField(
                  enabled: isFree == false,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    ThousandsSeparatorInputFormatter(),
                  ],
                  controller: _priceController,
                  validator: (value) {
                    if (value == null) {
                      return context.localizations.plsInputPrice;
                    }
                    final valueRemovingComma = value.trim().replaceAll(',', '');
                    return int.tryParse(valueRemovingComma) == null
                        ? 'Please enter number only'
                        : null;
                  },
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                    ),
                    labelText: context.localizations.example,
                    suffixText: Constant.VN_CURRENCY,
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Row(
                  children: [
                    Text(
                      context.localizations.quantity,
                      style: context.blackS16W500,
                    ),
                    SizedBox(
                      width: 20.w,
                    ),
                    _selectQuantityWidget(quantity, context, () {
                      if (quantity < 2) {
                        quantity = 2;
                      }
                      setState(() {
                        quantity--;
                      });
                    }, () {
                      setState(() {
                        quantity++;
                      });
                    })
                  ],
                ),
                SizedBox(
                  height: 12.h,
                ),
                Text(
                  context.localizations.description,
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  minLines: 1,
                  maxLines: 7,
                  controller: _descriptionController,
                  textInputAction: TextInputAction.newline,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                    ),
                    labelText: context.localizations.detailDescription,
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  context.localizations.address,
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10.h,
                ),
                FutureBuilder(
                  future: _getCurrentPositionFromCoordinates(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return TextFormField(
                        controller: _addressController,
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value?.isEmpty ?? true) {
                            return context.localizations.plsEnterAddress;
                          } else if (value![0] == ' ') {
                            return context.localizations.plsEnterAddress;
                          } else {
                            return null;
                          }
                        },
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(16)),
                          ),
                          labelText: 'Loading...',
                        ),
                      );
                    }
                    if (snapshot.hasData) {
                      log(snapshot.data ?? 'no value');
                      return TextFormField(
                        controller: _addressController
                          ..text = snapshot.data.toString(),
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value?.isEmpty ?? true) {
                            return context.localizations.plsEnterAddress;
                          } else if (value![0] == ' ') {
                            return context.localizations.plsEnterAddress;
                          } else {
                            return null;
                          }
                        },
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(16)),
                          ),
                          // labelText: snapshot.data.toString(),
                        ),
                      );
                    } else {
                      return TextFormField(
                        controller: _addressController,
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value?.isEmpty ?? true) {
                            return context.localizations.plsEnterAddress;
                          } else if (value![0] == ' ') {
                            return context.localizations.plsEnterAddress;
                          } else {
                            return null;
                          }
                        },
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(16)),
                          ),
                          labelText: 'Da Nang city',
                        ),
                      );
                    }
                  },
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.black,
                        minimumSize: const Size(80, 40),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Post(),
                            ));
                      },
                      child: Text(context.localizations.cancel),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.black,
                          minimumSize: const Size(80, 40)),
                      onPressed: () async {
                        if (!_formKey.currentState!.validate() ||
                            images.isEmpty ||
                            images.length > 6) {
                          Fluttertoast.showToast(
                              msg: context.localizations.plsCorrectMe);
                          return;
                        }
                        String? category = dropdownValue;
                        String? title = _titleController.text;
                        int? price = int.parse(
                            _priceController.text.replaceAll(',', ''));
                        String? description = _descriptionController.text;
                        String? location = _addressController.text;
                        List<String>? imagesPaths = [];

                        for (var image in images) {
                          final imagePath =
                              await CloudStorageService.uploadImage(image,
                                  destination:
                                      FileHelper.getStorageProductImagePath(
                                          image));
                          imagesPaths
                              .add(imagePath ?? Constant.SAMPLE_AVATAR_URL);
                        }

                        if (imagesPaths.isEmpty) {
                          Fluttertoast.showToast(
                              msg: context.localizations.uploadImageFailed);
                        }

                        ProductModel productModel = ProductModel(
                          title: title,
                          ownerId: AuthService.userId,
                          category: category,
                          createdAt: DateTime.now(),
                          price: price,
                          description: description,
                          location: location,
                          images: imagesPaths,
                          status: OwnProductStatus.SHOWING,
                        );

                        ProductService.addProduct(productModel).then((value) {
                          context.pop();
                          AppToasts.showToast(
                              context: context,
                              title: context.localizations.postProductSuccess);
                        }).catchError((error) {
                          AppToasts.showErrorToast(
                              title: context.localizations.canNotPostProduct,
                              context: context);
                        });
                      },
                      child: Text(context.localizations.post),
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

Widget _selectQuantityWidget(int text, BuildContext context,
    VoidCallback subtractFunc, VoidCallback addFunc) {
  return Container(
    decoration: BoxDecoration(
        color: const Color.fromARGB(255, 236, 236, 236),
        borderRadius: BorderRadius.all(Radius.circular(30.r))),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        PlatformIconButton(
          padding: EdgeInsets.zero,
          icon: const Icon(
            Icons.remove,
            color: ColorName.black,
          ),
          onPressed: subtractFunc,
        ),
        SizedBox(
          width: 5.w,
        ),
        Text(
          text.toString(),
          style: context.blackS16W500,
        ),
        SizedBox(
          width: 5.w,
        ),
        PlatformIconButton(
          padding: EdgeInsets.zero,
          icon: const Icon(Icons.add, color: ColorName.black),
          onPressed: addFunc,
        )
      ],
    ),
  );
}

class ThousandsSeparatorInputFormatter extends TextInputFormatter {
  static const separator = ',';

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) {
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
        if ((chars.length - 1 - i) % 3 == 0 && i != chars.length - 1) {
          newString = separator + newString;
        }
        newString = chars[i] + newString;
      }

      return TextEditingValue(
        text: newString.toString(),
        selection: TextSelection.collapsed(
          offset: newString.length - selectionIndex,
        ),
      );
    }

    return newValue;
  }
}
