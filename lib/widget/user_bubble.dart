import 'package:flutter/material.dart';

class UserBubble extends StatefulWidget {
  const UserBubble({super.key});

  @override
  State<UserBubble> createState() => _UserBubbleState();
}

class _UserBubbleState extends State<UserBubble> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.blueGrey[200],
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: const Text(
        'Enter text here',
      ),
    );
  }
}
