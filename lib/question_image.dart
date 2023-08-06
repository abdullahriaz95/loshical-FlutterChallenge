import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loshical/hugged_child.dart';
import 'package:loshical/models/answer_state.dart';
import 'package:loshical/models/user_action.dart';
import 'package:loshical/notifier_providers/puzzle_notifier_provider.dart';
import 'package:loshical/utils.dart';

class QuestionImage extends ConsumerWidget {
  const QuestionImage({super.key, required this.assetPath});
  final String assetPath;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final image = Image.asset(assetPath);
    final currentImageId = Utils.getImageName(assetPath);

    // Checking if this question is not to be answerd, then just simply
    // display the normal Image Widget.
    if (currentImageId != ref.read(puzzleNotifier.notifier).questionToAnswer) {
      return HuggedChild(
        child: image,
      );
    }

    // Otherwise, handle the widget that is to be answered.

    var userAction =
        ref.watch(puzzleNotifier.select((value) => value.userAction));

    Border? border;

    // we need to check a couple of things.
    // 1. if the user is dragging
    // 2. if it is correct or incorrect

    if (userAction.isDragging &&
        ref.read(puzzleNotifier).answerState.isCorrect) {
      border = Border.all(color: Colors.green, width: 4);
    } else if (userAction.isDragging &&
        ref.read(puzzleNotifier).answerState.isWrong) {
      border = Border.all(color: Colors.red, width: 4);
    }

    return DragTarget<int>(
      builder: (context, accepted, rejected) {
        return HuggedChild(
          child: Container(
            decoration: BoxDecoration(border: border),
            child: image,
          ),
        );
      },
      onAccept: (int data) {
        ref.read(puzzleNotifier.notifier).draggedToTarget();
      },
    );
  }
}
