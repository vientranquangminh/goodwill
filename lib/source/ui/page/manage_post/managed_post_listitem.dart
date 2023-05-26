// ignore_for_file: prefer_const_constructors, empty_constructor_bodies

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:goodwill/source/common/extensions/build_context_ext.dart';
import 'package:goodwill/source/data/model/product_model.dart';
import 'package:goodwill/source/ui/components/post_info.dart';
import 'package:goodwill/source/util/constant.dart';

class ManagedPostListItem extends StatelessWidget {
  const ManagedPostListItem({super.key, required this.productModel});

  final ProductModel productModel;

  @override
  Widget build(BuildContext context) {
    List<String>? images = productModel.images;
    String title = productModel.title ?? Constant.UNKNOWN;
    int price = productModel.price ?? 0;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black.withOpacity(0.2)),
          borderRadius: BorderRadius.all(
            Radius.circular(10.r),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(
                child: PostInfo(
                  productModel: productModel,
                ),
              ),
              // Interaction buttons
              Row(
                children: [
                  Icon(Icons.image),
                  const SizedBox(width: 4.0),
                  Text('${images?.length ?? 0}'),
                  Spacer(),
                  TextButton.icon(
                    onPressed: () {},
                    icon: Icon(
                      Icons.remove_red_eye,
                      color: Colors.black,
                    ),
                    label: Text(
                      context.localizations.hidePost,
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  TextButton.icon(
                    onPressed: () {},
                    icon: Icon(
                      Icons.query_stats,
                      color: Colors.black,
                    ),
                    label: Text(
                      context.localizations.statcs,
                      style: TextStyle(color: Colors.black),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
