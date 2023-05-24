import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:goodwill/gen/assets.gen.dart';
import 'package:goodwill/source/common/extensions/build_context_ext.dart';
import 'package:goodwill/source/common/widgets/custom_button/primary_button.dart';
import 'package:goodwill/source/data/dto/purchase_history_dto.dart';
import 'package:goodwill/source/data/model/purchase_history_model.dart';
import 'package:goodwill/source/service/purchase_history_service.dart';
import 'package:goodwill/source/ui/page/manage_post/showing_tabbar_view.dart';
import 'package:goodwill/source/ui/page/search/widgets/not_found_screen.dart';
import 'package:goodwill/source/util/date_time_helper.dart';
import 'package:goodwill/source/util/mapper.dart';
import 'package:provider/provider.dart';

class PurchaseHistoryModelDummy {
  String image;
  String owner;
  String title;
  String categories;
  int quantity;
  int price;
  String purchaseDate;
  PurchaseHistoryModelDummy({
    required this.image,
    required this.owner,
    required this.title,
    required this.quantity,
    required this.categories,
    required this.price,
    required this.purchaseDate,
  });
}

// List<PurchaseHistoryModelDummy> purchaseHistoryList = [
//   PurchaseHistoryModelDummy(
//       title: 'Table and Desk',
//       image: Assets.images.raidenShogun.path,
//       categories: 'Clothes',
//       owner: 'Thanh',
//       price: 3000,
//       purchaseDate: '15-5-2023',
//       quantity: 3),
//   PurchaseHistoryModelDummy(
//       title: 'Table and Desk',
//       image: Assets.images.raidenShogun.path,
//       categories: 'Clothes',
//       owner: 'Thanh',
//       price: 3000,
//       purchaseDate: '15-5-2023',
//       quantity: 3),
//   PurchaseHistoryModelDummy(
//       title: 'Table and Desk',
//       image: Assets.images.raidenShogun.path,
//       categories: 'Clothes',
//       owner: 'Thanh',
//       price: 3000,
//       purchaseDate: '15-5-2023',
//       quantity: 3),
//   PurchaseHistoryModelDummy(
//       title: 'Table and Desk',
//       image: Assets.images.raidenShogun.path,
//       categories: 'Clothes',
//       owner: 'Thanh',
//       price: 3000,
//       purchaseDate: '15-5-2023',
//       quantity: 3),
//   PurchaseHistoryModelDummy(
//       title: 'Table and Desk',
//       image: Assets.images.raidenShogun.path,
//       categories: 'Clothes',
//       owner: 'Thanh',
//       price: 3000,
//       purchaseDate: '15-5-2023',
//       quantity: 3),
// ];

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
        actions: [
          TextButton(
              onPressed: () {
                PurchaseHistoryService.addPurchaseHistory(
                    PurchaseHistoryModel.sample);
              },
              child: const Text('Add dummy Purchased Item')),
        ],
      ),
      body: StreamProvider<List<PurchaseHistoryModel>?>.value(
          initialData: [],
          value: PurchaseHistoryService.getStreamAllPurchaseHistory(),
          builder: (context, snapshot) {
            final modelList = context.watch<List<PurchaseHistoryModel>?>();

            if (modelList == null || modelList.isEmpty) {
              return const EmptyScreen();
            }

            return FutureProvider<List<PurchaseHistoryDto>>.value(
                initialData: [],
                value: Mapper.PHistoryListToPHistoryDtoList(modelList),
                builder: (context, snapshot) {
                  final purchaseHistoryList =
                      context.watch<List<PurchaseHistoryDto>>();

                  return ListView.builder(
                    itemCount: purchaseHistoryList.length,
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
                                purchaseHistoryList[index].productOwnerName,
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Stack(
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Colors.grey.shade300,
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(20)),
                                        ),
                                        child: ClipRRect(
                                          child: CachedNetworkImage(
                                            imageUrl: purchaseHistoryList[index]
                                                .imageUrl,
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            purchaseHistoryList[index].title,
                                            style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(
                                            height: 4.h,
                                          ),
                                          Text(
                                            "Category: ${purchaseHistoryList[index].category}",
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          SizedBox(
                                            height: 4.h,
                                          ),
                                          Text(
                                            "Quantity: ${purchaseHistoryList[index].quantity}",
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          SizedBox(
                                            height: 4.h,
                                          ),
                                          Text(
                                            DateTimeHelper
                                                .toVietnameseStandardDate(
                                                    purchaseHistoryList[index]
                                                        .createdAt),
                                            style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          SizedBox(
                                            height: 4.h,
                                          ),
                                          Text(
                                            "Price: ${purchaseHistoryList[index].price}",
                                            style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w700),
                                          ),
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
                  );
                });
          }),
    );
  }
}
