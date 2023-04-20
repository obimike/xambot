import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:text_to_speech/text_to_speech.dart';

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
  bool textToSpeaker = false;

  TextToSpeech tts = TextToSpeech();
  final String defaultLanguage = 'en-US';

  double volume = 1; // Range: 0-1
  double rate = 1; // Range: 0-2
  double pitch = 0.5; // Range: 0-2

  void speak(text) {
    tts.setVolume(volume);
    tts.setRate(rate);
    tts.setLanguage(defaultLanguage);
    tts.setPitch(pitch);
    tts.speak(text);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
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
                      color: Colors.black45,
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    widget.msgTime,
                    style: GoogleFonts.manrope(
                      fontSize: 14,
                      color: Colors.black45,
                    ),
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
                  isRepeatingAnimation: false,
                  animatedTexts: [
                    TypewriterAnimatedText(
                      widget.msg,
                      textStyle: GoogleFonts.manrope(
                          fontSize: 14, color: Colors.black),
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
          IconButton(
            onPressed: () {
              if (textToSpeaker) {
                setState(() {
                  textToSpeaker = false;
                });
                tts.stop();
              } else {
                setState(() {
                  textToSpeaker = true;
                });
                speak(widget.msg);
              }
            },
            icon: textToSpeaker
                ? const Icon(Icons.volume_up_rounded)
                : const Icon(Icons.volume_off_rounded),
            color: Colors.grey[500],
            iconSize: 24,
          ),
          const Expanded(
            child: SizedBox(),
          ),
        ],
      ),
    );
  }
}
