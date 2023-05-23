import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:xambot/model/audio_text_model.dart';
import 'package:xambot/model/chat_model.dart';
import 'package:xambot/model/text_model.dart';
import 'package:xambot/model/image_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class APiCalls {
  static final headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer ${dotenv.env['OPENAI_KEY']}',
  };
  static String baseURL = "https://api.openai.com/v1";

  static Future<dynamic> getChat(msg) async {
    try {
      final url = Uri.parse('$baseURL/chat/completions');
      final data = {
        "model": "gpt-3.5-turbo-0301",
        "messages": [
          {"role": "user", "content": msg}
        ]
      };
      final res =
          await http.post(url, headers: headers, body: json.encode(data));

      debugPrint(res.statusCode.toString());

      if (res.statusCode == 200) {
        final parsedJson = jsonDecode(res.body);

        debugPrint(parsedJson.toString());

        final role = parsedJson['choices'][0]['message']['role'] as String;
        final content =
            parsedJson['choices'][0]['message']['content'] as String;
        final time = parsedJson['created'].toString();

        // debugPrint(time);
        return ChatModel(msg: content, role: role, time: time);
      } else {
        return res;
      }
    } on Exception catch (e) {
      return e;
    }
  }

  static Future<dynamic> getImages(desc) async {
    try {
      final url = Uri.parse('$baseURL/images/generations');
      final data = {"prompt": desc, "n": 2, "size": "1024x1024"};
      final res =
          await http.post(url, headers: headers, body: json.encode(data));

      if (res.statusCode == 200) {
        final parsedJson = jsonDecode(res.body);

        final images1 = parsedJson['data'][0]['url'] as String;
        final images2 = parsedJson['data'][1]['url'] as String;
        final time = parsedJson['created'].toString();

        // debugPrint(time);
        return ImageModel(
            url1: images1, url2: images2, role: "assistant", time: time);
      } else {
        return res;
      }
    } on Exception catch (e) {
      return e;
    }
  }

  static Future<dynamic> getTextFromAudio(audio) async {
    try {
      final url = Uri.parse('$baseURL/audio/translations');
      final data = {"file": audio, "model": "whisper-1"};
      final res =
          await http.post(url, headers: headers, body: json.encode(data));
      if (res.statusCode == 200) {
        final parsedJson = jsonDecode(res.body);
        print(parsedJson);
        return AudioTextModel.fromJson(parsedJson);
      }
    } catch (e) {
      debugPrint(e.toString());
      return e;
    }
  }

  static Future<dynamic> getText(text) async {
    try {
      final url = Uri.parse('$baseURL/completions');
      final data = {
        "model": "text-davinci-003",
        "prompt": text,
        "max_tokens": 1048,
        "temperature": 0,
      };
      final res =
          await http.post(url, headers: headers, body: json.encode(data));
      if (res.statusCode == 200) {
        final parsedJson = jsonDecode(res.body);
        return TextModel.fromJson(parsedJson);
      } else {
        return res;
      }
    } catch (e) {
      debugPrint(e.toString());
      return e;
    }
  }
}
