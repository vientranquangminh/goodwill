import 'package:flutter/material.dart';
import 'package:goodwill/source/common/extensions/build_context_ext.dart';
import 'package:goodwill/source/data/model/product_model.dart';
import 'package:goodwill/source/service/product_service.dart';
import 'package:goodwill/source/ui/page/product/widgets/product_card.dart';

import '../../../../routes.dart';

class MyListProduct extends StatelessWidget {
  const MyListProduct({
    Key? key,
    required this.posts,
  }) : super(key: key);
  final List<ProductModel> posts;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ProductModel>?>(
        future: ProductService.getAllProducts(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<ProductModel> _posts = snapshot.data!;
            return GridView.count(
              childAspectRatio: 0.70,
              crossAxisSpacing: 15,
              shrinkWrap: true,
              crossAxisCount: 2,
              children: List.generate(_posts.length, (index) {
                return GestureDetector(
                    onTap: () => context.pushNamedWithParam(
                        Routes.productDetails, _posts[index]),
                    child: ProductCard(category: _posts[index]));
              }),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text('Loading');
          }
          return const Text('Dont know');
        });
  }
}
