import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:flutter_file_dialog/flutter_file_dialog.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class ImageBubble extends StatefulWidget {
  final String url1;
  final String msgTime;

  const ImageBubble({super.key, required this.url1, required this.msgTime});

  @override
  State<ImageBubble> createState() => _ImageBubbleState();
}

class _ImageBubbleState extends State<ImageBubble> {
  Future<void> _saveImage(BuildContext context, String url) async {
    String? message;
    final scaffoldMessenger = ScaffoldMessenger.of(context);

    try {
      // Download image
      final http.Response response = await http.get(Uri.parse(url));

      // Get temporary directory
      final dir = await getTemporaryDirectory();

      // Create an image name
      var filename = '${dir.path}/image.png';

      // Save to filesystem
      final file = File(filename);
      await file.writeAsBytes(response.bodyBytes);

      // Ask the user to save it
      final params = SaveFileDialogParams(sourceFilePath: file.path);
      final finalPath = await FlutterFileDialog.saveFile(params: params);

      if (finalPath != null) {
        message = 'Image saved to disk';
      }
    } catch (e) {
      message = 'An error occurred while saving the image';
    }

    if (message != null) {
      scaffoldMessenger.showSnackBar(SnackBar(content: Text(message)));
    }
  }

  Future<void> _shareImage(BuildContext context, String url) async {}

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.msgTime,
                    style: GoogleFonts.manrope(
                      fontSize: 14,
                      color: Colors.black45,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 4,
              ),
              Container(
                padding: const EdgeInsets.all(16),
                // width: MediaQuery.of(context).size.width * 0.5,
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.75,
                ),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Image.network(
                  widget.url1,
                  fit: BoxFit.cover,
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    );
                  },
                  // When dealing with networks it completes with two states,
                  // complete with a value or completed with an error,
                  // So handling errors is very important otherwise it will crash the app screen.
                  // I showed dummy images from assets when there is an error, you can show some texts or anything you want.
                  // errorBuilder: (context, exception, stackTrace) {
                  //   return Image.asset(
                  //     AppAssets.dummyPostImg,
                  //     fit: BoxFit.cover,
                  //     height: (widget.hideBelowImage == null ||
                  //             widget.hideBelowImage == false)
                  //         ? 170.h
                  //         : 130.h,
                  //     width: double.infinity,
                  //   );
                  // },
                ),
              ),
            ],
          ),
          Column(
            children: [
              IconButton(
                onPressed: () => _saveImage(context, widget.url1),
                icon: const Icon(Icons.download_rounded),
                color: Colors.grey[500],
                iconSize: 24,
              ),
              const SizedBox(
                height: 36,
              ),
              IconButton(
                onPressed: () => _shareImage(context, widget.url1),
                icon: const Icon(Icons.shortcut_outlined),
                color: Colors.grey[500],
                iconSize: 24,
              ),
            ],
          ),
          const Expanded(
            child: SizedBox(),
          ),
        ],
      ),
    );
  }
}
