import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ACUserBubble extends StatefulWidget {
  final String module;
  final String moduleImage;
  final String msg;
  final String msgTime;

  const ACUserBubble(
      {super.key,
      required this.module,
      required this.moduleImage,
      required this.msg,
      required this.msgTime});

  @override
  State<ACUserBubble> createState() => _ACUserBubbleState();
}

class _ACUserBubbleState extends State<ACUserBubble> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.5,
      margin:  EdgeInsets.only(
        bottom: MediaQuery.of(context).size.height * 0.02,
        top: MediaQuery.of(context).size.height * 0.02,
      ),

      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    widget.module,
                    style: GoogleFonts.manrope(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    widget.msgTime,
                    style: GoogleFonts.manrope(
                        fontSize: 14, color: Colors.black),
                  ),
                ],
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.96,
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(140, 82, 96, 1),
                ),

                padding: const EdgeInsets.all(12),
                child: SelectableText(
                  widget.msg,
                  style: GoogleFonts.manrope(fontSize: 14, color: Colors.white),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
