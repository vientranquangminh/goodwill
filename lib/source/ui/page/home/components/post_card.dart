import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:goodwill/source/data/model/product_model.dart';
import 'package:goodwill/source/util/date_time_helper.dart';

class PostCard extends StatelessWidget {
  const PostCard({super.key, required this.postCard});
  final ProductModel postCard;

  @override
  Widget build(BuildContext context) {
    String _imageUrl = postCard.images?[0] ?? '';
    String _postCardTitle = postCard.title ?? '';
    int _price = postCard.price ?? 0;
    String _time = DateTimeHelper.toVietnameseStandardDate(postCard.createdAt);
    String _location = postCard.location ?? 'Default location';

    return SizedBox(
      child: Column(
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
            _postCardTitle,
            style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
          ),
          const SizedBox(height: 5),
          Text(
            "\$ $_price",
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          const SizedBox(height: 5),
          Text(
            "$_time • $_location",
            style: const TextStyle(fontSize: 14, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
