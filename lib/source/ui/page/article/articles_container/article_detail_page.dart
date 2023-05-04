import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:goodwill/gen/assets.gen.dart';
import 'package:goodwill/gen/colors.gen.dart';
import 'package:goodwill/source/common/extensions/build_context_ext.dart';
import 'package:goodwill/source/common/extensions/text_style_ext.dart';
import 'package:url_launcher/url_launcher.dart';

import '../article_object.dart';

const String phoneNumber = '0844876456';

class ArticleDetailPage extends StatelessWidget {
  const ArticleDetailPage({Key? key, required this.article}) : super(key: key);
  final Article article;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: const IconThemeData(
          color: Colors.black, // Set the color you want here
        ),
        title: Text(
          context.localizations.article,
          style: const TextStyle(color: Colors.black, fontSize: 22),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: ListView(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: SizedBox(
                        child: Image.network(
                          article.imgUrl ?? '',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      article.title ?? '',
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w500),
                      textAlign: TextAlign.start,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text(article.time ?? ''),
                        const SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Divider(
                      color: Colors.black,
                      thickness: 0.5,
                    ),
                    Text(
                      article.content ?? '',
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.normal),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 71,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      height: 50.h,
                      width: MediaQuery.of(context).size.width / 2.75.w,
                      child: ElevatedButton(
                        onPressed: () {
                          log('chat with sms');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0.r),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.sms_outlined),
                            SizedBox(width: 10.w),
                            Text(
                              context.localizations.sms,
                              style: context.whiteS16W500,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50.h,
                      width: MediaQuery.of(context).size.width / 2.75.w,
                      child: ElevatedButton(
                        onPressed: () {
                          Uri uri = Uri.parse('tel://$phoneNumber');
                          _launch(uri);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0.r),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.phone_forwarded),
                            SizedBox(width: 10.w),
                            Text(
                              context.localizations.call,
                              style: context.whiteS16W500,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50.h,
                      width: MediaQuery.of(context).size.width / 2.75.w,
                      child: ElevatedButton(
                        onPressed: () {
                          log('chat using app');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0.r),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Assets.svgs.message.svg(
                                colorFilter: const ColorFilter.mode(
                                    ColorName.white, BlendMode.srcIn)),
                            SizedBox(width: 10.w),
                            Text(
                              context.localizations.chat,
                              style: context.whiteS16W500,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _launch(Uri uri) async {
    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $uri');
    }
  }
}
