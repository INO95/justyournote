// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:justyournote/main.dart';
import 'package:justyournote/models/note_model.dart';

void main() {
  // 기본 앱 실행 테스트
  // 앱이 정상적으로 실행되는지 테스트한다.
  // WidgetTester는 위젯을 테스트하는 도구이다.
  testWidgets('App launches correctly', (WidgetTester tester) async {
    // pumpWidget는 위젯을 펌핑하는 메서드이다.
    // 위젯을 펌핑하면 위젯의 상태가 변경되고, 위젯의 렌더링 결과가 화면에 표시된다.
    // main.dart에서 실행되는 FlutterNoteApp을 (메인 메소드) 펌핑한다.
    await tester.pumpWidget(const FlutterNoteApp());
    // expect는 테스트 결과를 확인하는 메서드이다.
    // find.text는 텍스트를 찾는 메서드이다.
    // 'My Vintage Notes'는 텍스트의 내용이다.
    // findsOneWidget는 텍스트를 찾았는지 확인하는 메서드이다.
    // 찾는 범위는 전체 화면이다.
    expect(find.text('My Vintage Notes'), findsOneWidget);
  });

  // 새 메모 추가 테스트
  testWidgets('Add new note flow', (WidgetTester tester) async {
    await tester.pumpWidget(const FlutterNoteApp());

    // FAB 탭하여 편집 화면 진입
    // FloatingActionButton은 메모 추가 버튼을 말한다.
    await tester.tap(find.byType(FloatingActionButton));
    // pumpAndSettle은 펌핑을 하고 펌핑이 완료될 때까지 대기하는 메서드이다.
    await tester.pumpAndSettle();

    // 텍스트 입력 및 저장
    // enterText는 텍스트를 입력하는 메서드이다.
    await tester.enterText(find.byType(TextField), 'Test Title\nTest Content');
    await tester.tap(find.byIcon(Icons.save));
    await tester.pumpAndSettle();

    // 결과 확인
    expect(find.text('Test Title'), findsOneWidget);
    expect(find.text('Test Content'), findsOneWidget);
  });

  // 메모 삭제 테스트
  testWidgets('Delete note by swiping', (WidgetTester tester) async {
    await tester.pumpWidget(const FlutterNoteApp());

    // 테스트 데이터 추가
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), 'Delete Test');
    await tester.tap(find.byIcon(Icons.save));
    await tester.pumpAndSettle();

    // 스와이프 동작
    // drag는 스와이프 동작을 테스트하는 메서드이다.
    // 좌표는 왼쪽으로 500만큼 이동하는 것을 의미한다.
    await tester.drag(find.text('Delete Test'), const Offset(-500, 0));
    await tester.pumpAndSettle();

    // 삭제 확인
    // findsNothing은 텍스트를 찾지 못했는지 확인하는 메서드이다.
    expect(find.text('Delete Test'), findsNothing);

    // 실행 취소(Undo) 확인
    await tester.tap(find.text('Undo'));
    await tester.pumpAndSettle();
    expect(find.text('Delete Test'), findsOneWidget);
  });

  // 메모 편집 테스트
  testWidgets('Edit existing note', (WidgetTester tester) async {
    await tester.pumpWidget(const FlutterNoteApp());

    // 테스트 데이터 추가
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), 'Original Text');
    await tester.tap(find.byIcon(Icons.save));
    await tester.pumpAndSettle();

    // 편집 모드 진입
    await tester.tap(find.text('Original Text'));
    await tester.pumpAndSettle();

    // 텍스트 수정 및 저장
    await tester.enterText(find.byType(TextField), 'Updated Text');
    await tester.tap(find.byIcon(Icons.save));
    await tester.pumpAndSettle();

    // 결과 확인
    expect(find.text('Updated Text'), findsOneWidget);
    expect(find.text('Original Text'), findsNothing);
  });

  // 모델 유닛 테스트
  // 모델 유닛 테스트는 모델의 기능을 테스트하는 것을 말한다.
  test('Note model serialization', () {
    final note = Note(
      title: 'Test',
      content: 'Content',
      createdTime: DateTime(2023, 1, 1),
    );

    final json = note.toJson();
    expect(json['title'], 'Test');
    expect(json['content'], 'Content');
    expect(json['createdTime'], '2023-01-01T00:00:00.000');

    final fromJson = Note.fromJson(json);
    expect(fromJson.title, 'Test');
    expect(fromJson.content, 'Content');
    expect(fromJson.createdTime, DateTime(2023, 1, 1));
  });
}
