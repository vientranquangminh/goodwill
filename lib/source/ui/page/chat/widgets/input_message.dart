import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:goodwill/source/data/model/message_model.dart';
import 'package:goodwill/source/service/auth_service.dart';
import 'package:goodwill/source/service/message.service.dart';
import 'package:goodwill/source/ui/page/chat/widgets/show_attach.dart';

class InputMessage extends StatelessWidget {
  const InputMessage({
    Key? key,
    this.targetUserId,
  }) : super(key: key);

  final String? targetUserId;

  @override
  Widget build(BuildContext context) {
    TextEditingController _messageController = TextEditingController();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      color: Colors.white,
      height: 100,
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              height: 60,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.emoji_emotions_outlined,
                    color: Colors.grey[500],
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: _messageController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Type a message ...',
                        hintStyle: const TextStyle(color: Colors.grey)
                            .copyWith(fontSize: 14),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      showModalBottomSheet(
                        backgroundColor: Colors.transparent,
                        context: context,
                        builder: (context) {
                          return SizedBox(
                            height: 260.h,
                            width: MediaQuery.of(context).size.width,
                            child: Container(
                                margin: const EdgeInsets.only(
                                        bottom: 90, left: 20, right: 20)
                                    .r,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(30)),
                                child: Padding(
                                  padding: const EdgeInsets.all(30.0).r,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ShowAttachCard(
                                          onPressed: () => log('Document'),
                                          color: Colors.orangeAccent,
                                          icon:
                                              'assets/images/message_screen/google-docs_1.svg',
                                          title: 'Document'),
                                      ShowAttachCard(
                                          onPressed: () => log('Gallery'),
                                          color: Colors.greenAccent,
                                          icon:
                                              'assets/images/message_screen/gallery_1.svg',
                                          title: 'Gallery'),
                                      ShowAttachCard(
                                          onPressed: () => log('Audio'),
                                          color: Colors.pinkAccent,
                                          icon:
                                              'assets/images/message_screen/headphone-symbol_1.svg',
                                          title: 'Audio'),
                                    ],
                                  ),
                                )),
                          );
                        },
                      );
                    },
                    icon: Icon(
                      Icons.attach_file,
                      color: Colors.grey[500],
                    ),
                  ),
                  // const SizedBox(width: 10),
                  IconButton(
                    onPressed: () {
                      log('camera');
                    },
                    icon: Icon(
                      Icons.camera_alt_rounded,
                      color: Colors.grey[500],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          CircleAvatar(
              radius: 20,
              backgroundColor: Colors.black,
              child: IconButton(
                onPressed: () {
                  log('send');
                  log(_messageController.text);

                  MessageService.sendMessage(MessageModel(
                    senderId: AuthService.userId,
                    targetUserId: targetUserId,
                    createdAt: DateTime.now(),
                    text: _messageController.text,
                  ));

                  _messageController.clear();
                },
                icon: const Icon(
                  Icons.send,
                  color: Colors.white,
                  size: 20,
                ),
              ))
        ],
      ),
    );
  }
}
