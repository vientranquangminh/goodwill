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
          List<ProductModel>? _posts =
              Provider.of<List<ProductModel>?>(context, listen: true);
          if (_posts == null) {
            return const NotFoundScreen();
          }
          if (widget.searchText?.isNotEmpty ?? false) {
            _posts = _posts.where((post) {
              return post.title
                      ?.toLowerCase()
                      .contains(widget.searchText!.toLowerCase()) ??
                  false;
            }).toList();
          }
          return GridView.count(
            childAspectRatio: 0.70,
            crossAxisSpacing: 15,
            shrinkWrap: true,
            crossAxisCount: 2,
            children: List.generate(_posts.length, (index) {
              return GestureDetector(
                  onTap: () => context.pushNamedWithParam(
                      Routes.productDetails, _posts![index]),
                  child: ProductCard(category: _posts![index]));
            }),
          );
        });
  }
}
