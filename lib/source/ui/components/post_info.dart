import 'package:flutter/material.dart';

class PostInfo extends StatelessWidget {
  const PostInfo({
    super.key,
    required this.imagePath,
    required this.title,
    required this.price,
  });

  final String imagePath;
  final String title;
  final int price;

  @override
  Widget build(BuildContext context) {
    // final String _imagePath = "assets/images/manage_post/iphone.jpg";
    // final String _title = 'iPhone 14 Pro Max (2nd)';
    // final int _price = 30000000;

    final TextStyle _titleStyle = TextStyle(fontWeight: FontWeight.bold);
    final TextStyle _priceStyle =
        TextStyle(color: Colors.red, fontWeight: FontWeight.bold);

    return IntrinsicHeight(
      child: Row(
        children: [
          Flexible(
            flex: 2,
            child: Center(
              child: Image(
                image: NetworkImage(imagePath),
              ),
            ),
          ),
          Flexible(
            flex: 8,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: _titleStyle,
                      ),
                      Text(
                        '$price đ',
                        style: _priceStyle,
                      ),
                      const Text('12:05 13/04/2023'),
                    ],
                  ),
                ),
                const Spacer(),
                Column(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.more_vert),
                      onPressed: () {},
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
