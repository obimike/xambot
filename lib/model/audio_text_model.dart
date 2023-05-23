class TextModel {
  final String txt;
  final String role;
  final int time;

  TextModel({required this.txt, required this.role, required this.time});

  factory TextModel.fromJson(Map<String, dynamic> json) {
    return TextModel(
      txt: json['choices'][0]['text'],
      role: "assistant",
      time: json['created'],
    );
  }
}
