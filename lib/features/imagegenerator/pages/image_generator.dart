import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:xambot/core/widgets/user_bubble.dart';
import 'package:xambot/data/api/send_request.dart';
import 'package:xambot/features/imagegenerator/widgets/image_bubble.dart';

class ImageGenerator extends StatefulWidget {
  final String name;
  final String image;
  const ImageGenerator({super.key, required this.name, required this.image});

  @override
  State<ImageGenerator> createState() => _ImageGeneratorState();
}

class _ImageGeneratorState extends State<ImageGenerator> {
  final _messages = [];

  final TextEditingController _imageDescController = TextEditingController();

  bool isLoading = false;

  void _getImages(String msg) async {
    setState(() {
      _messages.add({
        "content": msg,
        "url1": null,
        "url2": null,
        "role": "user",
        "time": DateFormat('h:mm a').format(DateTime.now())
      });
      isLoading = true;
    });
    _imageDescController.clear();
    scrollToBottom();

    try {
      final chat = await APiCalls.getImages(msg);

      if (chat != null) {
        setState(() {
          isLoading = false;
          _messages.add({
            "content": null,
            "url1": chat.url1,
            "url2": chat.url2,
            "role": chat.role,
            "time": DateFormat('h:mm a')
                .format(DateTime.fromMillisecondsSinceEpoch(
                    int.parse(chat.time) * 1000))
                .toString()
          });
        });

        scrollToBottom();
      } else {
        debugPrint("Error");
      }
    } on Exception catch (e) {
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
                            "generating images...",
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
                    ? Column(
                        children: [
                          ImageBubble(
                            url1: _messages[index]["url1"].toString(),
                            msgTime: _messages[index]["time"].toString(),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          ImageBubble(
                            url1: _messages[index]["url2"].toString(),
                            msgTime: _messages[index]["time"].toString(),
                          ),
                        ],
                      )
                    : UserBubble(
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
                          child: TextField(
                            style: GoogleFonts.poppins(color: Colors.white),
                            decoration: InputDecoration.collapsed(
                              hintText: "Type image description...",
                              hintStyle:
                                  GoogleFonts.poppins(color: Colors.white),
                              fillColor: Colors.white,
                            ),
                            controller: _imageDescController,
                          ),
                        ),
                        TextButton(
                            onPressed: () {
                              if (_imageDescController.text.isNotEmpty) {
                                _getImages(_imageDescController.text);
                              }
                            },
                            child: Text(
                              "Send",
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ))
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
