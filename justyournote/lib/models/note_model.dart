// 메모 데이터 모델 클래스
class Note {
  String title;
  String content;
  DateTime createdTime;

  Note({
    required this.title,
    required this.content,
    required this.createdTime,
  });

  // JSON 변환 메서드
  // dynamic은 모든 타입을 포함하는 타입이다. 자바의 Object와 같은 역할을 한다.
  // toJson이 실행되면 파라미터로 받은 객체를 JSON 형식으로 변환하여 반환한다.
  Map<String, dynamic> toJson() => {
        'title': title,
        'content': content,
        // createdTime을 ISO 8601 형식으로 변환하여 반환한다.
        // 예를 들어 2025-02-03T12:00:00Z와 같은 형식으로 날짜와 시간을 표현한다.
        'createdTime': createdTime.toIso8601String(),
      };

  // factory는 클래스 메서드를 정의하는 키워드이다.
  // 클래스 메서드는 클래스의 인스턴스를 생성하지 않고도 호출할 수 있다.
  factory Note.fromJson(Map<String, dynamic> json) => Note(
        title: json['title'],
        content: json['content'],
        createdTime: DateTime.parse(json['createdTime']),
      );
}
