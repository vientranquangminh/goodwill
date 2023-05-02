import 'package:flutter/material.dart';
import 'package:goodwill/source/data/model/product_model.dart';
import 'package:goodwill/source/util/constant.dart';

import 'managed_post_listitem.dart';

class ShowingTabbarView extends StatefulWidget {
  const ShowingTabbarView({super.key, this.products});

  final List<ProductModel>? products;

  @override
  State<ShowingTabbarView> createState() => _ShowingTabbarViewState();
}

class _ShowingTabbarViewState extends State<ShowingTabbarView>
// with AutomaticKeepAliveClientMixin {
{
  @override
  Widget build(BuildContext context) {
    if (widget.products == null || widget.products!.isEmpty) {
      return Text(Constant.EMPTY_LIST);
    }

    return ListView.builder(
        itemCount: widget.products!.length,
        itemBuilder: ((context, index) {
          return SizedBox(
              height: 200,
              child:
                  ManagedPostListItem(productModel: widget.products![index]));
        }));
  }
}
