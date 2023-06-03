import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ErrorBubble extends StatefulWidget {
  final String module;
  final String msg;
  final String msgTime;

  const ErrorBubble(
      {super.key,
      required this.module,
      required this.msg,
      required this.msgTime});

  @override
  State<ErrorBubble> createState() => _ErrorBubbleState();
}

class _ErrorBubbleState extends State<ErrorBubble> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.module,
                style: GoogleFonts.manrope(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black45),
              ),
              const SizedBox(
                width: 8,
              ),
              Text(
                widget.msgTime,
                style: GoogleFonts.manrope(fontSize: 14, color: Colors.black45),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.all(12),
            // width: MediaQuery.of(context).size.width * 0.5,
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.75,
            ),
            decoration: const BoxDecoration(
              color: Colors.redAccent,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16)),
            ),

            child: SelectableText(
              widget.msg,
              style: GoogleFonts.manrope(fontSize: 14, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
