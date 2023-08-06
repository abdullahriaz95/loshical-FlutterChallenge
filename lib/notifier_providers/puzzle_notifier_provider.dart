import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loshical/models/puzzle_state.dart';
import 'package:loshical/notifiers/puzzle_notifier.dart';

/// Notifier Provider for the PuzzleState

final puzzleNotifier = NotifierProvider<PuzzleNotifier, PuzzleState>(() {
  return PuzzleNotifier();
});
