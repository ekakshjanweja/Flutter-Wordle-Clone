import 'package:flutter/material.dart';

class WordleLetterbox extends StatelessWidget {
  final int pos;
  final String letter;
  final String correctWord;
  final bool isAttempted;
  const WordleLetterbox({
    required this.letter,
    required this.correctWord,
    required this.isAttempted,
    required this.pos,
    Key? key,
  }) : super(key: key);

  Color getBackgroundColor() {
    if (!isAttempted) {
      return Colors.transparent;
    } else if (!correctWord.contains(letter)) {
      return Colors.grey.shade600.withOpacity(0.4);
    } else if (correctWord.indexOf(letter) == pos) {
      return Colors.green.withOpacity(0.6);
    } else {
      return Colors.yellowAccent.withOpacity(0.6);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.height * 0.06,
      height: MediaQuery.of(context).size.height * 0.06,
      alignment: Alignment.center,
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.white.withOpacity(0.4),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(4),
        color: getBackgroundColor(),
      ),
      child: Text(
        letter.toUpperCase(),
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
