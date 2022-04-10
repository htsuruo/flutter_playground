import 'package:flutter/material.dart';
import 'package:html/parser.dart' show parse;

void main() {
  runApp(
    const App(),
  );
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.from(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2E5817),
        ),
      ).copyWith(
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final document =
        parse('<body>Hello world! <a href="www.html5rocks.com">HTML5 rocks!');
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text(document.outerHtml),
      ),
    );
  }
}
