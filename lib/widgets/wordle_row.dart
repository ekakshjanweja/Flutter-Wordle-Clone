import 'package:flutter/material.dart';
import 'package:wordle/widgets/wordle_letterbox.dart';

class WordleRow extends StatelessWidget {
  final int wordSize;
  final String word;
  final String correctWord;
  final bool attempted;
  const WordleRow({
    required this.wordSize,
    required this.word,
    required this.attempted,
    required this.correctWord,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<WordleLetterbox> boxes = List.empty(growable: true);

    for (var j = 0; j < wordSize; j++) {
      var letter = '';
      if (word.length > j) {
        letter = word[j];
      }
      boxes.add(
        WordleLetterbox(
          letter: letter,
          isAttempted: attempted,
          correctWord: correctWord,
          pos: j,
        ),
      );
    }
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: boxes,
    );
  }
}
