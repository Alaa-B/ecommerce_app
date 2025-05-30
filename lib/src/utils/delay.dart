Future<void> delayed(bool delayed, [int miliseconds = 200]) {
  if (delayed) {
    return Future.delayed(Duration(milliseconds: miliseconds));
  } else {
    return Future.value();
  }
}
