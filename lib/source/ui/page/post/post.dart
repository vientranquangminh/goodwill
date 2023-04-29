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
import 'package:goodwill/source/ui/page/profile/widgets/edit_profile_widgets/textfield_custom.dart';
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
  Controller = TextEditingController();
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
  var productType = [
    'productType 1',
    'productType 2',
    'productType 3',
    'productType 4',
    'productType 5',
    'productType 6',
    'productType 7',
    'productType 8',
    'productType 9',
    'productType 10',
  ];
  var material = [
    'material 1',
    'material 2',
    'material 3',
    'material 4',
    'material 5',
    'material 6',
    'material 7',
    'material 8',
    'material 9',
    'material 10',
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
                height: 100.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(12.r)),
                  border: Border.all(
                      color: ColorName.black,
                      style: BorderStyle.solid,
                      width: 1),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Assets.images.raidenShogun.image(height: 50, width: 50),
                    SizedBox(
                      height: 10.h,
                    ),
                    // Text(
                    //   'From 01-06 images',
                    //   style: TextStyle(
                    //     fontWeight: FontWeight.bold,
                    //     fontSize: 16.sp,
                    //     color: ColorName.black,
                    //   ),
                    // )
                    Column(
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
                  ],
                ),
              ),
              Container(
                height: 100.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(12.r)),
                  border: Border.all(
                      color: ColorName.black,
                      style: BorderStyle.solid,
                      width: 1),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Assets.images.raidenShogun.image(height: 50, width: 50),
                    SizedBox(
                      height: 10.h,
                    ),
                    Text(
                      'Maximum 1 video',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.sp,
                        color: ColorName.black,
                      ),
                    )
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
                height: 8.h,
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
                height: 5.h,
              ),
              const Text(
                'Product Type',
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
                    hint: const Text('productType'),
                    isDense: true,
                    onChanged: (value) {
                      setState(() {
                        dropdownValue = value!;
                      });
                    },
                    items: productType.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
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
                    hint: const Text('material'),
                    isDense: true,
                    onChanged: (value) {
                      setState(() {
                        dropdownValue = value!;
                      });
                    },
                    items: material.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                const Text('I want to give away for free.'),
                Checkbox(
                    checkColor: Colors.greenAccent,
                    value: valueFirst,
                    onChanged: (val) {
                      setState(() {
                        valueFirst = val!;
                      });
                    }),
              ]),
              const TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                  ),
                  labelText: 'Price',
                ),
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
                  labelText: 'Title',
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
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                  ),
                  labelText: 'Detailed Description',
                ),
              ),
              const SizedBox(
                height: 8,
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
                'You are: ',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  Expanded(
                    child: RadioListTile<people>(
                        contentPadding: const EdgeInsets.all(0.0),
                        value: people.Individual,
                        groupValue: _people,
                        title: Text(people.Individual.name),
                        onChanged: (val) {
                          setState(() {
                            _people = val;
                          });
                        }),
                  ),
                  Expanded(
                    child: RadioListTile<people>(
                        contentPadding: const EdgeInsets.all(0.0),
                        value: people.Professional,
                        groupValue: _people,
                        title: Text(people.Professional.name),
                        onChanged: (val) {
                          setState(() {
                            _people = val;
                          });
                        }),
                  ),
                ],
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
                  labelText: 'Address',
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size(70, 40),
                        primary: Colors.green,
                        onPrimary: Colors.white),
                    onPressed: () {},
                    child: const Text('Preview'),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size(70, 40),
                        primary: Colors.green,
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
