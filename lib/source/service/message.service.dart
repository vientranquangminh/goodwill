import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:goodwill/source/data/dto/message_dto.dart';
import 'package:goodwill/source/data/model/message_model.dart';
import 'package:goodwill/source/data/repository/message_repository.dart';
import 'package:goodwill/source/util/mapper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MessageService {
  static final FirebaseFirestore _instance = FirebaseFirestore.instance;
  static final MessageRepository _messageRepository = MessageRepository();
  final CollectionReference _chatRoomsCollectionRef =
      FirebaseFirestore.instance.collection("chatRooms");

  static Future<void> sendMessage(MessageModel message) async {
    _updateRecentChats(message);
    return _messageRepository.add(message);
  }

  static Future<List<MessageModel>?> getAllMessagesIn(String chatRoomId) async {
    return _messageRepository.getAll(
        collectionRef: _messageRepository.getMessagesCollectionRef(chatRoomId));
  }

  static Stream<List<MessageModel>?> getStreamAllMessagesIn(String chatRoomId) {
    return _messageRepository.getStreamAllFromQuery(
        query: _messageRepository
            .getMessagesCollectionRef(chatRoomId)
            .orderBy("createdAt", descending: true));
  }

  static Stream<List<String>?> getRecentChatRooms() {
    return _messageRepository.getStreamRecentChatRoomIds();
  }

  // static Stream<List<String>?> getAllMessagesIn(
  //     String chatRoomId) async {
  //   return _messageRepository.getAll(
  //       collectionRef: _messageRepository.getMessagesCollectionRef(chatRoomId));
  // }

  // static Stream<List<MessageModel>?> getStreamRecentChatRoomIds() {
  //   return _messageRepository.getStreamRecentChatRoomIds(
  //       yourId: AuthService.userId!);
  // }

  static Future<List<MessageDto>> getRecentChatsFromSharedPref() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? recentChatsJson = prefs.getString('recentChats');
    List list = json.decode(recentChatsJson ?? '[]');
    return list.map((e) => MessageDto.fromJson(e.toString())).toList();
  }

  static void _updateRecentChats(MessageModel newMessage) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final MessageDto newRecentMessage =
        await Mapper.messageModelToRecentMessageDto(newMessage);

    String? recentChatsJson = prefs.getString('recentChats');
    List? list = json.decode(recentChatsJson ?? '[]');
    List<MessageDto>? recentChats =
        list?.map((e) => MessageDto.fromJson(e.toString())).toList();

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
