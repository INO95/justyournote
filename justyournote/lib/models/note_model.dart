// 메모 데이터 모델 클래스
// Note data model class
class Note {
  String title;
  String content;
  DateTime createdTime;

  Note({
    required this.title,
    required this.content,
    required this.createdTime,
  });

  // JSON 변환 메서드 (향후 확장용)
  // JSON conversion methods (for future expansion)
  Map<String, dynamic> toJson() => {
        'title': title,
        'content': content,
        'createdTime': createdTime.toIso8601String(),
      };

  factory Note.fromJson(Map<String, dynamic> json) => Note(
        title: json['title'],
        content: json['content'],
        createdTime: DateTime.parse(json['createdTime']),
      );
}
