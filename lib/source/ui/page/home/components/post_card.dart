import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:goodwill/source/data/model/post_model.dart';

class PostCard extends StatelessWidget {
  const PostCard({super.key, required this.postCard});
  final PostModel postCard;

  @override
  Widget build(BuildContext context) {
    String _imageUrl = postCard.images?[0] ?? '';
    String _postCardTitle = postCard.title ?? '';
    int _price = postCard.price ?? 0;
    String _time =
        postCard.createdAt?.toIso8601String() ?? 'More than 100 years';
    String _location = postCard.location ?? 'Default location';

    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.grey.shade300),
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Image(
                image: CachedNetworkImageProvider(_imageUrl),
              ),
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
