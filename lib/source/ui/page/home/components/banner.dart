import 'dart:developer';

import 'package:flutter/material.dart';

class BannerAds extends StatelessWidget {
  const BannerAds({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Container(
          height: 200,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.shade600,
                    offset: Offset(4, 6),
                    blurRadius: 20),
              ],
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.grey.shade500,
                    Colors.grey.shade300,
                  ]),
              borderRadius: BorderRadius.circular(28)),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text("Find Your",
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                        color: Colors.black)),
                Text("Perfect Items",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.w600)),
                SizedBox(
                  height: 10,
                ),
                Text(
                    "Lorem Ipsum is simply dummy \ntext of the printing\nand typesetting industry",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.w500)),
              ],
            ),
          ),
        ),
      ),
      const Positioned(
          right: 30,
          bottom: 0,
          child: Image(
            width: 110,
            height: 200,
            image: AssetImage("assets/images/home_page/banner.png"),
          ))
    ]);
  }
}
