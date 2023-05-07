import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:goodwill/source/data/model/message_model2.dart';
import 'package:goodwill/source/data/repository/basic_repository.dart';

class MessageRepository extends BasicRepository<MessageModel2> {
  final CollectionReference _chatRoomsCollectionRef =
      FirebaseFirestore.instance.collection("chatRooms");

  String getChatRoomId(List<String?> userIds) {
    userIds.sort();
    return userIds.join('|');
  }

  CollectionReference getDefaultMessagesCollectionRef() {
    return _chatRoomsCollectionRef.doc('test').collection('messages');
  }

  CollectionReference getMessagesCollectionRef(String chatRoomId) {
    return _chatRoomsCollectionRef.doc(chatRoomId).collection('messages');
  }

  List<DocumentReference> _getNewDocumentRefs(String chatRoomId) {
    DocumentReference messagesDocRef =
        _chatRoomsCollectionRef.doc(chatRoomId).collection('messages').doc();

    return [messagesDocRef];
  }

  List<DocumentReference> _getDocumentRefs(String chatRoomId, String id) {
    DocumentReference messagesDocRef =
        _chatRoomsCollectionRef.doc(chatRoomId).collection('messages').doc(id);
    return [messagesDocRef];
  }

  @override
  Future<void> add(MessageModel2 message) async {
    String chatRoomId = getChatRoomId(message.ids);

    // if members field not created, then created
    DocumentReference chatRoomRef = _chatRoomsCollectionRef.doc(chatRoomId);
    chatRoomRef.get().then((DocumentSnapshot documentSnapshot) {
      var chatRoom = documentSnapshot.data();
      debugPrint(chatRoom.toString());
      if (chatRoom == null) {
        chatRoomRef.set({
          'members': message.ids,
        });
      }
    });

    List<DocumentReference> docRefs = _getNewDocumentRefs(chatRoomId);
    message.id = docRefs[0].id;

    return addWithDocRefs(message, docRefs: docRefs);
  }

  @override
  Future<void> delete(MessageModel2 element) {
    return deleteWithDocRefs(element,
        docRefs: _getDocumentRefs(getChatRoomId(element.ids), element.id!));
  }

  @override
  MessageModel2 Function(DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options) fromFirestore() {
    return MessageModel2.fromFirestore;
  }

  @override
  MessageModel2 fromMap(Map<String, dynamic> map) {
    return MessageModel2.fromMap(map);
  }

  @override
  Future<MessageModel2?> get(String elementId,
      {CollectionReference<Object?>? collectionRef}) {
    return getElementFromCollectionRef(elementId,
        collectionRef: (collectionRef != null)
            ? collectionRef
            : getDefaultMessagesCollectionRef());
  }

  @override
  Future<List<MessageModel2>?> getAll(
      {CollectionReference<Object?>? collectionRef}) {
    return getAllElementsFromCollectionRef(
        collectionRef: (collectionRef != null)
            ? collectionRef
            : getDefaultMessagesCollectionRef());
  }

  @override
  Stream<MessageModel2?> getStream(String elementId,
      {CollectionReference<Object?>? collectionRef}) {
    return getStreamElementFromCollectionRef(elementId,
        collectionRef: (collectionRef != null)
            ? collectionRef
            : getDefaultMessagesCollectionRef());
  }

  @override
  Stream<List<MessageModel2>?> getStreamAll(
      {CollectionReference<Object?>? collectionRef}) {
    return getStreamAllElementsFromCollectionRef(
        collectionRef: (collectionRef != null)
            ? collectionRef
            : getDefaultMessagesCollectionRef());
  }

  @override
  Future<void> update(MessageModel2 element) {
    return updateWithDocRefs(element,
        docRefs: _getDocumentRefs(getChatRoomId(element.ids), element.id!));
  }

  Future<MessageModel2?> getNewestMessageFromCollectionRef(
      {required CollectionReference collectionRef}) async {
    final converterCollectionRef = collectionRef
        .orderBy("createdAt")
        .withConverter(
            fromFirestore: fromFirestore(), toFirestore: (e, _) => e.toMap());
    final collectionSnap = await converterCollectionRef.get();
    final docs = collectionSnap.docs;
    if (docs.isEmpty) return null;
    final element = docs.last.data();

    debugPrint(element.toString());
    return element;
  }

  List<String>? _chatRoomIdsFromQuerySnapshot(
      QuerySnapshot<Object?> querySnapshot) {
    return querySnapshot.docs
        .map((QueryDocumentSnapshot<Object?> documentSnapshot) {
      if (documentSnapshot.exists) {
        return documentSnapshot.id;
      }
      return '';
    }).toList();
  }

  @override
  Stream<List<MessageModel2>?> getStreamRecentChatRoomIds(
      {required String yourId, int limit = 30}) {
    final chatRoomDocRefs = _chatRoomsCollectionRef
        .where("members", arrayContains: yourId)
        .limit(limit);
    ;
    final Stream<List<String>?> recentChatRoomIdsStream =
        chatRoomDocRefs.snapshots().map(_chatRoomIdsFromQuerySnapshot);

    return recentChatRoomIdsStream.asyncMap((chatRoomIds) async {
      if (chatRoomIds == null) return null;
      List<MessageModel2> res = [];
      for (var chatRoomId in chatRoomIds) {
        final value = await getNewestMessageFromCollectionRef(
            collectionRef: getMessagesCollectionRef(chatRoomId));
        res.add(value ?? MessageModel2());
      }
      res.sort(((a, b) {
        int mA = a.createdAt?.millisecondsSinceEpoch ?? 0;
        int mB = b.createdAt?.millisecondsSinceEpoch ?? 0;
        return mB - mA;
      }));
      return res;
    });
  }
}
