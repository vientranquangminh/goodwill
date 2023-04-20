import 'package:flutter/material.dart';
import 'package:goodwill/source/common/extensions/build_context_ext.dart';
import 'package:goodwill/source/models/post_model.dart';
import 'package:goodwill/source/ui/page/product/widgets/product_card.dart';

import '../../../../routes.dart';

class MyListProduct extends StatelessWidget {
  const MyListProduct({
    Key? key,
    required this.posts,
  }) : super(key: key);
  final List<PostModel> posts;
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      childAspectRatio: 0.70,
      crossAxisSpacing: 15,
      shrinkWrap: true,
      crossAxisCount: 2,
      children: List.generate(posts.length, (index) {
        return GestureDetector(
            onTap: () {
              context.pushNamedWithParam(Routes.productDetails, posts[index]);
            },
            child: ProductCard(category: posts[index]));
      }),
    );
  }
}
