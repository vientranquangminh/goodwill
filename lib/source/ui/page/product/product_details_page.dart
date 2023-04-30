import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:goodwill/gen/assets.gen.dart';
import 'package:goodwill/gen/colors.gen.dart';
import 'package:goodwill/source/common/extensions/build_context_ext.dart';
import 'package:goodwill/source/common/extensions/text_style_ext.dart';
import 'package:goodwill/source/common/widgets/custom_button/primary_button_with_icon.dart';
import 'package:goodwill/source/data/model/post_model.dart';
import 'package:goodwill/source/ui/page/product/widgets/product_card.dart';
import 'package:goodwill/source/ui/page/product/widgets/select_color_widget.dart';
import 'package:goodwill/source/ui/page/product/widgets/select_size_widget.dart';

class ProductDetailsPage extends StatefulWidget {
  const ProductDetailsPage({super.key});

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    final arguments = context.getParam() as PostModel;
    log(arguments.toString());
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 300.h,
                    child: Assets.images.homePage.item
                        .image(fit: BoxFit.fitHeight),
                  ),
                  PlatformIconButton(
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: ColorName.black,
                    ),
                    onPressed: () {
                      context.pop();
                    },
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Venesa Long Shirt',
                          style: context.blackS20W700,
                        ),
                        PlatformIconButton(
                          icon: const Icon(
                            Icons.heart_broken,
                            color: ColorName.black,
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        QuantitySoldContainer(
                          color: const Color.fromARGB(255, 214, 214, 214),
                          radius: 4.r,
                          text: context.localizations.sold('1,234'),
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        const Icon(Icons.star_half),
                        Text('4.8 (${context.localizations.reviews('4,321')})'),
                      ],
                    ),
                    SizedBox(
                      height: 12.h,
                    ),
                    const Divider(
                      color: ColorName.black,
                    ),
                    Text(
                      context.localizations.description,
                      style: context.blackS16W700,
                    ),
                    SizedBox(
                      height: 12.h,
                    ),
                    const Text(
                        '''Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.'''),
                    SizedBox(
                      height: 12.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        SelectSizeWidget(),
                        SelectColorWidget(),
                      ],
                    ),
                    SizedBox(
                      height: 12.h,
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
                        selectQuantityWidget(quantity, context, () {
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
                      height: 20.h,
                    ),
                    Row(
                      children: [
                        Column(
                          children: [
                            Text(context.localizations.totalPrice,
                                style: context.blackS10W400),
                            Text(
                              '\$320.00',
                              style: context.blackS16W700,
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 16.h,
                        ),
                        Expanded(
                          child: SizedBox(
                            height: 45,
                            child: PrimaryButtonWithIcon(
                                svg: Assets.svgs.bag.svg(
                                    height: 12.h,
                                    colorFilter: const ColorFilter.mode(
                                        ColorName.white, BlendMode.srcIn)),
                                buttonColor: ColorName.black,
                                textColor: ColorName.white,
                                fontSize: 12,
                                radius: 20.0,
                                text: context.localizations.addToCart,
                                customFunction: () {}),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget selectQuantityWidget(int text, BuildContext context,
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
