import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/game_settings_providers.dart';

class WordAttemptsToggle extends ConsumerWidget {
  const WordAttemptsToggle({Key? key}) : super(key: key);

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    final gameSettings = ref.watch(gameSettingsProvider);
    final gameSettingsNotifier = ref.read(gameSettingsProvider.notifier);

    Color difficultyColor = Colors.green;
    if (gameSettings.attempts == 5) difficultyColor = Colors.red;
    if (gameSettings.attempts == 6) difficultyColor = Colors.yellow;
    if (gameSettings.attempts == 7) difficultyColor = Colors.green;

    void _updateAttempts() {
      var newAttempts = 6;
      if (gameSettings.attempts == 5) newAttempts = 6;
      if (gameSettings.attempts == 6) newAttempts = 7;
      if (gameSettings.attempts == 7) newAttempts = 5;

      gameSettingsNotifier.updateAttempts(newAttempts);
    }

    return GestureDetector(
      onTap: _updateAttempts,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.1,
        height: MediaQuery.of(context).size.width * 0.1,
        decoration: BoxDecoration(
          color: difficultyColor.withOpacity(0.4),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
