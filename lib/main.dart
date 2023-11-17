import 'dart:io';

import 'package:flutter/material.dart';
import 'package:nomad_flutter_webtoon/screens/home_screen.dart';
import 'package:nomad_flutter_webtoon/services/user_agent.dart';

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeScreen(),
    );
  }
}
