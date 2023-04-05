import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xambot/widget/user_bubble.dart';

class Chat extends StatefulWidget {
  final String name;
  const Chat({super.key, required this.name});

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Text(widget.name),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.speaker_notes_outlined),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Flexible(
              child: ListView.builder(
                itemCount: 48,
                itemBuilder: (context, index) {
                  return UserBubble();
                },
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
                        // allow unlimited lines
                        // keyboardType: TextInputType.multiline,
                        decoration: InputDecoration.collapsed(
                          hintText: "Send a message...",
                          fillColor: Colors.grey[300],
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
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
