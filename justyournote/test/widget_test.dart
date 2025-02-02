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
  // Basic app launch test
  // 基本的なアプリ起動テスト
  testWidgets('App launches correctly', (WidgetTester tester) async {
    await tester.pumpWidget(const FlutterNoteApp());
    expect(find.text('My Vintage Notes'), findsOneWidget);
  });

  // 새 메모 추가 테스트
  // Add new note test
  // 新しいノート追加テスト
  testWidgets('Add new note flow', (WidgetTester tester) async {
    await tester.pumpWidget(const FlutterNoteApp());

    // FAB 탭하여 편집 화면 진입
    // Tap FAB to enter edit screen
    // FABをタップして編集画面に入る
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();

    // 텍스트 입력 및 저장
    // Enter text and save
    // テキストを入力して保存
    await tester.enterText(find.byType(TextField), 'Test Title\nTest Content');
    await tester.tap(find.byIcon(Icons.save));
    await tester.pumpAndSettle();

    // 결과 확인
    // Verify result
    // 結果を確認
    expect(find.text('Test Title'), findsOneWidget);
    expect(find.text('Test Content'), findsOneWidget);
  });

  // 메모 삭제 테스트
  // Delete note test
  // ノート削除テスト
  testWidgets('Delete note by swiping', (WidgetTester tester) async {
    await tester.pumpWidget(const FlutterNoteApp());

    // 테스트 데이터 추가
    // Add test data
    // テストデータを追加
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), 'Delete Test');
    await tester.tap(find.byIcon(Icons.save));
    await tester.pumpAndSettle();

    // 스와이프 동작
    // Swipe action
    // スワイプ動作
    await tester.drag(find.text('Delete Test'), const Offset(-500, 0));
    await tester.pumpAndSettle();

    // 삭제 확인
    // Verify deletion
    // 削除を確認
    expect(find.text('Delete Test'), findsNothing);

    // 실행 취소(Undo) 확인
    // Verify undo functionality
    // アンドゥ機能を確認
    await tester.tap(find.text('Undo'));
    await tester.pumpAndSettle();
    expect(find.text('Delete Test'), findsOneWidget);
  });

  // 메모 편집 테스트
  // Edit note test
  // ノート編集テスト
  testWidgets('Edit existing note', (WidgetTester tester) async {
    await tester.pumpWidget(const FlutterNoteApp());

    // 테스트 데이터 추가
    // Add test data
    // テストデータを追加
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), 'Original Text');
    await tester.tap(find.byIcon(Icons.save));
    await tester.pumpAndSettle();

    // 편집 모드 진입
    // Enter edit mode
    // 編集モードに入る
    await tester.tap(find.text('Original Text'));
    await tester.pumpAndSettle();

    // 텍스트 수정 및 저장
    // Modify text and save
    // テキストを修正して保存
    await tester.enterText(find.byType(TextField), 'Updated Text');
    await tester.tap(find.byIcon(Icons.save));
    await tester.pumpAndSettle();

    // 결과 확인
    // Verify update
    // 更新を確認
    expect(find.text('Updated Text'), findsOneWidget);
    expect(find.text('Original Text'), findsNothing);
  });

  // 모델 유닛 테스트
  // Model unit test
  // モデルユニットテスト
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
