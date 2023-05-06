import 'package:cloud_firestore/cloud_firestore.dart';
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
      final chatRoom = documentSnapshot.data() as Map<String, dynamic>;
      if (chatRoom['members'] == null) {
        chatRoomRef.update({
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
}
