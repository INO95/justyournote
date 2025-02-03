// 메인 애플리케이션 설정
import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const FlutterNoteApp());
}

// 루트 위젯
// StatelessWidget이란 상태를 가지지 않는 위젯을 말한다.
// 주로 화면 구성에 필요한 위젯을 만들 때 사용한다.
class FlutterNoteApp extends StatelessWidget {
  // 생성자
  // 생성자는 클래스의 속성을 초기화하는 역할을 한다.
  // super.key는 위젯의 고유 식별자를 전달하는 매개변수이다.
  const FlutterNoteApp({super.key});

  // 이 위젯은 루트 위젯이며, 애플리케이션의 모든 위젯을 포함하는 위젯이다.
  @override
  //  context또한 위젯의 고유 식별자를 전달하는 매개변수이다.
  Widget build(BuildContext context) {
    // MaterialApp의 특징은 앱의 모양과 느낌을 정의하는 것이다.
    // 앱으로서 기능을 할 수 있도록 해주는 뼈대
    return MaterialApp(
      title: 'Old Notebook',
      // 테마 설정은 app_theme.dart에서 정의되어 있다.
      theme: AppTheme.vintageTheme,
      // home은 앱의 첫 화면을 정의하는 매개변수이다.
      // 첫 화면은 home_screen.dart에서 정의되어 있다.
      home: const HomeScreen(title: 'My Vintage Notes'),
      // debugShowCheckedModeBanner은 디버그 모드일 때 버튼을 표시하는 매개변수이다.
      debugShowCheckedModeBanner: false,
    );
  }
}

// 메모 작성 화면
class EditScreen extends StatelessWidget {
  // 초기 메모 내용을 전달하는 매개변수
  final String initialContent;
  // 텍스트 입력 컨트롤러
  // 텍스트 입력을 처리하는 역할을 한다.
  final TextEditingController _controller = TextEditingController();

  EditScreen({super.key, required this.initialContent}) {
    // 초기 메모 내용을 컨트롤러에 저장한다.
    _controller.text = initialContent;
  }

  @override
  Widget build(BuildContext context) {
    // Scaffold : 디자인 적인 부분에서의 뼈대
    // 기본적인 material design(구글에서 제공하는 디자인 컨셉셉) 테마를 적용하는 위젯이다.
    return Scaffold(
      // appBar는 앱의 상단 바를 정의하는 매개변수이다.
      appBar: AppBar(
        // actions는 앱의 상단 바의 오른쪽에 위치하는 아이콘을 정의하는 매개변수이다.
        actions: [
          // 저장 버튼
          IconButton(
            // const를 선언할 때의 좋은 점은 메모리가 절약된다는 것이다.
            icon: const Icon(Icons.save),
            onPressed: () {
              // 저장 버튼을 눌렀을 때, 현재 입력된 메모 내용을 저장하고 이전 화면으로 돌아간다.
              // Navigator는 화면 이동을 처리하는 역할을 한다.
              // 자식 위젯들은 스택 방식으로 관리하는 위젯.
              // 앱의 논리적 히스토리를 표시하고 페이지 간 전환을 관리.
              Navigator.pop(context, _controller.text);
            },
          ),
        ],
      ),
      body: Padding(
        // EdgeInsets는 위젯의 여백을 정의하는 매개변수이다.
        padding: const EdgeInsets.all(16.0),
        child: TextField(
          // controller는 텍스트 입력을 처리하는 역할을 한다.
          controller: _controller,
          // autofocus는 텍스트 입력 컨트롤러가 초기화될 때 자동으로 포커스를 설정하는 매개변수이다.
          autofocus: true,
          // maxLines가 null이면 무제한으로 입력할 수 있다.
          maxLines: null,
          // expands는 텍스트 박스의 높이 관련 설정이다. true를 사용할 시에는 maxLines가 null이어야 한다.
          expands: true,
          decoration: const InputDecoration(
            hintText: '메모 내용을 입력하세요...',
            border: InputBorder.none,
          ),
          style: const TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
