import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:goodwill/source/data/model/message_model.dart';
import 'package:goodwill/source/data/model/message_model2.dart';
import 'package:goodwill/source/data/repository/message_repository.dart';
import 'package:goodwill/source/service/auth_service.dart';
import 'package:goodwill/source/util/mapper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MessageService {
  static final FirebaseFirestore _instance = FirebaseFirestore.instance;
  static final MessageRepository _messageRepository = MessageRepository();
  final CollectionReference _chatRoomsCollectionRef =
      FirebaseFirestore.instance.collection("chatRooms");

  static Future<void> sendMessage(MessageModel2 message) async {
    _updateRecentChats(message);
    return _messageRepository.add(message);
  }

  static Future<List<MessageModel2>?> getAllMessagesIn(
      String chatRoomId) async {
    return _messageRepository.getAll(
        collectionRef: _messageRepository.getMessagesCollectionRef(chatRoomId));
  }

  static Stream<List<MessageModel2>?> getStreamAllMessagesIn(
      String chatRoomId) {
    return _messageRepository.getStreamAll(
        collectionRef: _messageRepository.getMessagesCollectionRef(chatRoomId));
  }

  // static Stream<List<String>?> getAllMessagesIn(
  //     String chatRoomId) async {
  //   return _messageRepository.getAll(
  //       collectionRef: _messageRepository.getMessagesCollectionRef(chatRoomId));
  // }

  static Stream<List<MessageModel2>?> getStreamRecentChatRoomIds() {
    return _messageRepository.getStreamRecentChatRoomIds(
        yourId: AuthService.userId!);
  }

  static Future<List<MessageDTO>> getRecentChatsFromSharedPref() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? recentChatsJson = prefs.getString('recentChats');
    List list = json.decode(recentChatsJson ?? '[]');
    return list.map((e) => MessageDTO.fromJson(e.toString())).toList();
  }

  static void _updateRecentChats(MessageModel2 newMessage) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final MessageDTO newRecentMessage =
        await Mapper.messageModelToMessageDto(newMessage);

    String? recentChatsJson = prefs.getString('recentChats');
    List? list = json.decode(recentChatsJson ?? '[]');
    List<MessageDTO>? recentChats =
        list?.map((e) => MessageDTO.fromJson(e.toString())).toList();

    if (recentChats == null) {
      recentChats = [newRecentMessage];
    } else {
      recentChats
          .removeWhere((element) => element.sender == newRecentMessage.sender);
      recentChats.insert(0, newRecentMessage);
    }

    prefs.setString('recentChats', json.encode(recentChats));
  }
}
