class AudioTextModel {
  final String text;
  final String role;

  AudioTextModel({required this.text, required this.role});

  factory AudioTextModel.fromJson(Map<String, dynamic> json) {
    return AudioTextModel(
      text: json['text'],
      role: "assistant",
    );
  }
}
