import 'package:flutter/material.dart';
import 'package:goodwill/source/models/post_model.dart';

class PostCard extends StatelessWidget {
  const PostCard({super.key, required this.postCard});
  final PostModel postCard;

  @override
  Widget build(BuildContext context) {
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
              child: Image(image: AssetImage(postCard.image)),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            postCard.name,
            style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
          ),
          const SizedBox(height: 5),
          Text(
            "\$${postCard.price}",
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          const SizedBox(height: 5),
          Text(
            "${postCard.time} • ${postCard.location}",
            style: const TextStyle(fontSize: 14, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
