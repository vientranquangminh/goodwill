import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PostInfo extends StatelessWidget {
  const PostInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final String _imagePath = "assets/images/manage_post/iphone.jpg";
    final String _title = 'iPhone 14 Pro Max (2nd)';
    final double _price = 30000000;

    final TextStyle _titleStyle = TextStyle(fontWeight: FontWeight.bold);
    final TextStyle _priceStyle =
        TextStyle(color: Colors.red, fontWeight: FontWeight.bold);

    return IntrinsicHeight(
      child: Row(
        children: [
          Flexible(
            flex: 2,
            child: Image(
              image: AssetImage(_imagePath),
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
                        _title,
                        style: _titleStyle,
                      ),
                      Text(
                        '$_price đ',
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
