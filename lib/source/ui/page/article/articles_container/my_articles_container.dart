import 'package:flutter/material.dart';

class MyArticleContainer extends StatelessWidget {
  const MyArticleContainer(
      {Key? key, required this.time, required this.title, required this.imgUrl})
      : super(key: key);
  final String time;
  final String title;
  final String imgUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      margin: const EdgeInsets.symmetric(vertical: 10),
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: SizedBox.fromSize(
              size: const Size.fromRadius(48),
              child: Image.network(imgUrl, fit: BoxFit.cover),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  time,
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(title,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w500)),
                const SizedBox(
                  height: 5,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
