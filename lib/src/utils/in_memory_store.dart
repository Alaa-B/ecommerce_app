import 'package:rxdart/rxdart.dart';

// * InMemoryStore is a simple in-memory store that uses BehaviorSubject to
// * manage the state of a single value.

class InMemoryStore<T> {
  /// Creates an InMemoryStore with an initial value.
  InMemoryStore(T inital) : _subject = BehaviorSubject<T>.seeded(inital);
  final BehaviorSubject<T> _subject;

  // * The stream of the store. It emits the current value and any changes to it.
  Stream<T> get stream => _subject.stream;

  // * The current value of the store. It can be read and written to.
  T get value => _subject.value;
  set value(T value) => _subject.add(value);

  // * This is important to prevent memory leaks.
  void close() => _subject.close();
}
