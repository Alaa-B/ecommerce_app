Future<void> delayed(bool delayed, [int miliseconds = 2000]) {
  if (delayed) {
    return Future.delayed(Duration(milliseconds: miliseconds));
  } else {
    return Future.value();
  }
}
