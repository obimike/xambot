class AudioTextModel {
  final String txt;
  final String role;
  final int time;

  AudioTextModel({required this.txt, required this.role, required this.time});

  factory AudioTextModel.fromJson(Map<String, dynamic> json) {
    return AudioTextModel(
      txt: json['message'].content,
      role: "assistant",
      time: json['created'],
    );
  }
}
