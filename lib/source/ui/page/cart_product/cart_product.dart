import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:goodwill/gen/assets.gen.dart';
import 'package:goodwill/source/common/extensions/build_context_ext.dart';
import 'package:goodwill/source/common/widgets/custom_button/primary_button.dart';
import 'package:goodwill/source/data/dto/cart_item_dto.dart';
import 'package:goodwill/source/data/model/cart_item_model.dart';
import 'package:goodwill/source/routes.dart';
import 'package:goodwill/source/service/cart_service.dart';
import 'package:goodwill/source/ui/page/cart_product/component/container_cart.dart';
import 'package:goodwill/source/ui/page/payment/component/status_payment.dart';
import 'package:goodwill/source/ui/page/search/widgets/not_found_screen.dart';
import 'package:goodwill/source/util/constant.dart';
import 'package:goodwill/source/util/mapper.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ProductCartModel {
  String title;
  String phoneNumber;
  String location;
  bool? payment;
  int price;

  ProductCartModel({
    required this.title,
    required this.location,
    this.payment,
    required this.price,
    required this.phoneNumber,
  });
}

// List<ProductCartModel> listCartProduct = [
//   ProductCartModel(
//       title: "Ipad",
//       price: 3000,
//       phoneNumber: "0905430873",
//       location: "Da Nang"),
//   ProductCartModel(
//       title: "Shoes",
//       price: 500,
//       phoneNumber: "0905430873",
//       location: "Da Nang"),
//   ProductCartModel(
//       title: "Iphone",
//       price: 2000,
//       phoneNumber: "0905430873",
//       location: "Da Nang")
// ];

class CartProduct extends StatefulWidget {
  const CartProduct({super.key});

  @override
  State<CartProduct> createState() => _CartProductState();
}

class _CartProductState extends State<CartProduct> {
  List<int> selectedIndexes = [];
  double calculateTotalPrice(List<CartItemDto> cartProducts) {
    double total = 0;
    for (int index in selectedIndexes) {
      total += cartProducts[index].price;
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
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
          context.localizations.myCart,
          style: const TextStyle(color: Colors.black, fontSize: 22),
        ),
      ),
      body: StreamProvider<List<CartItemModel>?>.value(
          initialData: [],
          value: CartService.getStreamAllCartItems(),
          builder: (context, snapshot) {
            final cartItems = context.watch<List<CartItemModel>?>();

            return FutureProvider<List<CartItemDto>>.value(
                initialData: [],
                value: Mapper.cartItemListToCartItemDtoList(cartItems),
                builder: (context, snapshot) {
                  final cartProducts = context.watch<List<CartItemDto>>();
                  if (cartProducts == null) {
                    return const NotFoundScreen();
                  }

                  return Column(
                    children: [
                      Expanded(
                        child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: ListView.separated(
                                itemBuilder: (context, index) {
                                  return ContainerCart(
                                    cartProduct: cartProducts[index],
                                    index: index,
                                    selectedIndexes: selectedIndexes,
                                    onCheckboxChanged: (isChecked) {
                                      setState(() {
                                        if (isChecked) {
                                          selectedIndexes.add(index);
                                        } else {
                                          selectedIndexes.remove(index);
                                        }
                                      });
                                    },
                                    quantity: cartProducts[index].quantity,
                                  );
                                },
                                separatorBuilder:
                                    (BuildContext context, int index) =>
                                        SizedBox(height: 16.h),
                                itemCount: cartProducts.length)),
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
                                  Text(
                                    "${NumberFormat('#,##0').format(calculateTotalPrice(cartProducts))} ${Constant.VN_CURRENCY}",
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 22),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 50,
                                child: PrimaryButton(
                                  customFunction: () {
                                    List<CartItemDto> selectedProducts =
                                        selectedIndexes
                                            .map((index) => cartProducts[index])
                                            .toList();
                                    context.pushNamedWithParam(
                                        Routes.payment, selectedProducts);
                                  },
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
                  );
                });
          }),
    );
  }
}
