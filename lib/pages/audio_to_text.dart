import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:flutter_load_kit/flutter_load_kit.dart';
import 'package:xambot/widget/ai_bubble.dart';
import 'package:xambot/widget/at_user_bubble.dart';
import '../api/send_request.dart';
import 'package:file_picker/file_picker.dart';

class Audio2Text extends StatefulWidget {
  final String name;
  final String image;
  const Audio2Text({super.key, required this.name, required this.image});

  @override
  State<Audio2Text> createState() => _Audio2TextState();
}

class _Audio2TextState extends State<Audio2Text> {
  final _messages = [];
  String audioName = "Select an audio file...";
  bool isAudioSelected = false;
  late PlatformFile audioFile;

  bool isLoading = false;

  void _sendMessage(PlatformFile audio) async {
    setState(() {
      _messages.add({
        "content": audio,
        "role": "user",
        "time": DateFormat('h:mm a').format(DateTime.now())
      });
      isLoading = true;
    });
    isAudioSelected = false;
    audioName = "Select an audio file...";
    scrollToBottom();

    try {
      final response = await APiCalls.getTextFromAudio(audio);

      if (response != null) {
        // print(response);

        setState(() {
          isLoading = false;
          _messages.add({
            "content": response.text,
            "role": response.role,
            "time": DateFormat('h:mm a').format(DateTime.now())
          });
        });

        scrollToBottom();
      } else {
        debugPrint("Return error!");
        debugPrint(response.toString());
        setState(() {
          isLoading = false;
        });
      }
    } on Exception catch (e) {
      //
      debugPrint(e.toString());
      setState(() {
        isLoading = false;
      });
    }
  }

  var scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    setState(() {
      isLoading = false;
    });
    // scrollToBottom();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  void scrollToBottom() {
    final bottomOffset = scrollController.position.maxScrollExtent +
        MediaQuery.of(context).size.height;
    scrollController.animateTo(
      bottomOffset,
      duration: const Duration(milliseconds: 1000),
      curve: Curves.easeInOut,
    );
  }

  void pickAudio() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['mp3', 'wav'],
    );

    if (result != null) {
      audioFile = result.files.first;

      audioName = audioFile.name;
      isAudioSelected = true;

      setState(() {});
    } else {
      // User canceled the picker
      debugPrint("User canceled the picker");
    }
  }

  @override
  Widget build(BuildContext context) {
    var dynamicHeight = MediaQuery.of(context).size.height;
    var dynamicWidth = MediaQuery.of(context).size.width;

    return Scaffold(

      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(
              top: dynamicHeight * 0.05,
              left: dynamicWidth * 0.02,
              bottom: dynamicHeight * 0.015,
              right: dynamicWidth * 0.02,
            ),
            decoration: const BoxDecoration(
              color: Color.fromRGBO(140, 82, 96, 1),
            ),
            child: Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.white,
                  ),
                  iconSize: 24,
                ),
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    image: DecorationImage(
                      image: AssetImage(widget.image),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(
                  width: dynamicWidth * 0.04,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.name,
                        style: GoogleFonts.poppins(
                            fontSize: dynamicHeight * 0.035,
                            color: Colors.white)),
                    Visibility(
                      visible: isLoading,
                      child: AnimatedTextKit(
                        animatedTexts: [
                          TypewriterAnimatedText(
                            "upload audio...",
                            textStyle: const TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              fontFamily: "manrope",
                            ),
                            speed: const Duration(milliseconds: 100),
                          ),
                        ],
                        totalRepeatCount: 999,
                        displayFullTextOnTap: false,
                        stopPauseOnTap: false,
                      ),
                    ),
                  ],
                ),
                const Expanded(child: SizedBox()),
                IconButton(
                  onPressed: () {
                  //  TODO: clear history
                  },
                  icon: const Icon(
                    Icons.clear_all_sharp,
                    color: Colors.white,
                  ),
                  iconSize: 24,
                ),
              ],
            ),
          ),
          Flexible(
            child: ListView.builder(
              controller: scrollController,
              reverse: false,
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return (_messages[index]["role"] == "assistant"
                    ? AIBubble(
                        module: "Audio into text",
                        moduleImage: "images/ai.png",
                        msg: _messages[index]["content"],
                        msgTime: DateFormat('h:mm a')
                            .format(DateTime.now())
                            .toString())
                    : UserBubble(
                        module: "You",
                        moduleImage: "images/ai.png",
                        audioFile: _messages[index]["content"],
                        msgTime: DateFormat('h:mm a')
                            .format(DateTime.now())
                            .toString(),
                      ));
              },
            ),
          ),

          Container(
            color: Colors.transparent,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    // height: dynamicHeight * 0.06,
                    margin: EdgeInsets.all(dynamicWidth * 0.04),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 0),
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(140, 82, 96, 1),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              pickAudio();
                            },
                            child: TextField(
                              enabled: false,
                              style: GoogleFonts.poppins(color: Colors.white),
                              decoration: InputDecoration.collapsed(
                                hintText: audioName,
                                hintStyle:
                                    GoogleFonts.poppins(color: Colors.white),
                                fillColor: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            if (isAudioSelected) {
                              _sendMessage(audioFile);
                            }
                          },
                          child: Text(
                            "Upload",
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
