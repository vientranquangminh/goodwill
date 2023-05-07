import 'dart:io';

import 'package:goodwill/source/data/model/message_model.dart';
import 'package:goodwill/source/data/model/message_model2.dart';
import 'package:goodwill/source/data/model/user_profile.dart';
import 'package:goodwill/source/service/auth_service.dart';
import 'package:goodwill/source/service/user_profile_service.dart';
import 'package:goodwill/source/util/constant.dart';
import 'package:goodwill/source/util/date_time_helper.dart';

import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as pathProvider;

class Mapper {
  static Future<MessageDTO> messageModelToMessageDto(
      MessageModel2 messageData) async {
    UserProfile? senderProfile =
        await UserProfileService.getUserProfile(messageData.senderId!);

    String sender = senderProfile?.getDisplayName() ?? 'User';
    String time = DateTimeHelper.toFullClockTime(messageData.createdAt);
    String day = DateTimeHelper.toVietnameseStandardDate(messageData.createdAt);
    String text = messageData.text ?? '';
    String avatar = senderProfile?.profilePicture ?? Constant.SAMPLE_AVATAR_URL;

    // if (senderProfile?.profilePicture != null) {
    //   String url = senderProfile!.profilePicture!;
    //   final resp = await http.get(Uri.parse(url));

    //   // Get the image name
    //   final imageName = '${senderProfile.id}-${path.extension(url)}';
    //   // Get the document directory path
    //   final appDir = await pathProvider.getApplicationDocumentsDirectory();

    //   // This is the saved image path
    //   // You can use it to display the saved image later
    //   final localPath = path.join(appDir.path, imageName);

    //   // Downloading
    //   final imageFile = File(localPath);
    //   if (!imageFile.existsSync()) {
    //     await imageFile.writeAsBytes(resp.bodyBytes);
    //   }
    //   avatar = localPath;
    // }

    return MessageDTO(
        sender: sender, time: time, text: text, avatar: avatar, day: day);
  }

  static bool _isMe(String id) {
    return AuthService.userId == id;
  }

  static Future<List<MessageDTO>> messageModelListDataToMessageDtoList(
      List<MessageModel2> messageListData) async {
    List<MessageDTO> res = [];

    for (var messageData in messageListData) {
      UserProfile? targetProfile;
      if (_isMe(messageData.senderId!)) {
        targetProfile =
            await UserProfileService.getUserProfile(messageData.targetUserId!);
      } else {
        targetProfile =
            await UserProfileService.getUserProfile(messageData.senderId!);
      }

      String sender = targetProfile?.getDisplayName() ?? 'User';
      String time = DateTimeHelper.toFullClockTime(messageData.createdAt);
      String day =
          DateTimeHelper.toVietnameseStandardDate(messageData.createdAt);
      String text = messageData.text ?? '';
      String avatar =
          targetProfile?.profilePicture ?? Constant.SAMPLE_AVATAR_URL;

      res.add(MessageDTO(
          sender: sender, time: time, text: text, avatar: avatar, day: day));
    }

    return res;
  }
}
