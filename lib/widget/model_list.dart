import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xambot/pages/chat_page.dart';

class ModelList extends StatefulWidget {
  final String label;
  const ModelList({super.key, required this.label});

  @override
  State<ModelList> createState() => _ModelListState();
}

class _ModelListState extends State<ModelList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        // trailing: const Icon(Icons.arrow_forward_ios_sharp),
        // leading: const Icon(Icons.handyman_outlined),
        leading: Image.asset("images/ai.png", height: 48, width: 48),
        title: Text(
          widget.label,
          style: GoogleFonts.poppins(fontSize: 14),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 15),
        enableFeedback: true,
        iconColor: Colors.white,
        textColor: Colors.black87,
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => Chat(name: widget.label)),
          );
        },
        tileColor: Colors.blueGrey[300],
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
      ),
    );
  }
}
