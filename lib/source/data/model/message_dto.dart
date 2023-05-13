// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class MessageDto {
  final String sender;
  final String? avatar;
  final String time;
  final String? day;
  final String text;
  final String? targetUserId;
  final String? chatRoomId;

  MessageDto({
    required this.sender,
    this.avatar,
    required this.time,
    this.day,
    required this.text,
    this.targetUserId,
    this.chatRoomId,
  });

  MessageDto copyWith({
    String? sender,
    String? avatar,
    String? time,
    String? day,
    String? text,
    String? targetUserId,
    String? chatRoomId,
  }) {
    return MessageDto(
      sender: sender ?? this.sender,
      avatar: avatar ?? this.avatar,
      time: time ?? this.time,
      day: day ?? this.day,
      text: text ?? this.text,
      targetUserId: targetUserId ?? this.targetUserId,
      chatRoomId: chatRoomId ?? this.chatRoomId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'sender': sender,
      'avatar': avatar,
      'time': time,
      'day': day,
      'text': text,
      'targetUserId': targetUserId,
      'chatRoomId': chatRoomId,
    };
  }

  factory MessageDto.fromMap(Map<String, dynamic> map) {
    return MessageDto(
      sender: map['sender'] as String,
      avatar: map['avatar'] != null ? map['avatar'] as String : null,
      time: map['time'] as String,
      day: map['day'] != null ? map['day'] as String : null,
      text: map['text'] as String,
      targetUserId:
          map['targetUserId'] != null ? map['targetUserId'] as String : null,
      chatRoomId:
          map['chatRoomId'] != null ? map['chatRoomId'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory MessageDto.fromJson(String source) =>
      MessageDto.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'MessageDto(sender: $sender, avatar: $avatar, time: $time, day: $day, text: $text, targetUserId: $targetUserId, chatRoomId: $chatRoomId)';
  }

  @override
  bool operator ==(covariant MessageDto other) {
    if (identical(this, other)) return true;

    return other.sender == sender &&
        other.avatar == avatar &&
        other.time == time &&
        other.day == day &&
        other.text == text &&
        other.targetUserId == targetUserId &&
        other.chatRoomId == chatRoomId;
  }

  @override
  int get hashCode {
    return sender.hashCode ^
        avatar.hashCode ^
        time.hashCode ^
        day.hashCode ^
        text.hashCode ^
        targetUserId.hashCode ^
        chatRoomId.hashCode;
  }
}

List<MessageDto> recentChats = [
  MessageDto(
      sender: 'drake',
      avatar: 'assets/images/message_screen/Addison.jpg',
      time: '10:00 AM',
      text: "My pleasure. All the best for...",
      day: 'Today'),
  MessageDto(
    sender: 'aidan',
    avatar: 'assets/images/message_screen/Angel.jpg',
    time: '18:00 AM',
    text: "Your solution is great 🔥🔥🔥",
    day: 'Yesterday',
  ),
  MessageDto(
    sender: 'salvatore',
    avatar: 'assets/images/message_screen/Jason.jpg',
    time: '10:30 AM',
    text: "Thanks for the help doctor 🙏🏽",
    day: '20/12/2022',
  ),
  MessageDto(
    sender: 'delaney',
    avatar: 'assets/images/message_screen/Judd.jpg',
    time: '17:00 AM',
    text: "I have recovered, thank you...",
    day: '14/12/2022',
  ),
  MessageDto(
    sender: 'beckett',
    avatar: 'assets/images/message_screen/Leslie.jpg',
    time: '09:30 AM',
    text: "I went there yesterday 😄",
    day: '26/11/2022',
  ),
  MessageDto(
      sender: 'berrnard',
      avatar: 'assets/images/message_screen/Nathan.jpg',
      time: '10:30 AM',
      text: "IDK what else is there to do",
      day: '09/11/2022'),
  MessageDto(
      sender: 'jada',
      avatar: 'assets/images/message_screen/Stanley.jpg',
      time: '15:30 AM',
      text: "I advice you to take a break 🛏",
      day: '18/10/2022'),
  MessageDto(
      sender: 'randy',
      avatar: 'assets/images/message_screen/Virgil.jpg',
      time: '10:30 AM',
      text: "Yeah! You right 💯💯",
      day: '7/10/2022'),
];

// final List<Message> allChats = [
//   Message(
//     sender: virgil,
//     avatar: 'assets/images/Virgil.jpg',
//     time: '12:59',
//     text: "No! I just wanted",
//   ),
//   Message(
//     sender: stanley,
//     avatar: 'assets/images/Stanley.jpg',
//     time: '10:41',
//     text: "You did what?",
//   ),
//   Message(
//     sender: leslie,
//     avatar: 'assets/images/Leslie.jpg',
//     time: '05:51',
//     text: "just signed up for a tutor",
//   ),
//   Message(
//     sender: judd,
//     avatar: 'assets/images/Judd.jpg',
//     time: '10:16',
//     text: "May I ask you something?",
//     day: ''
//   ),
// ];

// final List<MessageDto> messages = [
//   MessageDto(
//     sender: 'drake',
//     time: '16:02',
//     text:
//         "Recently i often feel unwell. I also sometimes experience pain in the legs, and I don't know why. Do you know anything doc?",
//   ),
//   MessageDto(
//     sender: 'currentUser',
//     time: '16:02',
//     text:
//         "Recently i often feel unwell. I also sometimes experience pain in the legs, and I don't know why. Do you know anything doc? 😭",
//   ),
//   MessageDto(
//     sender: 'drake',
//     time: '16:01',
//     text:
//         "Can you tell me the problem you are having? So that i can indentify it",
//   ),
//   MessageDto(
//     sender: 'drake',
//     time: '16:01',
//     avatar: drake.avatar,
//     text: "Hello, good afternoon too Andrew 😁",
//   ),
//   MessageDto(
//     sender: 'currentUser',
//     time: '16:00',
//     text: "I'm Andrew, I have a problem with my immune system 😢",
//   ),
//   MessageDto(
//     sender: 'currentUser',
//     time: '16:00',
//     avatar: drake.avatar,
//     text: "Hi, good afternoon Dr.Drake... 😁",
//   ),
// ];
