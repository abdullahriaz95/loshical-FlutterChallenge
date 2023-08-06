class Utils {
  /// Performs string operations and gives the id of the image
  /// Since, we have the same pattern (naming convention for assets),
  /// so we can safely use this way.
  static int getImageName(String s) {
    var splittedStrings = s.split('.');
    return int.parse(splittedStrings[0].substring(8));
  }
}
