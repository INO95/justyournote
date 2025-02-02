// 메인 애플리케이션 설정
// Application main configuration
// 古いノートブックを連想させるビンテージテーマを適用します。
import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const FlutterNoteApp());
}

// アプリケーションのルート
// statelesswidgetは状態を持たない
class FlutterNoteApp extends StatelessWidget {
  const FlutterNoteApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Old Notebook',
      theme: AppTheme.vintageTheme, // 테마 설정 분리
      home: const HomeScreen(title: 'My Vintage Notes'),
      debugShowCheckedModeBanner: false, // Remove debug banner
    );
  }
}

class EditScreen extends StatelessWidget {
  final String initialContent;
  final TextEditingController _controller = TextEditingController();

  EditScreen({super.key, required this.initialContent}) {
    _controller.text = initialContent;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () {
              Navigator.pop(context, _controller.text);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: TextField(
          controller: _controller,
          autofocus: true,
          maxLines: null,
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
