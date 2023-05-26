import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:goodwill/source/common/extensions/build_context_ext.dart';
import 'package:goodwill/source/data/dto/chatroom_dto.dart';
import 'package:goodwill/source/data/dto/message_dto.dart';
import 'package:goodwill/source/data/model/message_model.dart';
import 'package:goodwill/source/data/model/user_profile.dart';
import 'package:goodwill/source/routes.dart';
import 'package:goodwill/source/service/message.service.dart';
import 'package:goodwill/source/service/user_profile_service.dart';
import 'package:goodwill/source/ui/page/search/widgets/not_found_screen.dart';
import 'package:goodwill/source/util/mapper.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 884),
      builder: (BuildContext context, Widget? child) {
        return Scaffold(
            appBar: AppBar(
              title: Text(
                context.localizations.chat,
                style: const TextStyle(color: Colors.black, fontSize: 20),
              ),
              backgroundColor: Colors.transparent,
              leading: const BackButton(
                color: Colors.black,
              ),
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0.h, horizontal: 16.w),
              child: StreamProvider<List<String>?>.value(
                  initialData: [],
                  value: MessageService.getRecentChatRooms(),
                  builder: (context, snapshot) {
                    final chatRoomIds = context.watch<List<String>?>();
                    if (chatRoomIds == null) {
                      return const NotFoundScreen();
                    }

                    final List<Stream<List<MessageModel>?>> streams =
                        chatRoomIds
                            .map((chatRoomId) =>
                                MessageService.getStreamAllMessagesIn(
                                    chatRoomId))
                            .toList();
                    final Stream<List<MessageModel>?> combineLatestStream =
                        CombineLatestStream(streams, (listOfList) {
                      return listOfList
                          .map((list) => list?.first ?? MessageModel())
                          .toList();
                    }).cast();

                    return StreamProvider<List<MessageModel>?>.value(
                        value: combineLatestStream,
                        initialData: [],
                        builder: (context, child) {
                          final recentMessages =
                              context.watch<List<MessageModel>?>();
                          if (recentMessages == null) {
                            return const NotFoundScreen();
                          }

                          return ListView.builder(
                            itemCount: recentMessages.length,
                            itemBuilder: (context, index) {
                              return FutureProvider<MessageDto>.value(
                                  initialData: recentChats[0],
                                  value: Mapper.messageModelToRecentMessageDto(
                                      recentMessages[index]),
                                  builder: (context, snapshot) {
                                    final msgDto = context.watch<MessageDto>();
                                    return InkWell(
                                      onTap: () async {
                                        UserProfile? userProfile =
                                            await UserProfileService
                                                .getUserProfile(
                                                    msgDto.targetUserId!);
                                        final chatRoomDto = ChatRoomDto(
                                            sender:
                                                userProfile?.getDisplayName() ??
                                                    'User',
                                            chatRoomId:
                                                msgDto.chatRoomId ?? 'test',
                                            targetUserId: msgDto.targetUserId!);

                                        context.pushNamedWithParam(
                                            Routes.roomChatScreen, chatRoomDto);
                                      },
                                      child: Container(
                                          margin: EdgeInsets.only(top: 24.h),
                                          child: Row(
                                            children: [
                                              CircleAvatar(
                                                radius: 25,
                                                backgroundImage:
                                                    CachedNetworkImageProvider(
                                                        msgDto.avatar!),
                                              ),
                                              SizedBox(width: 20.w),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    msgDto.sender,
                                                    style: const TextStyle(
                                                        color: Colors.grey,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  const SizedBox(height: 8),
                                                  Text(
                                                    msgDto.text,
                                                    style: const TextStyle(
                                                            color: Colors.grey)
                                                        .copyWith(
                                                            fontSize: 14.sp),
                                                  ),
                                                ],
                                              ),
                                              const Spacer(),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  Text(
                                                    msgDto.day!,
                                                    style: const TextStyle(
                                                            color: Colors.grey)
                                                        .copyWith(
                                                            fontSize: 14.sp),
                                                  ),
                                                  SizedBox(height: 6.h),
                                                  Text(
                                                    msgDto.time,
                                                    style: const TextStyle(
                                                            color: Colors.grey)
                                                        .copyWith(
                                                            fontSize: 14.sp),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          )),
                                    );
                                  });
                            },
                          );
                        });
                  }),
            ));
      },
    );
  }
}

class _buildRecentChat extends StatelessWidget {
  const _buildRecentChat({
    super.key,
    required this.chatRoomIds,
  });

  final List<String>? chatRoomIds;

  @override
  Widget build(BuildContext context) {
    final List<Stream<List<MessageModel>?>> streams = chatRoomIds!
        .map((e) => MessageService.getStreamAllMessagesIn(e))
        .toList();

    final recentChatStream =
        CombineLatestStream.list<List<MessageModel>?>(streams);

    return StreamProvider<List<MessageModel>?>.value(
        initialData: [],
        value: recentChatStream.cast(),
        builder: (context, snapshot) {
          return ListView.builder(
            itemCount: streams.length,
            itemBuilder: (context, index) {
              // return const Text('msg');
              return StreamProvider<List<MessageModel>?>.value(
                  initialData: [],
                  value: streams[index],
                  builder: (context, snapshot) {
                    final newestMsg =
                        context.watch<List<MessageModel>?>()?[0] ??
                            MessageModel();
                    return FutureProvider<MessageDto>.value(
                        initialData: recentChats[0],
                        value: Mapper.messageModelToRecentMessageDto(newestMsg),
                        builder: (context, snapshot) {
                          final msgDto = context.watch<MessageDto>();
                          final chatRoomDto = ChatRoomDto(
                              sender: msgDto.sender,
                              chatRoomId: msgDto.chatRoomId!,
                              targetUserId: msgDto.targetUserId!);

                          return InkWell(
                            onTap: () {
                              context.pushNamedWithParam(
                                  Routes.roomChatScreen, chatRoomDto);
                            },
                            child: Container(
                                margin: EdgeInsets.only(top: 24.h),
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 25,
                                      backgroundImage:
                                          CachedNetworkImageProvider(
                                              msgDto.avatar!),
                                    ),
                                    SizedBox(width: 20.w),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          msgDto.sender,
                                          style: const TextStyle(
                                              color: Colors.grey,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          msgDto.text,
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
                                          msgDto.day!,
                                          style: const TextStyle(
                                                  color: Colors.grey)
                                              .copyWith(fontSize: 14.sp),
                                        ),
                                        SizedBox(height: 6.h),
                                        Text(
                                          msgDto.time,
                                          style: const TextStyle(
                                                  color: Colors.grey)
                                              .copyWith(fontSize: 14.sp),
                                        ),
                                      ],
                                    ),
                                  ],
                                )),
                          );
                        });
                  });
            },
          );
        });
  }
}
