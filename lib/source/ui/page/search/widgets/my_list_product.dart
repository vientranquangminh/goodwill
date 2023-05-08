import 'package:flutter/material.dart';
import 'package:goodwill/source/common/extensions/build_context_ext.dart';
import 'package:goodwill/source/data/model/product_model.dart';
import 'package:goodwill/source/routes.dart';
import 'package:goodwill/source/service/product_service.dart';
import 'package:goodwill/source/ui/page/product/widgets/product_card.dart';
import 'package:goodwill/source/ui/page/search/widgets/not_found_screen.dart';
import 'package:provider/provider.dart';

class MyListProduct extends StatefulWidget {
  const MyListProduct({
    Key? key,
    this.category,
    this.searchText,
  }) : super(key: key);

  final String? category;
  final String? searchText;

  @override
  State<MyListProduct> createState() => _MyListProductState();
}

class _MyListProductState extends State<MyListProduct> {
  @override
  Widget build(BuildContext context) {
    return FutureProvider<List<ProductModel>?>.value(
        initialData: [],
        value:
            ProductService.getProductsWithCategory(category: widget.category),
        builder: (context, snapshot) {
          List<ProductModel>? _posts = context.watch<List<ProductModel>?>();
          List<ProductModel>? _postsWithSearch =
              (widget.searchText?.isNotEmpty ?? false)
                  ? getPostsWithSearch(_posts, widget.searchText!.toLowerCase())
                  : _posts;

          if (_postsWithSearch == null) {
            return const NotFoundScreen();
          }
          return GridView.count(
            childAspectRatio: 0.60,
            crossAxisSpacing: 15,
            shrinkWrap: true,
            crossAxisCount: 2,
            children: List.generate(_postsWithSearch.length, (index) {
              return GestureDetector(
                  onTap: () => context.pushNamedWithParam(
                      Routes.productDetails, _postsWithSearch[index]),
                  child: ProductCard(category: _postsWithSearch[index]));
            }),
          );
        });
  }

  List<ProductModel>? getPostsWithSearch(
      List<ProductModel>? posts, String searchText) {
    return posts?.where((post) {
      return post.title?.toLowerCase().contains(searchText) ?? false;
    }).toList();
  }
}
