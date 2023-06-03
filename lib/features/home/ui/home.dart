import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xambot/features/chatpage/pages/chat_page.dart';
import 'package:xambot/features/audiototext/pages/audio_to_text.dart';
import 'package:xambot/features/imagegenerator/pages/image_generator.dart';
import 'package:xambot/features/autocomplete/pages/auto_complete.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    var dynamicHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("images/home_bg.png"), fit: BoxFit.cover),
            ),
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: RichText(
                    textAlign: TextAlign.right,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Welcome Back,\n",
                          style: GoogleFonts.poppins(
                            fontSize: 32,
                            color: Colors.black,
                          ),
                        ),
                        TextSpan(
                            text: "What can I do for you?",
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              color: Colors.black54,
                            )),
                      ],
                    ),
                  ),
                ),
                const Expanded(child: SizedBox()),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        // Handle the tap gesture here

                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const Chat(
                                name: "AI Chat", image: "images/gpt4.png"),
                          ),
                        );
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.20,
                        width: MediaQuery.of(context).size.width * 0.40,
                        padding: EdgeInsets.all(
                            MediaQuery.of(context).size.width * 0.03),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(40),
                                color: const Color.fromRGBO(225, 225, 233, 1),
                              ),
                              child: const Icon(
                                Icons.chat,
                                color: Color.fromRGBO(140, 82, 96, 1),
                                size: 25,
                              ),
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            Text(
                              "AI Chat",
                              textAlign: TextAlign.left,
                              style: GoogleFonts.poppins(
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.045,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700),
                            )
                          ],
                        ),
                      ),
                    ),
                    const Expanded(child: SizedBox()),
                    GestureDetector(
                      onTap: () {
                        // Handle the tap gesture here

                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const ImageGenerator(
                                name: "Image Generator",
                                image: "images/gpt3.png"),
                          ),
                        );
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.20,
                        width: MediaQuery.of(context).size.width * 0.40,
                        padding: EdgeInsets.all(
                            MediaQuery.of(context).size.width * 0.03),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(40),
                                color: const Color.fromRGBO(225, 225, 233, 1),
                              ),
                              child: const Icon(
                                Icons.camera_alt,
                                color: Color.fromRGBO(140, 82, 96, 1),
                                size: 25,
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Text(
                              "Image Generator",
                              textAlign: TextAlign.left,
                              style: GoogleFonts.poppins(
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.045,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        // Handle the tap gesture here
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => const Audio2Text(
                                  name: "Audio into text",
                                  image: "images/ai.png")),
                        );
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.20,
                        width: MediaQuery.of(context).size.width * 0.40,
                        padding: EdgeInsets.all(
                            MediaQuery.of(context).size.width * 0.03),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(40),
                                color: const Color.fromRGBO(225, 225, 233, 1),
                              ),
                              child: const Icon(
                                Icons.audiotrack,
                                color: Color.fromRGBO(140, 82, 96, 1),
                                size: 25,
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Text(
                              "Audio into text",
                              textAlign: TextAlign.left,
                              style: GoogleFonts.poppins(
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.045,
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    const Expanded(child: SizedBox()),
                    GestureDetector(
                      onTap: () {
                        // Handle the tap gesture here

                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => const AutoCompletion(
                                  name: "Auto Completion",
                                  image: "images/code_davinci.png")),
                        );
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.20,
                        width: MediaQuery.of(context).size.width * 0.40,
                        padding: EdgeInsets.all(
                            MediaQuery.of(context).size.width * 0.03),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(40),
                                color: const Color.fromRGBO(225, 225, 233, 1),
                              ),
                              child: const Icon(
                                Icons.text_format_rounded,
                                color: Color.fromRGBO(140, 82, 96, 1),
                                size: 25,
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Text(
                              "Auto Completion",
                              textAlign: TextAlign.left,
                              style: GoogleFonts.poppins(
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.045,
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: dynamicHeight * 0.05,
                )
              ],
            ),
          )),
    );
  }
}
