import 'package:flutter/material.dart';

void main() => runApp(ChatApp());

class ChatApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ChatScreen(),
    );
  }
}

class ChatScreen extends StatelessWidget {
  final List<Message> messages = [
    Message('Taha Ali', 'There?','20 Aug 1:14 pm', true),
    Message('Waleed Arshad', 'Yes', '20 Aug 1:14 pm', false),
    Message('Taha Ali', 'Join this', '20 Aug 1:14 pm', true),
    Message('System', '[VideoMeetingCard]','', true, isSystem: true),
    Message('Taha Ali', 'Awaaz nahe aa rhi', '20 Aug 1:33 pm', true),
    Message('Waleed Arshad', "Can't hear you", '20 Aug 1:34 pm', false),
    Message('Taha Ali', 'Rejoin karu meeting leave kr k', '20 Aug 1:34 pm', true),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: ChatHeader(),
      ),
      body: Column(
        children: [
          HistoryNotice(),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final msg = messages[index];
                if (msg.text == '[VideoMeetingCard]') {
                  return MeetingCard();
                }
                return MessageBubble(message: msg);
              },
            ),
          ),
          ChatInput(),
        ],
      ),
    );
  }
}

class ChatHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 1,
      title: Row(
        children: [
          BackButton(color: Colors.black),
          CircleAvatar(radius: 16, backgroundColor: Colors.grey.shade300),
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Waleed Arshad', style: TextStyle(color: Colors.black)),
              
              Row(children: [Icon(Icons.circle, color: Colors.green, size:10),SizedBox(width:7),Text('Active', style: TextStyle(color: Colors.black, fontSize: 12)),],)
            ],
          )
        ],
      ),
      actions: [
        Icon(Icons.search, color: Colors.black),
        SizedBox(width: 12),
      ],
    );
  }
}

class HistoryNotice extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        children: [
          Icon(Icons.history, color: Colors.grey),
          SizedBox(height: 4),
          Text(
            'HISTORY IS TURNED ON',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 4),
          Text(
            'Messages sent with the history on are saved',
            style: TextStyle(fontSize: 12, color: Colors.grey[600]),
          ),
          Divider(height: 20, thickness: 1),
        ],
      ),
    );
  }
}

class MessageBubble extends StatelessWidget {
  final Message message;

  const MessageBubble({required this.message});

  @override
  Widget build(BuildContext context) {
    final isSender = message.isSender;
    final alignment =
        isSender ? CrossAxisAlignment.start : CrossAxisAlignment.end;
    final color = isSender ? Colors.white : Colors.lightBlue.shade100;
    final borderRadius = BorderRadius.circular(8);

    return Column(
      crossAxisAlignment: alignment,
      children: [
        Row(
          children: [
            Text(
              message.sender,
              style: TextStyle(fontSize: 14, color: Color.fromARGB(255, 114, 114, 114)),
            ),
            SizedBox(width: 8),
            Text(
              message.time,
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 4),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: color,
            borderRadius: borderRadius,
          ),
          child: Text(message.text),
        ),
      ],
    );
  }
}

class MeetingCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8),
        padding: EdgeInsets.all(12),
        width: 320,
        decoration: BoxDecoration(
          color: Colors.teal[700],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Video meeting',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            Text(
              'Google Meet',
              style: TextStyle(color: Colors.white70),
            ),
            SizedBox(height: 10),
            Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
              child: Row(
                children: [
                  Icon(Icons.video_call, color: Colors.teal),
                  SizedBox(width: 8),
                  Text(
                    'Join video meeting',
                    style: TextStyle(color: Colors.teal),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ChatInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.all(8),
        child: Row(
          children: [
            Icon(Icons.photo, color: Colors.grey),
            SizedBox(width: 8),
            Icon(Icons.camera_alt, color: Colors.grey),
            SizedBox(width: 8),
            Icon(Icons.add_to_drive, color: Colors.grey),
            SizedBox(width: 8),
            Icon(Icons.videocam, color: Colors.grey),
            SizedBox(width: 8),
            Icon(Icons.event, color: Colors.grey),
            SizedBox(width: 8),
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'History is on',
                  border: InputBorder.none,
                ),
              ),
            ),
            Icon(Icons.send, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}

class Message {
  final String sender;
  final String text;
  final String time; 
  final bool isSender;
  final bool isSystem;

  Message(this.sender, this.text, this.time, this.isSender, {this.isSystem = false});
}