import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wordle/widgets/word_attempts_toggle.dart';
import 'package:wordle/widgets/word_size_toggle.dart';

class WordleTitleBar extends StatefulWidget {
  WordleTitleBar({Key? key}) : super(key: key);

  @override
  State<WordleTitleBar> createState() => _WordleTitleBarState();
}

class _WordleTitleBarState extends State<WordleTitleBar> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.width * 0.01),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          WordAttemptsToggle(),
          Text(
            'WORDLE',
            style: TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 24,
              color: Colors.white,
              letterSpacing: 4,
            ),
          ),
          WordSizeToggle(),
        ],
      ),
    );
  }
}
