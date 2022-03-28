import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wordle/providers/game_settings_providers.dart';

class WordSizeToggle extends ConsumerWidget {
  const WordSizeToggle({Key? key}) : super(key: key);

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    final gameSettings = ref.watch(gameSettingsProvider);
    final gameSettingsNotifier = ref.read(gameSettingsProvider.notifier);

    void _updateWordSize() {
      var newWordSize = 5;
      if (gameSettings.wordSize == 4) newWordSize = 5;
      if (gameSettings.wordSize == 5) newWordSize = 6;
      if (gameSettings.wordSize == 6) newWordSize = 4;
      gameSettingsNotifier.updateWordSize(newWordSize);
    }

    return Container(
      width: MediaQuery.of(context).size.width * 0.1,
      height: MediaQuery.of(context).size.width * 0.1,
      decoration: BoxDecoration(
        color: Colors.purple.withOpacity(0.4),
        borderRadius: BorderRadius.circular(10),
      ),
      child: OutlinedButton(
        child: Text(
          gameSettings.wordSize.toString(),
          style: const TextStyle(color: Colors.white),
        ),
        onPressed: _updateWordSize,
      ),
    );
  }
}
