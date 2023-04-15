import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:goodwill/gen/colors.gen.dart';
import 'package:goodwill/source/common/extensions/build_context_ext.dart';
import 'package:goodwill/source/common/extensions/text_style_ext.dart';
import 'package:goodwill/source/models/categories_model.dart';

class ProductCard extends StatefulWidget {
  const ProductCard({super.key, required this.category});
  final Category category;

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.grey.shade300),
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Image(image: AssetImage(widget.category.path)),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                widget.category.title,
                style: context.blackS20W700,
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  const Icon(Icons.star_half),
                  SizedBox(
                    width: 4.w,
                  ),
                  const Text('4.8'),
                  SizedBox(
                    width: 4.w,
                  ),
                  Container(
                    color: ColorName.black,
                    width: 1,
                    height: 12.h,
                  ),
                  SizedBox(
                    width: 4.w,
                  ),
                  Container(
                    padding: EdgeInsets.all(4.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8.r)),
                      color: const Color.fromARGB(255, 214, 214, 214),
                    ),
                    child: Text(context.localizations.sold(9724)),
                  )
                ],
              ),
              const SizedBox(height: 5),
              Text(
                '\$320.99',
                style: context.blackS20W700,
              )
            ],
          ),
          Positioned(
            top: -5.h,
            right: -5.h,
            child: PlatformIconButton(
              icon: const Icon(
                Icons.heart_broken,
                color: ColorName.black,
              ),
              onPressed: () {
                log('loved');
              },
            ),
          )
        ],
      ),
    );
  }
}
