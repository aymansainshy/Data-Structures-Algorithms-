import 'dart:collection';

void main() {
  // final buffer = CircularBuffer<int>(3)
  //   ..add(1)
  //   ..add(2)
  //   ..add(20)
  //   ..add(15);

  // print(buffer.length); // 2
  // print(buffer.first); // 1
  // print(buffer.isFilled); // false
  // print(buffer.isUnfilled); // true
  // print(buffer.toString());
  // print(buffer[2]);
  // print(buffer.last);

  final ringBufferQueue = RingBuffer(6);

  ringBufferQueue.write(1);
  ringBufferQueue.write(2);
  ringBufferQueue.write(3);
  ringBufferQueue.write(4);
  ringBufferQueue.write(5);
  ringBufferQueue.write(6);

  print("Peek .. ${ringBufferQueue.peek}");
  print(ringBufferQueue.isFull);
  print("1 .. ${ringBufferQueue.read()}");
  print("2 .. ${ringBufferQueue.read()}");
  print("3 .. ${ringBufferQueue.read()}");
  print("4 .. ${ringBufferQueue.read()}");
  print("5 .. ${ringBufferQueue.read()}");
  print("6 .. ${ringBufferQueue.read()}");
  
  ringBufferQueue.write(7);
  print("Peek .. ${ringBufferQueue.peek}");
  print(ringBufferQueue.toString());
  print(ringBufferQueue.isFull);

  // print("All .. ${ringBufferQueue.read()}");
  // print(ringBufferQueue.toString());
}

/// A [CircularBuffer] with a fixed capacity supporting all [List] operations

class CircularBuffer<T> with ListMixin<T> {
  /// Creates a [CircularBuffer] with a `capacity`
  CircularBuffer(this.capacity)
      : assert(capacity > 1, 'CircularBuffer must have a positive capacity.'),
        _buf = [];

  /// Creates a [CircularBuffer] based on another `list`
  CircularBuffer.of(List<T> list, [int? capacity])
      : assert(
          capacity == null || capacity >= list.length,
          'The capacity must be at least as long as the existing list',
        ),
        capacity = capacity ?? list.length,
        _buf = [...list];

  final List<T> _buf;

  /// Maximum number of elements of [CircularBuffer]
  final int capacity;

  int _start = 0;

  /// Resets the [CircularBuffer].
  ///
  /// [capacity] is unaffected.
  void reset() {
    _start = 0;
    _buf.clear();
  }

  /// An alias to [reset].
  @override
  void clear() => reset();

  @override
  void add(T element) {
    if (isUnfilled) {
      // The internal buffer is not at its maximum size.  Grow it.
      assert(_start == 0, 'Internal buffer grown from a bad state');
      _buf.add(element);
      return;
    }

    // All space is used, so overwrite the start.
    _buf[_start] = element;
    _start++;
    if (_start == capacity) {
      _start = 0;
    }
  }

  /// Number of used elements of [CircularBuffer]
  @override
  int get length => _buf.length;

  /// The [CircularBuffer] `isFilled` if the [length]
  /// is equal to the [capacity].
  bool get isFilled => _buf.length == capacity;

  /// The [CircularBuffer] `isUnfilled` if the [length] is
  /// less than the [capacity].
  bool get isUnfilled => _buf.length < capacity;

  @override
  T operator [](int index) {
    if (index >= 0 && index < _buf.length) {
      return _buf[(_start + index) % _buf.length];
    }
    throw RangeError.index(index, this);
  }

  @override
  void operator []=(int index, T value) {
    if (index >= 0 && index < _buf.length) {
      _buf[(_start + index) % _buf.length] = value;
    } else {
      throw RangeError.index(index, this);
    }
  }

  /// The `length` mutation is forbidden
  @override
  set length(int newLength) {
    throw UnsupportedError('Cannot resize a CircularBuffer.');
  }
}

////////////////////////////////////////////////////////[Raywenderlich_Book]///////////////////////////////////////////////////////////////////

class RingBuffer<E> {
  RingBuffer(int length) : _list = List.filled(length, null, growable: false);

  final List<E?> _list;
  int _writeIndex = 0;
  int _readIndex = 0;
  int _size = 0;

  bool get isFull => _size == _list.length;

  bool get isEmpty => _size == 0;

  void write(E element) {
    if (isFull) throw Exception('Buffer is full');
    _list[_writeIndex] = element;
    _writeIndex = _advance(_writeIndex);
    _size++;
  }

  int _advance(int index) {
    return (index == _list.length - 1) ? 0 : index + 1;
  }

  E? read() {
    if (isEmpty) return null;
    final element = _list[_readIndex];
    _readIndex = _advance(_readIndex);
    _size--;
    return element;
  }

  E? get peek => (isEmpty) ? null : _list[_readIndex];

  @override
  String toString() {
    final text = StringBuffer();
    text.write('[');
    int index = _readIndex;
    while (index != _writeIndex) {
      if (index != _readIndex) {
        text.write(', ');
      }
      text.write(_list[index % _list.length]);
      index++;
    }
    text.write(']');
    return text.toString();
  }
}
