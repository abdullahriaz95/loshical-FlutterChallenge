import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loshical/models/answer_state.dart';
import 'package:loshical/models/puzzle_state.dart';
import 'package:loshical/models/user_action.dart';

/// Puzzle Notifier that is to be provided in the app. It also implements
/// Listenable so that "redirect" functionality works fine with Go Router.

class PuzzleNotifier extends Notifier<PuzzleState> implements Listenable {
  VoidCallback? _routerListener;

  // Since we know for this puzzle example, the answer is image Id 5.
  // If there were multiple questions/puzzles, we could have make an List<object>
  final int answer = 5;

  // This is the id Of the question, to which we are picking a suitable answer.
  // As described above, this is known in this example. But if there were multiple
  // puzzles, these values would be in some List<object>.
  final int questionToAnswer = 2;

  @override
  PuzzleState build() {
    // We need to call the Router Listener for Go Router to check if any
    // redirection is needed.
    ref.listenSelf((_, __) {
      _routerListener?.call();
    });

    return const PuzzleState(
      selectedImageId: 0,
      userAction: UserAction.idle,
      answerState: AnswerState.unknown,
    );
  }

  /// We need to have the image ID and update the dragging state, to know
  /// which image is user currently dragging
  dragStarted(int imageId) {
    var answerState = AnswerState.unknown;
    if (imageId == answer) {
      answerState = AnswerState.correct;
    } else {
      answerState = AnswerState.wrong;
    }

    state = state.copyWith(
        userAction: UserAction.dragging, id: imageId, answerState: answerState);
  }

  // When user loses touch outside of target widget, we go back to idle state.
  dragToIdle() {
    // Since we redirect user to ResultScreen based on "UserAction == Dragged",
    // so first we check if user has acheived this Dragged state, if yes, we
    // don't go to idle. Since we have already finished the game and let the
    // go Router to redirect to ResultScreen.
    if (!state.userAction.isDropped) {
      state = state.copyWith(
          userAction: UserAction.idle, answerState: AnswerState.unknown);
    }
  }

  // Updates the state to "Dropped". It means the user has dropped the
  // answer in the target.
  draggedToTarget() {
    state = state.copyWith(
      userAction: UserAction.dropped,
    );
  }

  // Resets the whole state. Triggered from ResultScreen.
  reset() {
    state = state.copyWith(
      id: 0,
      userAction: UserAction.idle,
      answerState: AnswerState.unknown,
    );
  }

  // overriden methods for Lisenable.
  @override
  void addListener(VoidCallback listener) {
    _routerListener = listener;
  }

  @override
  void removeListener(VoidCallback listener) {
    _routerListener = null;
  }
}
