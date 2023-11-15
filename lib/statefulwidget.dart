import 'package:flutter/material.dart';
import 'package:nomad_flutter_webtoon/screens/home_screen_123.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        // ignore: deprecated_member_use
        backgroundColor: const Color(0xffe7626c),
        // ignore: deprecated_member_use
        textTheme: const TextTheme(
          // ignore: deprecated_member_use
          headline1: TextStyle(
            color: Color(0xff232b55),
          ),
        ),
        cardColor: const Color(0xfff4eddb),
      ),
      home: const HomeScreen(),
    );
  }
}
