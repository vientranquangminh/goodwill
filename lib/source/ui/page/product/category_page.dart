import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:goodwill/gen/assets.gen.dart';
import 'package:goodwill/gen/colors.gen.dart';
import 'package:goodwill/source/common/extensions/build_context_ext.dart';
import 'package:goodwill/source/common/widgets/app_bar/custom_app_bar.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            leading: PlatformIconButton(
              icon: const Icon(
                Icons.arrow_back_ios,
                color: ColorName.black,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            actions: [Assets.svgs.icSearch.path],
            titleColor: ColorName.black,
            title: context.localizations.clothes),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Column(
              children: [],
            ),
          ),
        ));
  }
}
