import 'package:flutter/material.dart';
import 'package:nomad_flutter_webtoon/widgets/webtoon_widget_list.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xff00d966),
        centerTitle: true,
        title: const Text(
          "Nomad Webtoon",
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: const WebtoonList(),
    );
  }
}
