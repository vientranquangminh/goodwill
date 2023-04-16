import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../models/chat_model/message_model.dart';
import 'room_chat_screen.dart';

class ChatDoctorScreen extends StatelessWidget {
  const ChatDoctorScreen({Key? key}) : super(key: key);

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
              child: ListView.builder(
                itemCount: recentChats.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return RoomChatScreen(
                          user: recentChats[index].sender,
                        );
                      }));
                    },
                    child: Container(
                        margin: EdgeInsets.only(top: 24.h),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 25,
                              backgroundImage:
                                  AssetImage(recentChats[index].avatar!),
                            ),
                            SizedBox(width: 20.w),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  recentChats[index].sender.name,
                                  style: const TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  recentChats[index].text,
                                  style: const TextStyle(color: Colors.grey)
                                      .copyWith(fontSize: 14.sp),
                                ),
                              ],
                            ),
                            const Spacer(),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  recentChats[index].day!,
                                  style: const TextStyle(color: Colors.grey)
                                      .copyWith(fontSize: 14.sp),
                                ),
                                SizedBox(height: 6.h),
                                Text(
                                  recentChats[index].time,
                                  style: const TextStyle(color: Colors.grey)
                                      .copyWith(fontSize: 14.sp),
                                ),
                              ],
                            ),
                          ],
                        )),
                  );
                },
              ),
            ));
      },
    );
  }
}
