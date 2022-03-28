import 'package:flutter/material.dart';
import 'package:wordle/widgets/wordle_key.dart';

class WordleKeyboard extends StatefulWidget {
  WordleKeyboard({Key? key}) : super(key: key);

  @override
  State<WordleKeyboard> createState() => _WordleKeyboardState();
}

class _WordleKeyboardState extends State<WordleKeyboard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (var i in 'qwertyuiop'.split('')) WordleKey(letter: i),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (var i in 'asdfghjkl'.split('')) WordleKey(letter: i),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (var i in '_zxcvbnm<'.split('')) WordleKey(letter: i),
            ],
          ),
        ],
      ),
    );
  }
}
