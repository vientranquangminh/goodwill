// // ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'dart:convert';

// import 'package:flutter/foundation.dart';

// class ChatRoom {
//   String id;
//   final List<String>? memberEmails;

//   ChatRoom({
//     required this.id,
//     this.memberEmails,
//   });

//   ChatRoom copyWith({
//     String? id,
//     List<String>? memberEmails,
//   }) {
//     return ChatRoom(
//       id: id ?? this.id,
//       memberEmails: memberEmails ?? this.memberEmails,
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return <String, dynamic>{
//       'id': id,
//       'memberEmails': memberEmails,
//     };
//   }

//   factory ChatRoom.fromMap(Map<String, dynamic> map) {
//     return ChatRoom(
//       id: map['id'] as String,
//       memberEmails: map['memberEmails'] != null
//           ? List<String>.from(map['memberEmails'])
//           : null,
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory ChatRoom.fromJson(String source) =>
//       ChatRoom.fromMap(json.decode(source) as Map<String, dynamic>);

//   @override
//   String toString() => 'ChatRoom(id: $id, memberEmails: $memberEmails)';

//   @override
//   bool operator ==(covariant ChatRoom other) {
//     if (identical(this, other)) return true;

//     return other.id == id && listEquals(other.memberEmails, memberEmails);
//   }

//   @override
//   int get hashCode => id.hashCode ^ memberEmails.hashCode;
// }
