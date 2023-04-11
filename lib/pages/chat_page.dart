import 'package:flutter/material.dart';
import 'package:xambot/widget/ai_bubble.dart';
import 'package:xambot/widget/user_bubble.dart';
import 'package:intl/intl.dart';
import 'package:flutter_load_kit/flutter_load_kit.dart';
import '../api/send_request.dart';

class Chat extends StatefulWidget {
  final String name;
  final String image;
  const Chat({super.key, required this.name, required this.image});

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  final _messages = [
    {"text": "Hello, how can I help you?", "isUser": false},
    {"text": "I'm having trouble with my account", "isUser": true},
    {
      "text": "I'm sorry to hear that. What seems to be the problem?",
      "isUser": false
    },
    {"text": "I can't seem to log in", "isUser": true},
    {
      "text": "Let me check that for you. What is your username?",
      "isUser": false
    },
    {"text": "My username is johnsmith", "isUser": true},
    {
      "text": "Thank you. Please hold while I check your account",
      "isUser": false
    },
    {"text": "Sure", "isUser": true},
    {
      "text":
          "I've found the problem. Your account was locked due to too many failed login attempts. I have unlocked it for you. Please try logging in again",
      "isUser": false
    },
    {"text": "Thank you, that worked", "isUser": true},
    {
      "text": "You're welcome. Is there anything else I can help you with?",
      "isUser": false
    },
  ];

  final TextEditingController _controller = TextEditingController();

  void _sendMessage(String msg) {
    setState(() {
      _messages.add({"text": msg, "isUser": true});
    });
    scrollToBottom();
    _controller.clear();
  }

  var scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    // scrollToBottom();
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  void scrollToBottom() {
    final bottomOffset = scrollController.position.maxScrollExtent +
        MediaQuery.of(context).size.height;
    print(bottomOffset);
    scrollController.animateTo(
      bottomOffset,
      duration: const Duration(milliseconds: 1000),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
// add this line to scroll to the top
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Text(widget.name),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.speaker_notes_off),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Flexible(
              child: ListView.builder(
                controller: scrollController,
                reverse: false,
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  return (_messages[index]["isUser"] == false
                      ? AIBubble(
                          module: widget.name,
                          moduleImage: widget.image,
                          msg: _messages[index]["text"].toString(),
                          msgTime: "8:50 AM")
                      : UserBubble(
                          module: "You",
                          moduleImage: "images/ai.png",
                          msg: _messages[index]["text"].toString(),
                          msgTime: DateFormat('h:mm a')
                              .format(DateTime.now())
                              .toString(),
                        ));
                },
              ),
            ),
            const SizedBox(
              height: 20,
              width: 100,
              child: LoadKitLineChase(
                itemCount: 3,
              ),
            ),
            Container(
              color: Colors.grey,
              padding: const EdgeInsets.only(left: 8),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: TextField(
                        decoration: InputDecoration.collapsed(
                          hintText: "Send a message...",
                          fillColor: Colors.grey[300],
                        ),
                        controller: _controller,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () => {
                      if (_controller.text.isNotEmpty)
                        {_sendMessage(_controller.text)}
                    },
                    icon: Icon(
                      Icons.send,
                      color: Colors.blueGrey[900],
                    ),
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
