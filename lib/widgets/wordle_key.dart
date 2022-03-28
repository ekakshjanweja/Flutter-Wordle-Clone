import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wordle/providers/game_state_provider.dart';

class WordleKey extends ConsumerWidget {
  final String letter;
  const WordleKey({
    required this.letter,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    Widget keyCap;
    Color buttonColor;
    double keyWidth;
    if (letter == '_') {
      keyWidth = MediaQuery.of(context).size.width * 0.12;
      buttonColor = Colors.grey.shade800;
      keyCap = const Icon(
        Icons.check,
        color: Colors.white,
        size: 18,
      );
    } else if (letter == '<') {
      buttonColor = Colors.grey.shade800;
      keyWidth = MediaQuery.of(context).size.width * 0.12;
      keyCap = const Icon(
        Icons.backspace_outlined,
        color: Colors.white,
        size: 18,
      );
    } else {
      buttonColor = Colors.grey.shade900;
      keyWidth = MediaQuery.of(context).size.width * 0.079;
      keyCap = Text(
        letter.toUpperCase(),
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w900,
        ),
      );
    }
    return GestureDetector(
      onTap: () {
        ref.read(gameStateProvider.notifier).updateCurrentAttempt(letter);
      },
      child: Container(
        width: keyWidth,
        height: MediaQuery.of(context).size.height * 0.07,
        alignment: Alignment.center,
        margin: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          borderRadius:
              BorderRadius.circular(MediaQuery.of(context).size.height * 0.01),
          color: buttonColor,
        ),
        child: keyCap,
      ),
    );
  }
}
