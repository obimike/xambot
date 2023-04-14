import 'package:flutter/material.dart';
import 'package:xambot/widget/ai_bubble.dart';
import 'package:xambot/widget/user_bubble.dart';
import 'package:intl/intl.dart';
import 'package:flutter_load_kit/flutter_load_kit.dart';
import '../api/send_request.dart';
import 'package:text_to_speech/text_to_speech.dart';

class Chat extends StatefulWidget {
  final String name;
  final String image;
  const Chat({super.key, required this.name, required this.image});

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  TextToSpeech tts = TextToSpeech();
  final String defaultLanguage = 'en-US';

  double volume = 1; // Range: 0-1
  double rate = 0.8; // Range: 0-2
  double pitch = 1.2; // Range: 0-2

  void speak(text) {
    tts.setVolume(volume);
    tts.setRate(rate);
    tts.setLanguage(defaultLanguage);
    tts.setPitch(pitch);
    tts.speak(text);
  }

  final _messages = [];

  final TextEditingController _controller = TextEditingController();

  bool textToSpeaker = false;
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

      debugPrint(chat.toString());
      debugPrint("chat.toString()");

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
        if (textToSpeaker) {
          speak(chat.msg);
        }
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
// add this line to scroll to the top
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Text(widget.name),
        actions: [
          IconButton(
            onPressed: () {
              if (textToSpeaker) {
                setState(() {
                  textToSpeaker = false;
                });
              } else {
                setState(() {
                  textToSpeaker = true;
                });
              }
            },
            icon: textToSpeaker
                ? const Icon(Icons.speaker_notes)
                : const Icon(Icons.speaker_notes_off),
          ),
        ],
      ),
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/bg.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: [
              Flexible(
                child: ListView.builder(
                  controller: scrollController,
                  reverse: false,
                  itemCount: _messages.length,
                  itemBuilder: (context, index) {
                    return (_messages[index]["role"] == "assistant"
                        ? AIBubble(
                            module: widget.name,
                            moduleImage: widget.image,
                            msg: _messages[index]["content"].toString(),
                            msgTime: _messages[index]["time"].toString())
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
              SizedBox(
                height: isLoading ? 20 : 0,
                width: 100,
                child: const LoadKitLineChase(
                  itemCount: 3,
                ),
              ),
              Container(
                color: Colors.grey,
                padding: const EdgeInsets.only(left: 8),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: TextField(
                          decoration: InputDecoration.collapsed(
                            hintText: "Send a message...",
                            fillColor: Colors.grey[300],
                          ),
                          controller: _controller,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () => {
                        if (_controller.text.isNotEmpty)
                          {_sendMessage(_controller.text)}
                      },
                      icon: Icon(
                        Icons.send,
                        color: Colors.blueGrey[900],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
