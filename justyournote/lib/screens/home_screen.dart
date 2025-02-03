// 메인 홈 화면 (메모 목록 표시)
import 'package:flutter/material.dart';
import '../models/note_model.dart';
import 'edit_screen.dart';
import 'package:intl/intl.dart';

// 메모 목록 화면
// StatefulWidget은 상태를 가지는 위젯이며 이 어플리케이션에서는 메모 목록을 Global하게 관리하는 역할을 한다.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.title});
  final String title;

  @override
  // createState는 상태를 생성하는 메서드이다.
  State<HomeScreen> createState() => _HomeScreenState();
}

// _HomeScreenState는 메모 목록 화면의 상태를 관리하는 클래스이다.
class _HomeScreenState extends State<HomeScreen> {
  // 메모 목록을 저장하는 리스트
  List<Note> notes = [];

  // 새로운 메모 추가 로직
  // 추가 버튼이 눌렸을 때 호출되는 메서드
  // async는 비동기 처리를 위한 키워드이다.
  // 메모 작성 화면으로 이동한다.
  void _addNewNote() async {
    // result는 텍스트 입력 컨트롤러에서 입력한 메모 내용을 저장하는 변수이다.
    final result = await Navigator.push(
      context,
      // MaterialPageRoute는 페이지 이동을 처리하는 역할을 한다.
      MaterialPageRoute(
          // EditScreen으로 이동하는 라우트를 생성한다.
          builder: (context) => const EditScreen(initialContent: '')),
    );

    if (result != null && result.isNotEmpty) {
      setState(() {
        // 메모 목록에 추가한다.
        notes.insert(
          // 0번째 인덱스에 추가한다.
          0,
          Note(
            title: result.split('\n')[0],
            content: result,
            // 현재 시간을 기준으로 메모를 생성한다.
            createdTime: DateTime.now(),
          ),
        );
      });
    }
  }

  // 메모 삭제 로직
  void _handleDismiss(int index) {
    // removedNote는 삭제할 메모를 저장하는 변수이다.
    final removedNote = notes[index];
    setState(() {
      // 메모 목록에서 삭제한다.
      notes.removeAt(index);
    });

    // 삭제된 메모를 알리는 스낵바를 표시한다.
    // 스낵바란 화면 하단에 작은 메시지를 표시하는 위젯이다.
    // ScaffoldMessenger.of(context)는 현재 컨텍스트를 가져오는 역할을 한다.
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('메모가 삭제되었습니다'),
        action: SnackBarAction(
          // 이 버튼을 누르면 삭제된 메모를 다시 복구할 수 있다.
          label: 'Undo',
          onPressed: () {
            setState(() {
              // 임시로 저장한 removedNote를 다시 메모 목록에 추가한다.
              notes.insert(index, removedNote);
            });
          },
        ),
      ),
    );
  }

  // 메모 편집 로직
  // 비동기 처리
  void _editNote(Note note) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        // EditScreen으로 이동하는 라우트를 생성한다.
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

  // 날짜 형식 변환 메서드
  String _formatDate(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // 메모 목록 화면의 제목을 표시한다.
        title: Text(widget.title),
        actions: [
          // 검색 기능 구현부 (추후 추가 가능)
        ],
      ),
      // 메모 목록을 표시하는 위젯
      body: _buildNoteList(),
      // 추가 버튼을 표시하는 위젯
      floatingActionButton: _buildAddButton(),
    );
  }

  // 메모 목록 빌더
  Widget _buildNoteList() {
    return notes.isEmpty
        // 만약 메모가 없다면 아래의 텍스트를 표시한다.
        ? const Center(child: Text('메모를 추가해주세요 ✏️'))
        : ListView.builder(
            // 메모 목록의 개수를 표시한다.
            itemCount: notes.length,
            // 메모 목록의 각 아이템을 표시한다.
            itemBuilder: (context, index) =>
                _buildNoteItem(notes[index], index),
          );
  }

  // 개별 메모 아이템 위젯
  Widget _buildNoteItem(Note note, int index) {
    // Dismissible은 위젯을 스와이프하여 삭제할 수 있도록 해주는 위젯이다.
    // 스와이프 방향은 왼쪽 또는 오른쪽으로 설정할 수 있다.
    return Dismissible(
      // 여기서는 메모의 생성 시간을 고유 식별자로 사용한다.
      key: Key(note.createdTime.toString()),
      // 스와이프하면 메모를 삭제하는 메서드를 호출한다.
      onDismissed: (direction) => _handleDismiss(index),
      background: Container(color: Colors.red),
      // ListTile은 메모의 제목, 내용, 생성 시간을 표시하는 위젯이다.
      child: ListTile(
        title: Text(note.title),
        subtitle: Text(
          note.content,
          maxLines: 2,
          // 메모의 내용이 너무 길 경우 잘라서 표시한다.
          overflow: TextOverflow.ellipsis,
        ),
        // trailing은 오른쪽에 표시되는 위젯이다.
        trailing: Text(
          _formatDate(note.createdTime),
          style: const TextStyle(fontSize: 12),
        ),
        // 메모를 클릭하면 메모를 편집하는 메서드를 호출한다.
        onTap: () => _editNote(note),
      ),
    );
  }

  // 추가 버튼 위젯
  Widget _buildAddButton() {
    // FloatingActionButton은 앱의 중앙에 떠있는 버튼이다.
    return FloatingActionButton(
      onPressed: _addNewNote,
      child: const Icon(Icons.add),
    );
  }
}
