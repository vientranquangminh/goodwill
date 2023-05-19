import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:goodwill/source/data/model/product_model.dart';
import 'package:goodwill/source/util/date_time_helper.dart';

class PostCard extends StatelessWidget {
  const PostCard({super.key, required this.postCard});
  final ProductModel postCard;

  @override
  Widget build(BuildContext context) {
    String imageUrl = postCard.images?[0] ?? '';
    String postCardTitle = postCard.title ?? '';
    int price = postCard.price ?? 0;
    String time = DateTimeHelper.toVietnameseStandardDate(postCard.createdAt);
    String location = postCard.location ?? 'Default location';

    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10.r),
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              fit: BoxFit.fill,
              width: 180,
              height: 200,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            postCardTitle,
            style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
          ),
          const SizedBox(height: 5),
          Text(
            "$price VND",
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          const SizedBox(height: 5),
          Text(
            "$time • $location",
            style: const TextStyle(fontSize: 14, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
