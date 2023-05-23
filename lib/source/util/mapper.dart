import 'dart:io';

import 'package:goodwill/source/data/model/cart_item_dto.dart';
import 'package:goodwill/source/data/model/cart_item_model.dart';
import 'package:goodwill/source/data/model/message_dto.dart';
import 'package:goodwill/source/data/model/message_model.dart';
import 'package:goodwill/source/data/model/product_model.dart';
import 'package:goodwill/source/data/model/user_profile.dart';
import 'package:goodwill/source/service/auth_service.dart';
import 'package:goodwill/source/service/product_service.dart';
import 'package:goodwill/source/service/user_profile_service.dart';
import 'package:goodwill/source/util/constant.dart';
import 'package:goodwill/source/util/date_time_helper.dart';

import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as pathProvider;

class Mapper {
  static Future<MessageDto> messageModelToRecentMessageDto(
      MessageModel messageData) async {
    String id = (AuthService.userId == messageData.senderId)
        ? messageData.targetUserId!
        : messageData.senderId!;
    UserProfile? profile = await UserProfileService.getUserProfile(id);

    String sender = profile?.getDisplayName() ?? 'User';
    String time = DateTimeHelper.toFullClockTime(messageData.createdAt);
    String day = DateTimeHelper.toVietnameseStandardDate(messageData.createdAt);
    String text = messageData.text ?? '';
    String avatar = profile?.profilePicture ?? Constant.SAMPLE_AVATAR_URL;
    String targetUserId = (AuthService.userId == messageData.senderId)
        ? messageData.targetUserId!
        : messageData.senderId!;

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

    return MessageDto(
        sender: sender,
        time: time,
        text: text,
        avatar: avatar,
        day: day,
        targetUserId: targetUserId,
        chatRoomId: messageData.getChatRoomId());
  }

  static bool _isMe(String id) {
    return AuthService.userId == id;
  }

  static Future<List<MessageDto>> messageModelListDataToMessageDtoList(
      List<MessageModel> messageListData) async {
    List<MessageDto> res = [];

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
      String chatRoomId = messageData.getChatRoomId();
      String? targetUserId = messageData.targetUserId;

      res.add(MessageDto(
        sender: sender,
        time: time,
        text: text,
        avatar: avatar,
        day: day,
        chatRoomId: chatRoomId,
        targetUserId: targetUserId,
      ));
    }

    return res;
  }

  static Future<List<CartItemDto>> cartItemListToCartItemDtoList(
      List<CartItemModel>? cartItems) async {
    List<CartItemDto> res = [];

    for (var cartItem in cartItems ?? []) {
      final cartItemDto = await cartItemModelToCartItemDto(cartItem);
      res.add(cartItemDto);
    }

    return res;
  }

  static Future<CartItemDto> cartItemModelToCartItemDto(
      CartItemModel cartItemModel) async {
    ProductModel? product = await ProductService.get(cartItemModel.productId!);
    UserProfile? sellerProfile =
        await UserProfileService.getUserProfile(product?.ownerId ?? 'testUser');

    String id = cartItemModel.id ?? 'test';
    String title = product?.title ?? 'Item';
    String location = product?.location ?? 'Da Nang';
    int price = product?.price ?? 0;
    int quantity = cartItemModel.quantity ?? 0;
    String sellerId = product?.ownerId ?? 'test';
    String imageUrl = product?.images?.first ?? Constant.SAMPLE_AVATAR_URL;
    String phoneNumber =
        sellerProfile?.phoneNumber ?? Constant.FAKE_PHONENUMBER;
    String? category = product?.category;

    return CartItemDto(
      id: id,
      title: title,
      price: price,
      location: location,
      quantity: quantity,
      sellerId: sellerId,
      imageUrl: imageUrl,
      phoneNumber: phoneNumber,
      category: category,
    );
  }
}
