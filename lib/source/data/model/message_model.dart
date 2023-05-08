// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:goodwill/source/data/model/basic_model.dart';

class MessageModel extends BasicModel {
  String? senderId;
  String? targetUserId;
  DateTime? createdAt;
  String? text;

  List<String?> get ids {
    final ls = [senderId, targetUserId];
    ls.sort();
    return ls;
  }

  MessageModel({
    String? id,
    this.senderId,
    this.targetUserId,
    this.createdAt,
    this.text,
  }) : super(id: id);

  MessageModel copyWith({
    String? senderId,
    String? targetUserId,
    DateTime? createdAt,
    String? text,
  }) {
    return MessageModel(
      senderId: senderId ?? this.senderId,
      targetUserId: targetUserId ?? this.targetUserId,
      createdAt: createdAt ?? this.createdAt,
      text: text ?? this.text,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'senderId': senderId,
      'targetUserId': targetUserId,
      'createdAt': createdAt?.millisecondsSinceEpoch,
      'text': text,
    };
  }

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      id: map['id'] != null ? map['id'] as String : null,
      senderId: map['senderId'] != null ? map['senderId'] as String : null,
      targetUserId:
          map['targetUserId'] != null ? map['targetUserId'] as String : null,
      createdAt: map['createdAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int)
          : null,
      text: map['text'] != null ? map['text'] as String : null,
    );
  }

  @override
  String toJson() => json.encode(toMap());

  factory MessageModel.fromJson(String source) =>
      MessageModel.fromMap(json.decode(source) as Map<String, dynamic>);

  factory MessageModel.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options) {
    final dataMap = snapshot.data();

    return MessageModel.fromMap(dataMap ?? {});
  }

  @override
  String toString() {
    return 'MessageModel2(id: $id, senderId: $senderId, targetUserId: $targetUserId, createdAt: $createdAt, text: $text)';
  }

  @override
  bool operator ==(covariant MessageModel other) {
    if (identical(this, other)) return true;

    return other.senderId == senderId &&
        other.targetUserId == targetUserId &&
        other.createdAt == createdAt &&
        other.text == text;
  }

  @override
  int get hashCode {
    return senderId.hashCode ^
        targetUserId.hashCode ^
        createdAt.hashCode ^
        text.hashCode;
  }

  String getChatRoomId() {
    ids.sort();
    return ids.join('|');
  }
}
