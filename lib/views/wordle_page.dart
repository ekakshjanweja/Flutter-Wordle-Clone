import 'package:flutter/material.dart';
import 'package:wordle/widgets/wordle_grid.dart';
import 'package:wordle/widgets/wordle_keyboard.dart';
import 'package:wordle/widgets/wordle_title_bar.dart';

class WordlePage extends StatefulWidget {
  WordlePage({Key? key}) : super(key: key);

  @override
  State<WordlePage> createState() => _WordlePageState();
}

class _WordlePageState extends State<WordlePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            WordleTitleBar(),
            WordleGrid(),
            WordleKeyboard(),
          ],
        ),
      ),
    );
  }
}
