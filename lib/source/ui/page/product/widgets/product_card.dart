import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:goodwill/gen/colors.gen.dart';
import 'package:goodwill/source/common/extensions/text_style_ext.dart';
import 'package:goodwill/source/data/model/product_model.dart';
import 'package:goodwill/source/util/constant.dart';
import 'package:intl/intl.dart';

class ProductCard extends StatefulWidget {
  const ProductCard({super.key, required this.category});
  final ProductModel category;

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    String _imageUrl = widget.category.images?[0] ?? '';
    String _title = widget.category.title ?? '';
    String _location = widget.category.location ?? 'Da Nang';
    int _price = widget.category.price ?? 0;

    return SizedBox(
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width / 2,
                height: MediaQuery.of(context).size.width / 2,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.grey.shade300),
                child: Image(
                  image: CachedNetworkImageProvider(_imageUrl),
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                _title,
                style: context.blackS16W700,
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  Flexible(
                    child: Text(
                      _location,
                      style: const TextStyle(fontWeight: FontWeight.w500),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(
                    width: 4.w,
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Text(
                "${NumberFormat('#,##0').format(_price)} ${Constant.VN_CURRENCY}",
                style: context.blackS16W700,
              )
            ],
          ),
        ],
      ),
    );
  }
}

class QuantitySoldContainer extends StatelessWidget {
  const QuantitySoldContainer(
      {super.key,
      this.text = '',
      this.color = ColorName.black,
      this.radius = 0.0});
  final String text;
  final Color color;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(radius)),
        color: color,
      ),
      child: Text(
        text,
        style: context.blackS12W500,
      ),
    );
  }
}
