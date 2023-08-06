import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loshical/hugged_child.dart';
import 'package:loshical/models/user_action.dart';
import 'package:loshical/notifier_providers/puzzle_notifier_provider.dart';
import 'package:loshical/utils.dart';

class AnswerImage extends ConsumerWidget {
  const AnswerImage({super.key, required this.assetPath});
  final String assetPath;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final image = Image.asset(assetPath); // current image widget
    final currentImageId =
        Utils.getImageName(assetPath); // getting the id of image

    var userAction = ref.watch(puzzleNotifier.select(
        (value) => value.userAction)); // we watch for user action changes

    bool hideOriginalWidget = false;

    // we check if the user is actually dragging this specific widget
    if (userAction.isDragging &&
        currentImageId == ref.read(puzzleNotifier).selectedImageId) {
      hideOriginalWidget = true;
    }

    return Draggable<int>(
      data: currentImageId,
      onDragStarted: () {
        ref.read(puzzleNotifier.notifier).dragStarted(currentImageId);
      },
      onDragEnd: (_) {
        ref.read(puzzleNotifier.notifier).dragToIdle();
      },
      feedback: HuggedChild(
        child: image,
      ),
      child: HuggedChild(
        child:
            hideOriginalWidget // Replacing answer image with empty space, while the user is dragging
                ? const SizedBox(
                    width: 70,
                  )
                : image,
      ),
    );
  }
}
