void main() {
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
  print("Peek .. ${ringBufferQueue.peek}");
  print("4 .. ${ringBufferQueue.read()}");
  print("5 .. ${ringBufferQueue.read()}");
  print("6 .. ${ringBufferQueue.read()}");

  ringBufferQueue.write(7);
  print("Peek .. ${ringBufferQueue.peek}");
  print(ringBufferQueue.toString());
  print(ringBufferQueue.isFull);

  print("All .. ${ringBufferQueue.read()}");
  print(ringBufferQueue);
  print("Peek .. ${ringBufferQueue.peek}");
}

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
    _list[_readIndex] = null;
    _readIndex = _advance(_readIndex);
    _size--;
    return element;
  }

  E? get peek => (isEmpty) ? null : _list[_readIndex];

  @override
  String toString() {
    return _list.toString();
    // final text = StringBuffer();
    // text.write('[');
    // int index = _readIndex;
    // while (index != _writeIndex) {
    //   if (index != _readIndex) {
    //     text.write(', ');
    //   }
    //   text.write(_list[index % _list.length]);
    //   index++;
    // }
    // text.write(']');
    // return text.toString();
  }
}
