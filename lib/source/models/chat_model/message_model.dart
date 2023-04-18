import './user_model.dart';

class Message {
  final User sender;
  final String? avatar;
  final String time;
  final String? day;
  final String text;

  Message({
    required this.sender,
    this.avatar,
    required this.time,
    required this.text,
    this.day,
  });
}

List<Message> recentChats = [
  Message(
      sender: drake,
      avatar: 'assets/images/message_screen/Addison.jpg',
      time: '10:00 AM',
      text: "My pleasure. All the best for...",
      day: 'Today'),
  Message(
    sender: aidan,
    avatar: 'assets/images/message_screen/Angel.jpg',
    time: '18:00 AM',
    text: "Your solution is great 🔥🔥🔥",
    day: 'Yesterday',
  ),
  Message(
    sender: salvatore,
    avatar: 'assets/images/message_screen/Jason.jpg',
    time: '10:30 AM',
    text: "Thanks for the help doctor 🙏🏽",
    day: '20/12/2022',
  ),
  Message(
    sender: delaney,
    avatar: 'assets/images/message_screen/Judd.jpg',
    time: '17:00 AM',
    text: "I have recovered, thank you...",
    day: '14/12/2022',
  ),
  Message(
    sender: beckett,
    avatar: 'assets/images/message_screen/Leslie.jpg',
    time: '09:30 AM',
    text: "I went there yesterday 😄",
    day: '26/11/2022',
  ),
  Message(
      sender: berrnard,
      avatar: 'assets/images/message_screen/Nathan.jpg',
      time: '10:30 AM',
      text: "IDK what else is there to do",
      day: '09/11/2022'),
  Message(
      sender: jada,
      avatar: 'assets/images/message_screen/Stanley.jpg',
      time: '15:30 AM',
      text: "I advice you to take a break 🛏",
      day: '18/10/2022'),
  Message(
      sender: randy,
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

final List<Message> messages = [
  Message(
    sender: drake,
    time: '16:02',
    text: "Recently i often feel unwell. I also sometimes experience pain in the legs, and I don't know why. Do you know anything doc?",
  ),
  Message(
    sender: currentUser,
    time: '16:02',
    text: "Recently i often feel unwell. I also sometimes experience pain in the legs, and I don't know why. Do you know anything doc? 😭",
  ),
  Message(
    sender: drake,
    time: '16:01',
    text:
        "Can you tell me the problem you are having? So that i can indentify it",
  ),
  Message(
    sender: drake,
    time: '16:01',
    avatar: drake.avatar,
    text: "Hello, good afternoon too Andrew 😁",
  ),
  Message(
    sender: currentUser,
    time: '16:00',
    text: "I'm Andrew, I have a problem with my immune system 😢",
  ),
  Message(
    sender: currentUser,
    time: '16:00',
    avatar: drake.avatar,
    text: "Hi, good afternoon Dr.Drake... 😁",
  ),
];
