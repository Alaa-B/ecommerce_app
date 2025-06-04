Future<void> delayed(bool delayed, [int milliseconds = 600]) {
  if (delayed) {
    return Future.delayed(Duration(milliseconds: milliseconds));
  } else {
    return Future.value();
  }
}
