import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:goodwill/source/common/extensions/build_context_ext.dart';
import 'package:goodwill/source/data/model/product_model.dart';
import 'package:goodwill/source/service/product_service.dart';
import 'package:goodwill/source/util/constant.dart';

class PostInfo extends StatelessWidget {
  const PostInfo({
    super.key,
    required this.productModel,
  });

  final ProductModel productModel;

  @override
  Widget build(BuildContext context) {
    final String imagePath =
        productModel.images?[0] ?? Constant.SAMPLE_AVATAR_URL;
    final String title = productModel.title ?? Constant.UNKNOWN;
    final int price = productModel.price ?? 0;

    const TextStyle titleStyle = TextStyle(fontWeight: FontWeight.bold);
    const TextStyle priceStyle =
        TextStyle(color: Colors.red, fontWeight: FontWeight.bold);

    return IntrinsicHeight(
      child: Row(
        children: [
          Flexible(
            flex: 2,
            child: Align(
              alignment: Alignment.centerLeft,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.r),
                child: CachedNetworkImage(
                  imageUrl: imagePath,
                  fit: BoxFit.fill,
                  width: 80,
                  height: 120,
                ),
              ),
            ),
          ),
          Flexible(
            flex: 8,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: titleStyle,
                      ),
                      Text(
                        '$price đ',
                        style: priceStyle,
                      ),
                      const Text('12:05 13/04/2023'),
                    ],
                  ),
                ),
                const Spacer(),
                Column(
                  children: [
                    PopupMenuButton(
                      icon: const Icon(Icons.more_vert),
                      itemBuilder: (BuildContext context) => [
                        PopupMenuItem(
                          child: TextButton(
                            child: const Text(
                              'Edit',
                              style: TextStyle(color: Colors.black),
                            ),
                            onPressed: () {
                              debugPrint('Button edit pressed');
                            },
                          ),
                        ),
                        PopupMenuItem(
                          child: TextButton(
                            child: const Text(
                              'Delete',
                              style: TextStyle(color: Colors.black),
                            ),
                            onPressed: () {
                              debugPrint('Button delete pressed');
                              ProductService.deleteProduct(productModel)
                                  .then((_) => context.pop());
                            },
                          ),
                        )
                      ],
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
