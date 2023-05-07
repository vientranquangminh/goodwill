// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import '../../models/chat_model/user_model.dart';

class MessageDTO {
  final String sender;
  final String? avatar;
  final String time;
  final String? day;
  final String text;

  MessageDTO({
    required this.sender,
    this.avatar,
    required this.time,
    this.day,
    required this.text,
  });

  MessageDTO copyWith({
    String? sender,
    String? avatar,
    String? time,
    String? day,
    String? text,
  }) {
    return MessageDTO(
      sender: sender ?? this.sender,
      avatar: avatar ?? this.avatar,
      time: time ?? this.time,
      day: day ?? this.day,
      text: text ?? this.text,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'sender': sender,
      'avatar': avatar,
      'time': time,
      'day': day,
      'text': text,
    };
  }

  factory MessageDTO.fromMap(Map<String, dynamic> map) {
    return MessageDTO(
      sender: map['sender'] as String,
      avatar: map['avatar'] != null ? map['avatar'] as String : null,
      time: map['time'] as String,
      day: map['day'] != null ? map['day'] as String : null,
      text: map['text'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory MessageDTO.fromJson(String source) =>
      MessageDTO.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Message(sender: $sender, avatar: $avatar, time: $time, day: $day, text: $text)';
  }

  @override
  bool operator ==(covariant MessageDTO other) {
    if (identical(this, other)) return true;

    return other.sender == sender &&
        other.avatar == avatar &&
        other.time == time &&
        other.day == day &&
        other.text == text;
  }

  @override
  int get hashCode {
    return sender.hashCode ^
        avatar.hashCode ^
        time.hashCode ^
        day.hashCode ^
        text.hashCode;
  }
}

List<MessageDTO> recentChats = [
  MessageDTO(
      sender: 'drake',
      avatar: 'assets/images/message_screen/Addison.jpg',
      time: '10:00 AM',
      text: "My pleasure. All the best for...",
      day: 'Today'),
  MessageDTO(
    sender: 'aidan',
    avatar: 'assets/images/message_screen/Angel.jpg',
    time: '18:00 AM',
    text: "Your solution is great 🔥🔥🔥",
    day: 'Yesterday',
  ),
  MessageDTO(
    sender: 'salvatore',
    avatar: 'assets/images/message_screen/Jason.jpg',
    time: '10:30 AM',
    text: "Thanks for the help doctor 🙏🏽",
    day: '20/12/2022',
  ),
  MessageDTO(
    sender: 'delaney',
    avatar: 'assets/images/message_screen/Judd.jpg',
    time: '17:00 AM',
    text: "I have recovered, thank you...",
    day: '14/12/2022',
  ),
  MessageDTO(
    sender: 'beckett',
    avatar: 'assets/images/message_screen/Leslie.jpg',
    time: '09:30 AM',
    text: "I went there yesterday 😄",
    day: '26/11/2022',
  ),
  MessageDTO(
      sender: 'berrnard',
      avatar: 'assets/images/message_screen/Nathan.jpg',
      time: '10:30 AM',
      text: "IDK what else is there to do",
      day: '09/11/2022'),
  MessageDTO(
      sender: 'jada',
      avatar: 'assets/images/message_screen/Stanley.jpg',
      time: '15:30 AM',
      text: "I advice you to take a break 🛏",
      day: '18/10/2022'),
  MessageDTO(
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

final List<MessageDTO> messages = [
  MessageDTO(
    sender: 'drake',
    time: '16:02',
    text:
        "Recently i often feel unwell. I also sometimes experience pain in the legs, and I don't know why. Do you know anything doc?",
  ),
  MessageDTO(
    sender: 'currentUser',
    time: '16:02',
    text:
        "Recently i often feel unwell. I also sometimes experience pain in the legs, and I don't know why. Do you know anything doc? 😭",
  ),
  MessageDTO(
    sender: 'drake',
    time: '16:01',
    text:
        "Can you tell me the problem you are having? So that i can indentify it",
  ),
  MessageDTO(
    sender: 'drake',
    time: '16:01',
    avatar: drake.avatar,
    text: "Hello, good afternoon too Andrew 😁",
  ),
  MessageDTO(
    sender: 'currentUser',
    time: '16:00',
    text: "I'm Andrew, I have a problem with my immune system 😢",
  ),
  MessageDTO(
    sender: 'currentUser',
    time: '16:00',
    avatar: drake.avatar,
    text: "Hi, good afternoon Dr.Drake... 😁",
  ),
];
