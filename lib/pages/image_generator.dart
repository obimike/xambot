import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:xambot/api/send_request.dart';

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

  void _sendMessage(String msg) async {
    debugPrint("qwertyu");

    setState(() {
      _messages.add({
        "content": msg,
        "role": "user",
        "time": DateFormat('h:mm a').format(DateTime.now())
      });
      isLoading = true;
    });
    _imageDescController.clear();
    scrollToBottom();

    debugPrint(msg);

    try {
      final chat = await APiCalls.getImages(msg);

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
                return (const Text("Hi"));
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
                                _sendMessage(_imageDescController.text);
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
