// 메모 편집 화면
// Note editing screen
import 'package:flutter/material.dart';

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
            onPressed: () => Navigator.pop(context, _controller.text),
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
        ),
      ),
    );
  }
}
