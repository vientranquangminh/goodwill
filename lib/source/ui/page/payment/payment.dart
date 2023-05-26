import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_zalopay_sdk/flutter_zalopay_sdk.dart';
import 'package:flutter_zalopay_sdk/models/create_order_response.dart';
import 'package:goodwill/source/common/extensions/build_context_ext.dart';
import 'package:goodwill/source/common/widgets/custom_button/primary_button.dart';
import 'package:goodwill/source/data/dto/cart_item_dto.dart';
import 'package:goodwill/source/data/model/cart_item_model.dart';
import 'package:goodwill/source/data/model/purchase_history_model.dart';
import 'package:goodwill/source/data/model/user_profile.dart';
import 'package:goodwill/source/service/purchase_history_service.dart';
import 'package:goodwill/source/service/user_profile_service.dart';
import 'package:goodwill/source/ui/components/page_controller.dart';
import 'package:goodwill/source/ui/page/payment/component/status_payment.dart';
import 'package:goodwill/source/ui/page/purchase_history/purchase_history.dart';
import 'package:goodwill/source/util/constant.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class Payment extends StatefulWidget {
  const Payment({super.key});

  @override
  State<Payment> createState() => _PaymentState();
}

const List<String> list = <String>['ZaloPay', 'MoMo'];
String dropdownValue = list.first;

class _PaymentState extends State<Payment> {
  String? paymentStatus;
  String? oder;
  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProfile?>();
    String fullName = user?.fullName ?? Constant.UNKNOWN;
    String phoneNumber = user?.phoneNumber ?? Constant.FAKE_PHONENUMBER;
    String address = user?.address ?? Constant.FAKE_PHONENUMBER;

    final selectedCartItems = context.getParam() as List<CartItemDto>;
    int calculateTotalPrice() {
      int total = 0;
      for (int index = 0; index < selectedCartItems.length; index++) {
        total += selectedCartItems[index].price;
      }
      return total;
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => context.pop(),
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Text(
          context.localizations.payment,
          style: const TextStyle(color: Colors.black, fontSize: 22),
        ),
      ),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(border: Border.all()),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: const [Icon(Icons.location_on_outlined)],
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          context.localizations.deliveryAddress,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          "$fullName | $phoneNumber",
                          style: const TextStyle(fontSize: 16),
                        ),
                        Text(
                          address,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ]),
                ],
              ),
            ),
          ),
          Expanded(
              child: ListView.builder(
            itemCount: selectedCartItems.length,
            itemBuilder: (context, index) {
              return Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FutureBuilder<UserProfile?>(
                        future: UserProfileService.getUserProfile(
                            selectedCartItems[index].sellerId),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return const Center(
                              child: Text('Loading...'),
                            );
                          }
                          if (snapshot.hasError) {
                            return const Text('Something goes wrong!');
                          }

                          UserProfile? userProfile = snapshot.data;
                          String name = userProfile?.fullName ?? 'Loading...';

                          return Text(
                            name,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        },
                      ),
                      const SizedBox(
                        height: 8,
                      ),
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
                              child: CachedNetworkImage(
                                imageUrl: selectedCartItems[index].imageUrl,
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
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 1.8,
                                child: Text(
                                  selectedCartItems[index].title,
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                  overflow: TextOverflow.clip,
                                ),
                              ),
                              SizedBox(
                                height: 4.h,
                              ),
                              Text(
                                "${context.localizations.category}: ${selectedCartItems[index].category}",
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                height: 4.h,
                              ),
                              Text(
                                "${context.localizations.price}: ${selectedCartItems[index].price}"
                                " x "
                                "${selectedCartItems[index].quantity}",
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                height: 4.h,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 1.8,
                                child: Text(
                                  "${context.localizations.totalPrice}: ${NumberFormat.currency(symbol: '', decimalDigits: 0).format(selectedCartItems[index].price * selectedCartItems[index].quantity)} ${Constant.VN_CURRENCY}",
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      overflow: TextOverflow.ellipsis),
                                ),
                              ),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
              );
            },
          )),
          Container(
            margin: const EdgeInsets.all(10),
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(10)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: const [
                    Icon(Icons.monetization_on_outlined),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      "Payment Method",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
                const SizedBox(width: 8),
                DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                    value: dropdownValue,
                    icon: const Icon(Icons.arrow_drop_down_sharp),
                    elevation: 10,
                    onChanged: (String? value) {
                      setState(() {
                        dropdownValue = value!;
                      });
                    },
                    items: list.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(context.localizations.totalPrice,
                          style: TextStyle(
                              color: Colors.grey.shade700,
                              fontSize: 14,
                              fontWeight: FontWeight.w500)),
                      Text(
                        "${NumberFormat('#,##0').format(calculateTotalPrice())} ${Constant.VN_CURRENCY}",
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                      ),
                    ],
                  ),
                  FutureBuilder<CreateOrderResponse?>(
                      future:
                          FlutterZaloPaySdk.createOrder(calculateTotalPrice()),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                        if (snapshot.hasError) {
                          return const Text('Something goes wrong!');
                        }
                        final orderResponse = snapshot.data;
                        oder = orderResponse?.zptranstoken ?? 'null';
                        final zpTransToken =
                            orderResponse?.zptranstoken ?? 'null';
                        return SizedBox(
                          height: 50,
                          child: PrimaryButton(
                            customFunction: () {
                              FlutterZaloPaySdk.payOrder(zpToken: zpTransToken)
                                  .listen((event) {
                                setState(() {
                                  paymentStatus = event.name;
                                  log(paymentStatus.toString());
                                  if (paymentStatus == 'success') {
                                    _handlePurchaseHistory(
                                        selectedCartItems, zpTransToken);

                                    // Back to mainpage
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => StatusPayment(
                                                amountPaid:
                                                    calculateTotalPrice(),
                                                owner: fullName,
                                              )),
                                    );
                                  } else {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => StatusPayment(
                                                image:
                                                    'assets/images/payment_fail.png',
                                                status: 'Payment Failed',
                                                owner: fullName,
                                              )),
                                    );
                                  }
                                });
                              });
                            },
                            text: context.localizations.pay,
                            textColor: Colors.white,
                            fontSize: 16,
                            buttonColor: Colors.black,
                            radius: 24,
                          ),
                        );
                      })
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _handlePurchaseHistory(
      List<CartItemDto> selectedCartItems, String zpTransToken) {
    List<PurchaseHistoryModel> historyList = selectedCartItems
        .map((e) => PurchaseHistoryModel(
              productId: e.productId,
              quantity: e.quantity,
              createdAt: DateTime.now(),
              transactionId: zpTransToken,
            ))
        .toList();
    historyList.forEach(PurchaseHistoryService.addPurchaseHistory);
  }

  Widget _greyBoxContainer({required Widget child}) {
    return Container(
      margin: const EdgeInsets.all(10),
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(10),
      ),
      child: child,
    );
  }
}
