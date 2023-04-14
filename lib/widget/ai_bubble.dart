import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class AIBubble extends StatefulWidget {
  final String module;
  final String moduleImage;
  final String msg;
  final String msgTime;

  const AIBubble(
      {super.key,
      required this.module,
      required this.moduleImage,
      required this.msg,
      required this.msgTime});

  @override
  State<AIBubble> createState() => _AIBubbleState();
}

class _AIBubbleState extends State<AIBubble> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 36,
            width: 36,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              image: DecorationImage(
                image: AssetImage(widget.moduleImage),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(
            width: 4,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.module,
                    style: GoogleFonts.manrope(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    widget.msgTime,
                    style:
                        GoogleFonts.manrope(fontSize: 14, color: Colors.white),
                  ),
                ],
              ),
              const SizedBox(
                height: 4,
              ),
              Container(
                padding: const EdgeInsets.all(12),
                // width: MediaQuery.of(context).size.width * 0.5,
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.75,
                ),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                ),
                child: AnimatedTextKit(
                  animatedTexts: [
                    TypewriterAnimatedText(
                      widget.msg,
                      textStyle: const TextStyle(
                        fontSize: 14,
                        fontFamily: "manrope",
                      ),
                      speed: const Duration(milliseconds: 100),
                    ),
                  ],
                  totalRepeatCount: 1,
                  displayFullTextOnTap: true,
                  stopPauseOnTap: true,
                ),
              ),
            ],
          ),
          const Expanded(
            child: SizedBox(),
          ),
        ],
      ),
    );
  }
}
