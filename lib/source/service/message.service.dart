import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:goodwill/source/data/model/message_model2.dart';
import 'package:goodwill/source/data/repository/message_repository.dart';

class MessageService {
  static final FirebaseFirestore _instance = FirebaseFirestore.instance;
  static final MessageRepository _messageRepository = MessageRepository();

  static Future<void> sendMessage(MessageModel2 message) async {
    return _messageRepository.add(message);
  }

  static Future<List<MessageModel2>?> getAllMessagesIn(
      String chatRoomId) async {
    return _messageRepository.getAll(
        collectionRef: _messageRepository.getMessagesCollectionRef(chatRoomId));
  }

  static Stream<List<MessageModel2>?> getStreamAllMessages(String chatRoomId) {
    return _messageRepository.getStreamAll(
        collectionRef: _messageRepository.getMessagesCollectionRef(chatRoomId));
  }
}
