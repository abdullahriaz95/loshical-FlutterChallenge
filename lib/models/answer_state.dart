enum AnswerState {
  unknown, // we don't know the state of the answer selected
  correct, // the answer selected by user is correct
  wrong, // the answer selected by user is incorrect
}

extension AnswerStateX on AnswerState {
  bool get isUnknown => this == AnswerState.unknown;
  bool get isCorrect => this == AnswerState.correct;
  bool get isWrong => this == AnswerState.wrong;
}
