import 'package:flutter/material.dart';
import 'package:loshical/models/answer_state.dart';
import 'package:loshical/models/user_action.dart';

/// Holds the state of the whole puzzle game. This is used by the Notifier
/// Provider to manage the whole state of the game and UI.

@immutable
class PuzzleState {
  const PuzzleState({
    required this.selectedImageId,
    required this.userAction,
    required this.answerState,
  });

  final int selectedImageId;
  final UserAction userAction;
  final AnswerState answerState;

  PuzzleState copyWith(
      {int? id, UserAction? userAction, AnswerState? answerState}) {
    return PuzzleState(
      selectedImageId: id ?? selectedImageId,
      userAction: userAction ?? this.userAction,
      answerState: answerState ?? this.answerState,
    );
  }
}
