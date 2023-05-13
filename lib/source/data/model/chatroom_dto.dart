// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ChatRoomDto {
  final String sender;
  final String chatRoomId;
  final String targetUserId;

  ChatRoomDto({
    required this.sender,
    required this.chatRoomId,
    required this.targetUserId,
  });

  ChatRoomDto copyWith({
    String? sender,
    String? chatRoomId,
    String? targetUserId,
  }) {
    return ChatRoomDto(
      sender: sender ?? this.sender,
      chatRoomId: chatRoomId ?? this.chatRoomId,
      targetUserId: targetUserId ?? this.targetUserId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'sender': sender,
      'chatRoomId': chatRoomId,
      'targetUserId': targetUserId,
    };
  }

  factory ChatRoomDto.fromMap(Map<String, dynamic> map) {
    return ChatRoomDto(
      sender: map['sender'] as String,
      chatRoomId: map['chatRoomId'] as String,
      targetUserId: map['targetUserId'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatRoomDto.fromJson(String source) =>
      ChatRoomDto.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'ChatRoomDto(sender: $sender, chatRoomId: $chatRoomId, targetUserId: $targetUserId)';

  @override
  bool operator ==(covariant ChatRoomDto other) {
    if (identical(this, other)) return true;

    return other.sender == sender &&
        other.chatRoomId == chatRoomId &&
        other.targetUserId == targetUserId;
  }

  @override
  int get hashCode =>
      sender.hashCode ^ chatRoomId.hashCode ^ targetUserId.hashCode;
}
