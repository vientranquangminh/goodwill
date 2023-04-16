import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:goodwill/gen/colors.gen.dart';
import 'package:goodwill/source/common/extensions/build_context_ext.dart';
import 'package:goodwill/source/common/extensions/text_style_ext.dart';

List<Color> colors = [
  Colors.blue,
  Colors.yellow,
  Colors.green,
  Colors.brown,
];

class SelectColorWidget extends StatefulWidget {
  const SelectColorWidget({super.key});

  @override
  State<SelectColorWidget> createState() => _SelectColorWidgetState();
}

class _SelectColorWidgetState extends State<SelectColorWidget> {
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
            itemCount: colors.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                  child: colorRoundedWidget(
                      colors[index], selectedIndex == index, 35));
            },
          ),
        )
      ],
    );
  }
}

Widget colorRoundedWidget(Color color, bool isSelected, double size) {
  return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      alignment: Alignment.center,
      height: size,
      width: size,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
      child: Icon(
        Icons.check,
        color: isSelected ? ColorName.white : Colors.transparent,
      ));
}
