import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:goodwill/source/common/extensions/build_context_ext.dart';
import 'package:goodwill/source/ui/page/chat/widgets/input_message.dart';

import '../../../models/chat_model/message_model.dart';
import '../../../models/chat_model/user_model.dart';

class RoomChatScreen extends StatefulWidget {
  const RoomChatScreen({Key? key}) : super(key: key);

  @override
  State<RoomChatScreen> createState() => _RoomChatScreenState();
}

class _RoomChatScreenState extends State<RoomChatScreen> {
  @override
  Widget build(BuildContext context) {
    final User user = context.getParam() as User;
    return ScreenUtilInit(
      designSize: const Size(428, 882),
      builder: (context, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              user.name.toString(),
              style: const TextStyle(color: Colors.black, fontSize: 20),
            ),
            backgroundColor: Colors.white,
            leading: const BackButton(
              color: Colors.black, // <-- SEE HERE
            ),
          ),
          backgroundColor: Colors.black,
          body: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                    child: ClipRRect(
                      child: ListView.builder(
                          reverse: true,
                          itemCount: messages.length,
                          itemBuilder: (context, int index) {
                            final message = messages[index];
                            bool isMe = message.sender.id == currentUser.id;
                            return Container(
                              margin: const EdgeInsets.only(top: 10).r,
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: isMe
                                        ? MainAxisAlignment.end
                                        : MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(10),
                                        constraints: BoxConstraints(
                                            maxWidth: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.6),
                                        decoration: BoxDecoration(
                                            color: isMe
                                                ? Colors.blue
                                                : Colors.grey[200],
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(
                                                  isMe ? 16 : 3),
                                              topRight:
                                                  const Radius.circular(16),
                                              bottomLeft:
                                                  const Radius.circular(12),
                                              bottomRight: Radius.circular(
                                                  isMe ? 3 : 12),
                                            )),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              messages[index].text,
                                              style: const TextStyle(
                                                      color: Colors.black)
                                                  .copyWith(
                                                      color: isMe
                                                          ? Colors.white
                                                          : Colors.grey[800]),
                                            ),
                                            SizedBox(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  if (isMe)
                                                    Icon(Icons.done_all,
                                                        size: 16.sp,
                                                        color: Colors.white),
                                                  SizedBox(
                                                    width: 8.w,
                                                  ),
                                                  Text(message.time,
                                                      style: isMe
                                                          ? const TextStyle(
                                                              color:
                                                                  Colors.white)
                                                          : const TextStyle(
                                                              color:
                                                                  Colors.grey))
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          }),
                    ),
                  ),
                ),
                const InputMessage()
              ],
            ),
          ),
        );
      },
    );
  }
}
