import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:goodwill/gen/assets.gen.dart';
import 'package:goodwill/gen/colors.gen.dart';
import 'package:goodwill/source/common/extensions/build_context_ext.dart';
import 'package:goodwill/source/common/extensions/text_style_ext.dart';
import 'package:goodwill/source/data/model/article_model.dart';
import 'package:goodwill/source/data/model/chatroom_dto.dart';
import 'package:goodwill/source/data/model/user_profile.dart';
import 'package:goodwill/source/routes.dart';
import 'package:goodwill/source/service/auth_service.dart';
import 'package:goodwill/source/service/user_profile_service.dart';
import 'package:goodwill/source/util/constant.dart';
import 'package:goodwill/source/util/date_time_helper.dart';
import 'package:goodwill/source/util/message_helper.dart';
import 'package:url_launcher/url_launcher.dart';

const String phoneNumber = '0844876456';

class ArticleDetailPage extends StatelessWidget {
  const ArticleDetailPage({Key? key, required this.article}) : super(key: key);
  final ArticleModel article;

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
          context.localizations.topic,
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
                          article.image ?? Constant.SAMPLE_AVATAR_URL,
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
                        Text(
                            DateTimeHelper.toFriendlyString(article.createdAt)),
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
            Container(
              height: 71.h,
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    margin: EdgeInsets.all(10.r),
                    child: ElevatedButton(
                      onPressed: () {
                        Uri uri = Uri.parse('sms://$phoneNumber');
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
                          const Icon(Icons.sms_outlined),
                          SizedBox(width: 10.w),
                          Text(
                            context.localizations.sms,
                            style: context.whiteS12W500,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(10.r),
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
                            style: context.whiteS12W500,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(10.r),
                    child: ElevatedButton(
                      onPressed: () async {
                        log('chat using app');

                        UserProfile? userProfile =
                            await UserProfileService.getUserProfile(
                                article.ownerId!);
                        List<String> ids = [
                          article.ownerId!,
                          AuthService.userId!
                        ];

                        final chatRoomDto = ChatRoomDto(
                            chatRoomId: MessageHelper.getChatRoomId(ids),
                            sender: userProfile?.getDisplayName() ?? 'User',
                            targetUserId: article.ownerId!);
                        context.pushNamedWithParam(
                            Routes.roomChatScreen, chatRoomDto);
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
                            style: context.whiteS12W500,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
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
