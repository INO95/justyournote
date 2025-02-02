import 'package:flutter/material.dart';

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
      title: 'Flutter Demo',
      theme: ThemeData().copyWith(
        brightness: Brightness.light,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 220, 237, 222),
          brightness: Brightness.light,
        ).copyWith(
          surface: const Color.fromARGB(255, 245, 250, 246),
        ),
        scaffoldBackgroundColor: const Color.fromARGB(255, 245, 250, 246),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Color.fromARGB(255, 51, 51, 51)),
        ),
      ),
      home: const MyHomePage(title: 'Notes'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              maxLines: 300,
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
