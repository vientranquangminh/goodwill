import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../models/categories_model.dart';

class CategoriesCard extends StatelessWidget {
  const CategoriesCard({Key? key, required this.categories}) : super(key: key);
  final Category categories;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
            height: 55,
            width: 55,
            decoration: BoxDecoration(
                color: Colors.grey.shade200, shape: BoxShape.circle),
            child: SvgPicture.asset(
              categories.icon,
              height: 5,
              width: 5,
              fit: BoxFit.none,
              color: Colors.black,
            )),
        const SizedBox(
          height: 6,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Text(
            categories.title,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}
