import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UserBubble extends StatefulWidget {
  final String module;
  final String moduleImage;
  final PlatformFile audioFile;
  final String msgTime;

  const UserBubble(
      {super.key,
      required this.module,
      required this.moduleImage,
      required this.audioFile,
      required this.msgTime});

  @override
  State<UserBubble> createState() => _UserBubbleState();
}

class _UserBubbleState extends State<UserBubble> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Expanded(
            child: SizedBox(),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                    style: GoogleFonts.manrope(
                        fontSize: 14, color: Colors.black45),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.all(12),
                // width: MediaQuery.of(context).size.width * 0.5,
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.50,
                ),
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(140, 82, 96, 1),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(16),
                      bottomRight: Radius.circular(16),
                      topLeft: Radius.circular(16)),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset(
                          "images/music_icon.png",
                          fit: BoxFit.cover,
                          width: 40,
                          height: 40,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              widget.audioFile.extension.toString(),
                              style: GoogleFonts.manrope(
                                fontSize: 15,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              '${(widget.audioFile.size / 1048576).toStringAsFixed(2)}mb',
                              style: GoogleFonts.manrope(
                                fontSize: 14,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    SelectableText(
                      widget.audioFile.name,
                      style: GoogleFonts.manrope(
                          fontSize: 14, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}