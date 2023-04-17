import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:goodwill/gen/colors.gen.dart';
import 'package:goodwill/source/common/extensions/build_context_ext.dart';
import 'package:goodwill/source/common/extensions/text_style_ext.dart';

List<String> sizes = ['S', 'M', 'L'];

class SelectSizeWidget extends StatefulWidget {
  const SelectSizeWidget({super.key});

  @override
  State<SelectSizeWidget> createState() => _SelectSizeWidgetState();
}

class _SelectSizeWidgetState extends State<SelectSizeWidget> {
  int selectedIndex = 0;
  Color color = ColorName.black;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.localizations.size,
          style: context.blackS16W500,
        ),
        SizedBox(
          height: 10.h,
        ),
        SizedBox(
          height: 50,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: sizes.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedIndex = index;
                  });
                },
                child: sizeRoundedWidget(
                  sizes[index],
                  selectedIndex == index,
                  35,
                ),
              );
            },
          ),
        )
      ],
    );
  }
}

Widget sizeRoundedWidget(String text, bool isSelected, double size) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 4),
    alignment: Alignment.center,
    height: size,
    width: size,
    decoration: BoxDecoration(
      color: isSelected ? ColorName.black : ColorName.white,
      shape: BoxShape.circle,
      border: Border.all(color: ColorName.black),
    ),
    child: Text(
      text,
      style: TextStyle(color: isSelected ? ColorName.white : ColorName.black),
    ),
  );
}
