import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:xambot/model/chat_model.dart';
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

      print(res.statusCode);

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
}
