import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xambot/features/chatpage/pages/chat_page.dart';

class ModelList extends StatefulWidget {
  final String label;
  final String image;
  const ModelList({super.key, required this.label, required this.image});

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
        leading: Container(
          height: 36,
          width: 36,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            image: DecorationImage(
              image: AssetImage(widget.image),
              fit: BoxFit.cover,
            ),
          ),
        ),
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
            MaterialPageRoute(
                builder: (context) => Chat(
                      name: widget.label,
                      image: widget.image,
                    )),
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
