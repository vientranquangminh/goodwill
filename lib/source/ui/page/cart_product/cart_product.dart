import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:goodwill/gen/assets.gen.dart';
import 'package:goodwill/source/common/extensions/build_context_ext.dart';
import 'package:goodwill/source/common/widgets/custom_button/primary_button.dart';
import 'package:goodwill/source/ui/page/cart_product/component/container_cart.dart';

class ProductCartModel {
  String title;
  String phoneNumber;
  String location;
  bool? payment;
  int price;
  ProductCartModel(
      {required this.title,
      required this.location,
      this.payment,
      required this.price,
      required this.phoneNumber});
}

List<ProductCartModel> listCartProduct = [
  ProductCartModel(
      title: "Ipad",
      price: 3000,
      phoneNumber: "0905430873",
      location: "Da Nang"),
  ProductCartModel(
      title: "Shoes",
      price: 500,
      phoneNumber: "0905430873",
      location: "Da Nang"),
  ProductCartModel(
      title: "Iphone",
      price: 2000,
      phoneNumber: "0905430873",
      location: "Da Nang")
];

class CartProduct extends StatelessWidget {
  const CartProduct({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: Assets.svgs.mainIcon.svg(),
        title: Text(
          context.localizations.myCart,
          style: const TextStyle(color: Colors.black, fontSize: 22),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ListView.separated(
                  itemBuilder: (context, index) {
                    return ContainerCart(
                      listCartProduct: listCartProduct[index],
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) =>
                      SizedBox(height: 16.h),
                  itemCount: listCartProduct.length),
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            height: 100,
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
                      const Text(
                        "\$328",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 22),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 50,
                    width: MediaQuery.of(context).size.width / 1.75,
                    child: PrimaryButton(
                      customFunction: () {},
                      text: context.localizations.checkOut,
                      textColor: Colors.white,
                      fontSize: 16,
                      buttonColor: Colors.black,
                      radius: 24,
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
