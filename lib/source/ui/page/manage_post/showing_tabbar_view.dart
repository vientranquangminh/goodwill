import 'package:flutter/material.dart';
import 'package:goodwill/source/data/model/product_model.dart';

import 'managed_post_listitem.dart';

class ShowingTabbarView extends StatefulWidget {
  const ShowingTabbarView({super.key, required this.products});

  final List<ProductModel> products;

  @override
  State<ShowingTabbarView> createState() => _ShowingTabbarViewState();
}

class _ShowingTabbarViewState extends State<ShowingTabbarView>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(itemBuilder: ((context, index) {
      return ManagedPostListItem(productModel: widget.products[index]);
    }));
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

// List<Widget> managedPostListItems = [
//   const ManagedPostListItem(),
//   const ManagedPostListItem(),
//   const ManagedPostListItem(),
//   const ManagedPostListItem(),
//   const ManagedPostListItem(),
//   const ManagedPostListItem(),
//   const ManagedPostListItem(),
//   const ManagedPostListItem(),
//   const ManagedPostListItem(),
// ];
