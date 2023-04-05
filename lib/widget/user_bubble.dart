import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UserBubble extends StatefulWidget {
  const UserBubble({super.key});

  @override
  State<UserBubble> createState() => _UserBubbleState();
}

class _UserBubbleState extends State<UserBubble> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
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
                    'You',
                    style: GoogleFonts.manrope(
                        fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    '10:11 AM',
                    style: GoogleFonts.manrope(fontSize: 14),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.all(12),
                // width: MediaQuery.of(context).size.width * 0.5,
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.75,
                ),
                decoration: BoxDecoration(
                  color: Colors.blueGrey[200],
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(16),
                      bottomRight: Radius.circular(16),
                      topLeft: Radius.circular(16)),
                ),
                child: Text(
                  'By setting CrossAxisAlignment.start, the children will be aligned to the start of the row, which is the top in a horizontal layout.',
                  style: GoogleFonts.manrope(fontSize: 14),
                ),
              ),
            ],
          ),
          const SizedBox(
            width: 4,
          ),
          Container(
            height: 36,
            width: 36,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              image: const DecorationImage(
                image: AssetImage("images/logo.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
