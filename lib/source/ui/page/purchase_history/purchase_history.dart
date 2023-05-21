import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:goodwill/gen/assets.gen.dart';
import 'package:goodwill/source/common/extensions/build_context_ext.dart';
import 'package:goodwill/source/common/widgets/custom_button/primary_button.dart';

class PurchaseHistoryModel {
  String image;
  String owner;
  String title;
  String categories;
  int quantity;
  int price;
  String purchaseDate;
  PurchaseHistoryModel({
    required this.image,
    required this.owner,
    required this.title,
    required this.quantity,
    required this.categories,
    required this.price,
    required this.purchaseDate,
  });
}

List<PurchaseHistoryModel> listPurchaseHistory = [
  PurchaseHistoryModel(
      title: 'Table and Desk',
      image: Assets.images.raidenShogun.path,
      categories: 'Clothes',
      owner: 'Thanh',
      price: 3000,
      purchaseDate: '15-5-2023',
      quantity: 3),
  PurchaseHistoryModel(
      title: 'Table and Desk',
      image: Assets.images.raidenShogun.path,
      categories: 'Clothes',
      owner: 'Thanh',
      price: 3000,
      purchaseDate: '15-5-2023',
      quantity: 3),
  PurchaseHistoryModel(
      title: 'Table and Desk',
      image: Assets.images.raidenShogun.path,
      categories: 'Clothes',
      owner: 'Thanh',
      price: 3000,
      purchaseDate: '15-5-2023',
      quantity: 3),
  PurchaseHistoryModel(
      title: 'Table and Desk',
      image: Assets.images.raidenShogun.path,
      categories: 'Clothes',
      owner: 'Thanh',
      price: 3000,
      purchaseDate: '15-5-2023',
      quantity: 3),
  PurchaseHistoryModel(
      title: 'Table and Desk',
      image: Assets.images.raidenShogun.path,
      categories: 'Clothes',
      owner: 'Thanh',
      price: 3000,
      purchaseDate: '15-5-2023',
      quantity: 3),
];

class PurchaseHistory extends StatelessWidget {
  const PurchaseHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.localizations.purchaseHistory,
          style: const TextStyle(color: Colors.black, fontSize: 20),
        ),
        backgroundColor: Colors.white,
        leading: const BackButton(
          color: Colors.black,
        ),
      ),
      body: ListView.builder(
        itemCount: listPurchaseHistory.length,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0).r,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    listPurchaseHistory[index].owner,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Stack(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(20)),
                            ),
                            child: ClipRRect(
                              child: Image.asset(
                                listPurchaseHistory[index].image,
                                fit: BoxFit.fill,
                                height: 100,
                                width: 100,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 20.w,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                listPurchaseHistory[index].title,
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 4.h,
                              ),
                              Text(
                                "Category: ${listPurchaseHistory[index].categories}",
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                height: 4.h,
                              ),
                              Text(
                                "Quantity: ${listPurchaseHistory[index].quantity}",
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                height: 4.h,
                              ),
                              Text(
                                listPurchaseHistory[index].purchaseDate,
                                style: const TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w500),
                              )
                            ],
                          )
                        ],
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: PrimaryButton(
                          customFunction: () {},
                          text: context.localizations.viewSeller,
                          buttonColor: Colors.black,
                          textColor: Colors.white,
                          fontSize: 14,
                          radius: 12,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
