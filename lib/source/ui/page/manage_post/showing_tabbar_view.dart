import 'package:flutter/material.dart';
import 'package:goodwill/gen/assets.gen.dart';
import 'package:goodwill/source/common/extensions/build_context_ext.dart';
import 'package:goodwill/source/common/extensions/text_style_ext.dart';
import 'package:goodwill/source/data/model/product_model.dart';

import 'managed_post_listitem.dart';

class ShowingTabbarView extends StatefulWidget {
  const ShowingTabbarView({super.key, this.products});

  final List<ProductModel>? products;

  @override
  State<ShowingTabbarView> createState() => _ShowingTabbarViewState();
}

class _ShowingTabbarViewState extends State<ShowingTabbarView>
    with AutomaticKeepAliveClientMixin {
// {
  @override
  Widget build(BuildContext context) {
    if (widget.products == null || widget.products!.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Assets.images.emptyBox.image(height: 50, width: 50),
            const SizedBox(
              height: 10,
            ),
            Text(
              context.localizations.empty,
              style: context.blackS16W500,
            ),
          ],
        ),
      );
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

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
