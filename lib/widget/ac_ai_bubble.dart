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
  void dispose() {
    tts.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
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
                    color: Colors.black,
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  widget.msgTime,
                  style: GoogleFonts.manrope(
                    fontSize: 14,
                    color: Colors.black,
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
                maxWidth: MediaQuery.of(context).size.width * 0.8,
              ),
              decoration: BoxDecoration(
                color: Colors.grey[200],
              ),
              child: Text(
                widget.msg,
                style: GoogleFonts.manrope(fontSize: 14, color: Colors.black),
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
      ],
    );
  }
}
