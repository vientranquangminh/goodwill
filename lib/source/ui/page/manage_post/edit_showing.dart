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
import 'package:goodwill/source/util/constant.dart';
import 'package:goodwill/source/util/file_helper.dart';
import 'package:intl/intl.dart';

class EditShowing extends StatefulWidget {
  const EditShowing({super.key});

  @override
  State<EditShowing> createState() => _EditShowingState();
}

class _EditShowingState extends State<EditShowing> {
  int quantity = 1;

  String? dropdownValue;
  bool isFree = false;
  List<File> images = [];
  //final TextEditingController _CategoryController = TextEditingController();
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
      context.localizations.electronics,
      context.localizations.watch,
      context.localizations.jewelry,
      context.localizations.kitchen,
      context.localizations.toys,
    ];

    final arguments = context.getParam() as ProductModel;
    final TextEditingController titleController =
        TextEditingController(text: arguments.title);
    final TextEditingController priceController =
        TextEditingController(text: arguments.price.toString());
    final TextEditingController descriptionController =
        TextEditingController(text: arguments.description);
    final TextEditingController addressController =
        TextEditingController(text: arguments.location);
    final TextEditingController categoryController =
        TextEditingController(text: arguments.category);
    return Scaffold(
        backgroundColor: ColorName.white,
        appBar: CustomAppBar(
          titleColor: ColorName.black,
          backgroundColor: ColorName.white,
          leading: Assets.svgs.mainIcon.svg(),
          title: "Edit Post",
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            child: Form(
                key: _formKey,
                child: FutureBuilder<ProductModel?>(
                  future: ProductService.get(arguments.id ?? ""),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                        child: Text('Loading...'),
                      );
                    }
                    if (snapshot.hasError) {
                      return const Text('Something goes wrong!!');
                    } else {
                      ProductModel? productmd = snapshot.data;
                      return Column(
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
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(10.r))),
                                child: DropdownButtonFormField<String>(
                                  value: dropdownValue,
                                  hint: Text(productmd?.category ?? ''),
                                  isDense: true,
                                  onChanged: (value) =>
                                      setState(() => dropdownValue = value!),
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
                                    contentPadding:
                                        EdgeInsets.symmetric(horizontal: 0.0),
                                    filled: true,
                                    border: InputBorder.none,
                                    fillColor: Colors.transparent,
                                  ),
                                ),
                              ),
                            ),
                          ),
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
                            controller: titleController,
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
                            controller: priceController,
                            validator: (value) {
                              if (value == null) {
                                return context.localizations.plsInputPrice;
                              }
                              final valueRemovingComma =
                                  value.trim().replaceAll(',', '');
                              return int.tryParse(valueRemovingComma) == null
                                  ? 'Please enter number only'
                                  : null;
                            },
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(16)),
                              ),
                              labelText: context.localizations.example,
                              suffixText: 'VND',
                            ),
                          ),
                          const SizedBox(
                            height: 15,
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
                          const SizedBox(
                            height: 15,
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
                            controller: descriptionController,
                            textInputAction: TextInputAction.newline,
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(16)),
                              ),
                              labelText:
                                  context.localizations.detailDescription,
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
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return TextFormField(
                                  controller: addressController,
                                  keyboardType: TextInputType.text,
                                  validator: (value) {
                                    if (value?.isEmpty ?? true) {
                                      return context
                                          .localizations.plsEnterAddress;
                                    } else if (value![0] == ' ') {
                                      return context
                                          .localizations.plsEnterAddress;
                                    } else {
                                      return null;
                                    }
                                  },
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(16)),
                                    ),
                                    labelText: 'Loading...',
                                  ),
                                );
                              }
                              if (snapshot.hasData) {
                                log(snapshot.data ?? 'no value');
                                return TextFormField(
                                  controller: addressController
                                    ..text = snapshot.data.toString(),
                                  keyboardType: TextInputType.text,
                                  validator: (value) {
                                    if (value?.isEmpty ?? true) {
                                      return context
                                          .localizations.plsEnterAddress;
                                    } else if (value![0] == ' ') {
                                      return context
                                          .localizations.plsEnterAddress;
                                    } else {
                                      return null;
                                    }
                                  },
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(16)),
                                    ),
                                  ),
                                );
                              } else {
                                return TextFormField(
                                  controller: addressController,
                                  keyboardType: TextInputType.text,
                                  validator: (value) {
                                    if (value?.isEmpty ?? true) {
                                      return context
                                          .localizations.plsEnterAddress;
                                    } else if (value![0] == ' ') {
                                      return context
                                          .localizations.plsEnterAddress;
                                    } else {
                                      return null;
                                    }
                                  },
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(16)),
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
                                  context.pop();
                                },
                                child: Text(context.localizations.cancel),
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    foregroundColor: Colors.white,
                                    backgroundColor: Colors.black,
                                    minimumSize: const Size(80, 40)),
                                onPressed: () async {
                                  if (!_formKey.currentState!.validate()) {
                                    Fluttertoast.showToast(
                                        msg:
                                            context.localizations.plsCorrectMe);
                                    return;
                                  }
                                  String? category = dropdownValue;
                                  String? title = titleController.text;
                                  int? price = int.parse(
                                      priceController.text.replaceAll(',', ''));
                                  String? description =
                                      descriptionController.text;
                                  String? location = addressController.text;
                                  ProductModel productModel = ProductModel(
                                    id: arguments.id,
                                    title: title,
                                    ownerId: AuthService.userId,
                                    category: category,
                                    createdAt: DateTime.now(),
                                    price: price,
                                    description: description,
                                    location: location,
                                    //images: imagesPaths,
                                    status: OwnProductStatus.SHOWING,
                                    quantity: quantity,
                                  );
                                  log(productModel.toString());
                                  ProductService.updateProduct(productModel)
                                      .then((value) {
                                    context.pop();
                                    AppToasts.showToast(
                                        context: context,
                                        title: context
                                            .localizations.postProductSuccess);
                                  }).catchError((error) {
                                    AppToasts.showErrorToast(
                                        title: context
                                            .localizations.canNotPostProduct,
                                        context: context);
                                  });
                                },
                                child: Text(context.localizations.update),
                              ),
                            ],
                          ),
                        ],
                      );
                    }
                  },
                )),
          ),
        ));
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
