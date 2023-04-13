import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:xambot/model/chat_model.dart';

class APiCalls {
  static final headers = {
    'Content-Type': 'application/json',
    'Authorization':
        'Bearer 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',
  };

  static String baseURL = "https://api.openai.com/v1";

  static Future<dynamic> getChat(msg) async {
    final url = Uri.parse('$baseURL/chat/completions');
    final data = {
      "model": "gpt-3.5-turbo-0301",
      "messages": [
        {"role": "user", "content": msg}
      ]
    };
    final res = await http.post(url, headers: headers, body: json.encode(data));
    final parsedJson = jsonDecode(res.body);

    final role = parsedJson['choices'][0]['message']['role'] as String;
    final content = parsedJson['choices'][0]['message']['content'] as String;
    final time = parsedJson['created'].toString();

    // debugPrint(time);
    return ChatModel(msg: content, role: role, time: time);
  }
}
