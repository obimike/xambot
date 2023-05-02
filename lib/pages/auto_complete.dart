import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:flutter_load_kit/flutter_load_kit.dart';
import '../api/send_request.dart';

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
      final chat = await APiCalls.getChat(msg);

      if (chat != null) {
        setState(() {
          isLoading = false;
          _messages.add({
            "content": chat.msg,
            "role": chat.role,
            "time": DateFormat('h:mm a')
                .format(DateTime.fromMillisecondsSinceEpoch(
                    int.parse(chat.time) * 1000))
                .toString()
          });
        });

        scrollToBottom();
      } else {
        print("Error");
      }
    } on Exception catch (e) {
      // TODO
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
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                          text: "${widget.name} \n",
                          style: GoogleFonts.poppins(
                            fontSize: dynamicHeight * 0.035,
                          )),
                      const TextSpan(text: "thinking..."),
                      // AnimatedTextKit(
                      //   animatedTexts: [
                      //     TypewriterAnimatedText(
                      //      "...",
                      //       textStyle: const TextStyle(
                      //         fontSize: 14,
                      //         fontFamily: "manrope",
                      //       ),
                      //       speed: const Duration(milliseconds: 100),
                      //     ),
                      //   ],
                      //   totalRepeatCount: 1,
                      //   displayFullTextOnTap: true,
                      //   stopPauseOnTap: true,
                      // ),
                    ],
                  ),
                ),
                const Expanded(child: SizedBox()),
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
                    ? Text("Assistant")
                    : Text("User"));
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
