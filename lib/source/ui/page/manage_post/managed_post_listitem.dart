// ignore_for_file: prefer_const_constructors, empty_constructor_bodies

import 'package:flutter/material.dart';
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
      child: Card(
        child: Column(
          children: [
            PostInfo(
              imagePath: images?[0] ?? Constant.SAMPLE_AVATAR_URL,
              title: title,
              price: price,
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
                  icon: Icon(Icons.remove_red_eye),
                  label: Text('Hide post'),
                ),
                TextButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.query_stats),
                  label: Text('Statcs'),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
