import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loshical/assets.dart';
import 'package:loshical/models/answer_state.dart';
import 'package:loshical/notifier_providers/puzzle_notifier_provider.dart';

/// Displays the image that user dragged and dropped, id passed from the GoRouter
/// Displays the message based on the answer (correct or incorrect), checking this
/// from the puzzle provider as asked
/// And adds a reset button to reset the whole game.

class ResultScreen extends ConsumerWidget {
  const ResultScreen({required this.answerImageId, super.key});
  final String answerImageId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isCorrectAnswer = ref.read(puzzleNotifier).answerState.isCorrect;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Result'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image.asset(
            AssetManager.path(
                id: int.parse(answerImageId), assetType: AssetType.answer),
            height: 100,
            width: 100,
          ),
          const SizedBox(
            height: 24,
          ),
          Text(
            isCorrectAnswer ? 'Congratulations' : 'Game Over',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: isCorrectAnswer ? Colors.green : Colors.red,
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 24,
          ),
          TextButton(
            onPressed: () {
              ref.read(puzzleNotifier.notifier).reset();
            },
            child: Text(
              'Reset',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
        ],
      ),
    );
  }
}
