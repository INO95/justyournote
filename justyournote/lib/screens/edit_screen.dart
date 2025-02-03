// 메모 편집 화면
import 'package:flutter/material.dart';

class EditScreen extends StatefulWidget {
  final String initialContent;

  const EditScreen({super.key, required this.initialContent});

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  late TextEditingController _controller;

  // initState는 위젯이 초기화될 때 호출되는 메서드이다.
  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialContent);
  }

  // dispose는 위젯이 사라질 때 호출되는 메서드이다.
  @override
  void dispose() {
    // 텍스트 입력 컨트롤러를 해제한다.
    _controller.dispose();
    // 부모 클래스의 dispose 메서드를 호출한다.
    super.dispose();
  }

  // 메모 저장 로직
  void _saveNote() {
    // 텍스트 입력 컨트롤러의 텍스트를 가져와서 메모를 저장한다.
    // 현재 화면의 context(현재 화면의 key)를 파라미터로 사용하여 스택에서 현재 화면을 제거하고 이전 화면으로 돌아간다.
    Navigator.pop(context, _controller.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('메모 편집'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _saveNote,
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
