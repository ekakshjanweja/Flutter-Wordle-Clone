import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wordle/providers/game_settings_providers.dart';
import 'package:wordle/providers/game_state_provider.dart';
import 'package:wordle/widgets/wordle_letterbox.dart';
import 'package:wordle/widgets/wordle_row.dart';

const rows = 6;

class WordleGrid extends ConsumerWidget {
  const WordleGrid({Key? key}) : super(key: key);

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    final gameSettings = ref.watch(gameSettingsProvider);
    final gameState = ref.watch(gameStateProvider);
    print('New Correct Word: ${gameState.correctWord}');

    final wordSize = gameSettings.wordSize;
    final List<WordleRow> rows = List.empty(growable: true);
    for (int i = 0; i < gameSettings.attempts; i++) {
      var word = "";
      if (gameState.attempts.length > i) {
        print(gameState.attempts[i]);
        word = gameState.attempts[i];
      }
      var attempted = false;
      if (gameState.attempted > i) {
        attempted = true;
      }
      rows.add(WordleRow(
        wordSize: wordSize,
        word: word,
        attempted: attempted,
        correctWord: gameState.correctWord,
      ));
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: rows,
    );
  }
}
