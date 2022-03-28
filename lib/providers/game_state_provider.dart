import 'dart:math';

import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:wordle/data/wordle_repo.dart';
import 'package:wordle/globals.dart';
import 'package:wordle/providers/game_settings_providers.dart';

final gameStateProvider =
    StateNotifierProvider<GameStateNotifier, dynamic>((ref) {
  final gameSettings = ref.watch(gameSettingsProvider);
  final gameStateNotifier = GameStateNotifier(gameSettings);
  gameStateNotifier.updateWords();
  return gameStateNotifier;
});

class GameState {
  final GameSettings gameSettings;
  final List<String> validWords;
  final String correctWord;
  final List<String> attempts;
  final int attempted;

  GameState({
    required this.validWords,
    required this.correctWord,
    required this.gameSettings,
    required this.attempted,
    required this.attempts,
  });

  GameState clone({
    List<String>? validWords,
    String? correctWord,
    List<String>? attempts,
    int? attempted,
  }) {
    return GameState(
      validWords: validWords ?? this.validWords,
      correctWord: correctWord ?? this.correctWord,
      gameSettings: this.gameSettings,
      attempts: attempts ?? this.attempts,
      attempted: attempted ?? this.attempted,
    );
  }
}

class GameStateNotifier extends StateNotifier<GameState> {
  final Random rng = Random();

  GameStateNotifier(GameSettings gameSettings)
      : super(GameState(
          validWords: [],
          correctWord: 'begin',
          gameSettings: gameSettings,
          attempts: [],
          attempted: 0,
        ));

  Future<void> updateWords() async {
    final words = await loadWord(state.gameSettings.wordSize);
    state = state.clone(
      validWords: words,
      correctWord: words[rng.nextInt(500)],
      //gives range error on this
      //correctWord: state.validWords[rng.nextInt(state.validWords.length - 1)],
    );
  }

  void newCorrectWord() {
    state = state.clone(
      correctWord: state.validWords[rng.nextInt(500)],
      //gives range error on this
      //correctWord: state.validWords[rng.nextInt(state.validWords.length - 1)],
    );
  }

  void updateCurrentAttempt(String key) {
    BuildContext context;
    final attempts = state.attempts;
    if (attempts.length <= state.attempted) {
      attempts.add('');
    }
    var currentAttempt = attempts[state.attempted];
    if (key == '_') {
      if (currentAttempt.length < state.gameSettings.wordSize) {
        snackbarKey.currentState?.showSnackBar(
          SnackBar(
            backgroundColor: Colors.grey.shade900,
            duration: const Duration(milliseconds: 5000),
            content: const Text(
              'Attempted word is incomplete',
              style: TextStyle(color: Colors.white),
            ),
            action: SnackBarAction(
              label: 'Dismiss',
              onPressed: () {},
            ),
          ),
        );

        print('Attempted word is incomplete');
        return;
      }
      if (!state.validWords.contains(currentAttempt)) {
        snackbarKey.currentState?.showSnackBar(
          SnackBar(
            backgroundColor: Colors.grey.shade900,
            duration: const Duration(milliseconds: 5000),
            content: const Text(
              'Not a valid word',
              style: TextStyle(color: Colors.white),
            ),
            action: SnackBarAction(
              label: 'Dismiss',
              onPressed: () {},
            ),
          ),
        );

        print('Not a valid word');
      }
      if (state.correctWord == currentAttempt) {
        snackbarKey.currentState?.showSnackBar(
          SnackBar(
            backgroundColor: Colors.green.shade700,
            duration: const Duration(milliseconds: 5000),
            content: const Text(
              'Won',
              style: TextStyle(color: Colors.white),
            ),
            action: SnackBarAction(
              label: 'Play Again',
              textColor: Colors.white,
              onPressed: _restartApp,
            ),
          ),
        );
        print('Won');
      }
      if (state.correctWord != currentAttempt && state.attempted == 5) {
        snackbarKey.currentState?.showSnackBar(
          SnackBar(
            backgroundColor: Colors.red.shade700,
            duration: const Duration(milliseconds: 5000),
            content: const Text(
              'Lost',
              style: TextStyle(color: Colors.white),
            ),
            action: SnackBarAction(
              label: 'Try Again',
              textColor: Colors.white,
              onPressed: _restartApp,
            ),
          ),
        );

        print('Lost');
      }
      state = state.clone(
        attempted: state.attempted + 1,
      );
    } else if (key == '<') {
      if (currentAttempt.isEmpty) {
        snackbarKey.currentState?.showSnackBar(
          SnackBar(
            backgroundColor: Colors.grey.shade900,
            duration: const Duration(milliseconds: 5000),
            content: const Text(
              'Can\'t Delete Empty String',
              style: TextStyle(color: Colors.white),
            ),
            action: SnackBarAction(
              label: 'Dismiss',
              onPressed: () {},
            ),
          ),
        );
        print('Can\'t Delete Empty String');
        return;
      }
      currentAttempt = currentAttempt.substring(0, currentAttempt.length - 1);
      attempts[state.attempted] = currentAttempt;
      state = state.clone(attempts: attempts);
    } else {
      if (currentAttempt.length >= state.gameSettings.wordSize) {
        snackbarKey.currentState?.showSnackBar(
          SnackBar(
            backgroundColor: Colors.grey.shade900,
            duration: const Duration(milliseconds: 5000),
            content: const Text(
              'Trying to attempt a word longer than correct word',
              style: TextStyle(color: Colors.white),
            ),
            action: SnackBarAction(
              label: 'Dismiss',
              onPressed: () {},
            ),
          ),
        );
        print('Trying to attempt a word longer than correct word');
        return;
      }
      currentAttempt += key;
      print(currentAttempt);
      attempts[state.attempted] = currentAttempt;
      state = state.clone(attempts: attempts);
    }
  }

  void _restartApp() async {}
}
