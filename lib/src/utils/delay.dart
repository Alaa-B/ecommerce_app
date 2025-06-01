Future<void> delayed(bool delayed, [int milliseconds = 1200]) {
  if (delayed) {
    return Future.delayed(Duration(milliseconds: milliseconds));
  } else {
    return Future.value();
  }
}
