// 메인 홈 화면 (메모 목록 표시)
// Main home screen (displays note list)
import 'package:flutter/material.dart';
import '../models/note_model.dart';
import 'edit_screen.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.title});
  final String title;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Note> notes = [];

  // 새로운 메모 추가 로직
  // Add new note logic
  void _addNewNote() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EditScreen(initialContent: '')),
    );

    if (result != null && result.isNotEmpty) {
      setState(() {
        notes.insert(
            0,
            Note(
              title: result.split('\n')[0],
              content: result,
              createdTime: DateTime.now(),
            ));
      });
    }
  }

  // Add this method
  void _handleDismiss(int index) {
    final removedNote = notes[index];
    setState(() {
      notes.removeAt(index);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('메모가 삭제되었습니다'),
        action: SnackBarAction(
          label: '실행 취소',
          onPressed: () {
            setState(() {
              notes.insert(index, removedNote);
            });
          },
        ),
      ),
    );
  }

  // Add this helper method
  String _formatDate(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }

  // Add this method
  void _editNote(Note note) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditScreen(initialContent: note.content),
      ),
    );

    if (result != null && result.isNotEmpty) {
      setState(() {
        note.content = result;
        note.title = result.split('\n')[0];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [/* 검색 기능 구현부 */],
      ),
      body: _buildNoteList(),
      floatingActionButton: _buildAddButton(),
    );
  }

  // 메모 목록 빌더
  // Note list builder
  Widget _buildNoteList() {
    return notes.isEmpty
        ? const Center(child: Text('메모를 추가해주세요 ✏️'))
        : ListView.builder(
            itemCount: notes.length,
            itemBuilder: (context, index) =>
                _buildNoteItem(notes[index], index),
          );
  }

  // 개별 메모 아이템 위젯
  // Individual note item widget
  Widget _buildNoteItem(Note note, int index) {
    return Dismissible(
      key: Key(note.createdTime.toString()),
      onDismissed: (direction) => _handleDismiss(index),
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 16.0),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      child: ListTile(
        title: Text(
          note.title,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          note.content,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: Text(
          _formatDate(note.createdTime),
          style: const TextStyle(fontSize: 12),
        ),
        onTap: () => _editNote(note),
      ),
    );
  }

  // 추가 버튼 위젯
  // Add button widget
  Widget _buildAddButton() {
    return FloatingActionButton(
      onPressed: _addNewNote,
      child: const Icon(Icons.add),
    );
  }

  // 기타 헬퍼 메서드들...
  // Other helper methods...
}
