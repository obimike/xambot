import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

final headers = {
  'Content-Type': 'application/json',
  'Authorization':
      'Bearer  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',
  'OpenAI-Organization': 'org-xNkweoehPC1nNBrn7NGVLOUt'
};

void sendRequest(List<String> arguments) async {
  var url = Uri.https(
    'https://api.openai.com/v1/models ',
  );

  // Await the http get response, then decode the json-formatted response.
  var response = await http.get(url, headers: headers);
  if (response.statusCode == 200) {
    var jsonResponse =
        convert.jsonDecode(response.body) as Map<String, dynamic>;
    var itemCount = jsonResponse['totalItems'];
    print('$itemCount');
  } else {
    print('Request failed with status: ${response.statusCode}.');
  }
}
