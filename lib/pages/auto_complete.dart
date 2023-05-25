import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:flutter_load_kit/flutter_load_kit.dart';
import '../api/send_request.dart';

import 'package:xambot/widget/ac_user_bubble.dart';
import 'package:xambot/widget/ac_ai_bubble.dart';

class AutoCompletion extends StatefulWidget {
  final String name;
  final String image;
  const AutoCompletion({super.key, required this.name, required this.image});

  @override
  State<AutoCompletion> createState() => _AutoCompletionState();
}

class _AutoCompletionState extends State<AutoCompletion> {
  final _messages = [];

  final TextEditingController _controller = TextEditingController();

  bool isLoading = false;

  void _sendMessage(String msg) async {
    setState(() {
      _messages.add({
        "content": msg,
        "role": "user",
        "time": DateFormat('h:mm a').format(DateTime.now())
      });
      isLoading = true;
    });
    _controller.clear();
    scrollToBottom();

    try {
      final text = await APiCalls.getText(msg);




      if (text != null) {
        setState(() {
          isLoading = false;
          _messages.add({
            "content":(text.txt).replaceAll(RegExp(r"\n\n"), ""),
            "role": text.role,
            "time": DateFormat('h:mm a')
                .format(DateTime.fromMillisecondsSinceEpoch(
                   text.time * 1000))
                .toString()
          });
        });

        scrollToBottom();
      } else {
        debugPrint("Error");
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
    super.dispose();
    scrollController.dispose();
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
                    SizedBox(
                      width: dynamicWidth * 0.5,
                      child: Text(widget.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.poppins(
                              fontSize: dynamicHeight * 0.035,                            
                              color: Colors.white)),
                    ),
                    Visibility(
                      visible: isLoading,
                      child: AnimatedTextKit(
                        animatedTexts: [
                          TypewriterAnimatedText(
                            "searching...",
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
              padding: EdgeInsets.only(
                top: dynamicHeight * 0.02,
                left: dynamicWidth * 0.02,
                bottom: dynamicHeight * 0.015,
                right: dynamicWidth * 0.02,
              ) ,

              reverse: false,
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return (_messages[index]["role"] == "assistant"
                    ? AIBubble(
                        module: widget.name,
                        moduleImage: widget.image,
                        msg: _messages[index]["content"].toString(),
                        msgTime: _messages[index]["time"].toString())
                    : ACUserBubble(
                        module: "You",
                        moduleImage: "images/ai.png",
                        msg: _messages[index]["content"].toString(),
                        msgTime: DateFormat('h:mm a')
                            .format(DateTime.now())
                            .toString(),
                      ));
              },
            ),
          ),
          SizedBox(
            height: isLoading ? 20 : 0,
            width: 100,
            child: const LoadKitLineChase(
              itemCount: 3,
            ),
          ),
          Container(
            color: Colors.transparent,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    // height: dynamicHeight * 0.06,
                    // margin: EdgeInsets.all(dynamicWidth * 0.04),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 0),
                    decoration: const BoxDecoration(
                      color: Color.fromRGBO(140, 82, 96, 1),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            style: GoogleFonts.poppins(color: Colors.white),
                            decoration: InputDecoration.collapsed(
                              hintText: "Send a message...",
                              hintStyle:
                                  GoogleFonts.poppins(color: Colors.white),
                              fillColor: Colors.white,
                            ),
                            controller: _controller,
                          ),
                        ),
                        IconButton(
                          onPressed: () => {},
                          icon: Icon(
                            Icons.mic_sharp,
                            color: Colors.blueGrey[900],
                          ),
                        ),
                        TextButton(
                          // style: const ButtonStyle(
                          //     backgroundColor: MaterialStatePropertyAll(
                          //   Color.fromRGBO(140, 82, 96, 1),
                          // )),
                          onPressed: () {
                            if (_controller.text.isNotEmpty) {
                              _sendMessage(_controller.text);
                            }
                          },
                          child: Text(
                            "Send",
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
