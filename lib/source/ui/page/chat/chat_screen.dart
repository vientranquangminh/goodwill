import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:goodwill/source/common/extensions/build_context_ext.dart';
import 'package:goodwill/source/data/model/message_dto.dart';
import 'package:goodwill/source/data/model/message_model.dart';
import 'package:goodwill/source/routes.dart';
import 'package:goodwill/source/service/message.service.dart';
import 'package:goodwill/source/ui/page/search/widgets/not_found_screen.dart';
import 'package:goodwill/source/util/mapper.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 884),
      builder: (BuildContext context, Widget? child) {
        return Scaffold(
            appBar: AppBar(
              title: const Text(
                "Chats",
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
              backgroundColor: Colors.transparent,
              leading: const BackButton(
                color: Colors.black,
              ),
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0.h, horizontal: 16.w),
              child: StreamProvider<List<MessageModel>?>.value(
                  initialData: [],
                  value: MessageService.getStreamRecentChatRoomIds(),
                  builder: (context, snapshot) {
                    final recentMessageData =
                        context.watch<List<MessageModel>?>();

                    if (recentMessageData == null) {
                      return const NotFoundScreen();
                    }
                    return FutureProvider<List<MessageDto>?>.value(
                        initialData: [],
                        value: Mapper.messageModelListDataToMessageDtoList(
                            recentMessageData),
                        builder: (context, snapshot) {
                          final recentMessageDTOs =
                              context.watch<List<MessageDto>?>() ?? [];

                          return ListView.builder(
                            itemCount: recentMessageDTOs.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  context.pushNamedWithParam(
                                      Routes.roomChatScreen,
                                      recentMessageDTOs[index]);
                                },
                                child: Container(
                                    margin: EdgeInsets.only(top: 24.h),
                                    child: Row(
                                      children: [
                                        CircleAvatar(
                                          radius: 25,
                                          // backgroundImage: AssetImage(
                                          //     recentMessageDTOs[index].avatar!),
                                          backgroundImage:
                                              CachedNetworkImageProvider(
                                                  recentMessageDTOs[index]
                                                      .avatar!),
                                        ),
                                        SizedBox(width: 20.w),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              recentMessageDTOs[index].sender,
                                              style: const TextStyle(
                                                  color: Colors.grey,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            const SizedBox(height: 8),
                                            Text(
                                              recentMessageDTOs[index].text,
                                              style: const TextStyle(
                                                      color: Colors.grey)
                                                  .copyWith(fontSize: 14.sp),
                                            ),
                                          ],
                                        ),
                                        const Spacer(),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              recentMessageDTOs[index].day!,
                                              style: const TextStyle(
                                                      color: Colors.grey)
                                                  .copyWith(fontSize: 14.sp),
                                            ),
                                            SizedBox(height: 6.h),
                                            Text(
                                              recentMessageDTOs[index].time,
                                              style: const TextStyle(
                                                      color: Colors.grey)
                                                  .copyWith(fontSize: 14.sp),
                                            ),
                                          ],
                                        ),
                                      ],
                                    )),
                              );
                            },
                          );
                        });
                  }),
            ));
      },
    );
  }
}
