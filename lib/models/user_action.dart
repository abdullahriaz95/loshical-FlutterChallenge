enum UserAction {
  dragging, // when user is dragging the answer
  dropped, // when user has dropped the answer in the in the required place ie. "?"
  idle, // when no dragging is being performed, idle state
}

extension UserActionX on UserAction {
  bool get isDragging => this == UserAction.dragging;
  bool get isDropped => this == UserAction.dropped;
  bool get isIdle => this == UserAction.idle;
}
