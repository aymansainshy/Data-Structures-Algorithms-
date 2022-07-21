import '../2 - Linked-List/single_linked_list.dart';
import '../4 - ring-buffer/ring_buffer.dart';

void main() {
  final queue = QueueRingBuffer<int>(4);
  queue.enqueue(1);
  queue.enqueue(2);
  queue.enqueue(3);
  queue.enqueue(4);

  print(queue);

  print("Front .. ${queue.peek}");
  // print("Rear .. ${queue.rear}");
  // print("Is Full .. ${queue.isFull}");
  print("Is Impty.. ${queue.isEmpty} \n");

  print(queue.dequeue());
  print(queue);

  print("Front .. ${queue.peek}");
  // print("Rear .. ${queue.rear}");
  // print("Is Full .. ${queue.isFull}");
  print("Is Impty.. ${queue.isEmpty} \n");

  queue.enqueue(5);
  print(queue);
  print("Front .. ${queue.peek}");

  // final queue = QueueList2<String>(4);

  // queue.enqueue("Ayman");
  // queue.enqueue("Mohammed");
  // queue.enqueue("Ali");
  // queue.enqueue("Adam");

  // print(queue);
  // print(queue.peek);

  // queue.dequeue();
  // print(queue);
  // print(queue.peek);

  // queue.enqueue("Yahia");
  // print(queue);
  // print(queue.peek);

  // queue.dequeue();
  // print(queue);
  // print(queue.peek);

  // final queueLinkedList = QueueLinkedList<int>();

  // queueLinkedList.enqueue(1);
  // queueLinkedList.enqueue(3);
  // queueLinkedList.enqueue(10);
  // queueLinkedList.enqueue(-56);

  // print(queueLinkedList);

  // queueLinkedList.dequeue();
  // print(queueLinkedList);

  // print(queueLinkedList.peek);

  // queueLinkedList.dequeue();
  // print(queueLinkedList);
}

// • enqueue: Insert an element at the back of the queue. Return true if the operation was successful.
// • dequeue: Remove the element at the front of the queue and return it.
// • isEmpty: Check if the queue is empty.
// • peek: Return the element at the front of the queue without removing it.

/* Notice that the queue only cares about removal from the front and insertion at the back.
 You don’t need to know what the contents are in between. 
 If you did, you would probably just use a list. */

/* In the following sections, you’ll learn to create a queue using four different internal
   data structures: 

  • List
  • Doubly linked list
  • Ring buffer
  • Two stacks
*/

abstract class Queue<T> {
  bool enqueue(T element);
  T? dequeue();

  bool get isEmpty;
  T? get peek;
}

// List-Based Implementation .... Speace Complexity is O(n)
class QueueList<T> implements Queue<T> {
  final _list = <T>[];

  @override // O(1) - worst case is O(n)
  bool enqueue(T element) {
    _list.add(element);
    return true;
  }

  @override
  T? dequeue() => (isEmpty) ? null : _list.removeAt(0); // O(n)

  @override
  bool get isEmpty => _list.isEmpty; // O(1)

  @override
  T? get peek => (isEmpty) ? null : _list.first; // O(1)

  @override
  String toString() => _list.toString();
}

// Fixed List-Based Implementation .... Speace Complexity is O(n)
class QueueList2<T> implements Queue<T> {
  QueueList2(int length) : _list = List.filled(length, null, growable: false);

  final List<T?> _list;
  int _front = 0;
  int _rear = 0;

  @override
  T? dequeue() {
    if (isEmpty) return null;
    final element = _list[_front];
    _list[_front] = null;
    _front++;
    return element;
  }

  @override
  bool enqueue(T element) {
    if (isFull) return false;

    _list[_rear] = element;
    _rear++;

    return true;
  }

  bool get isFull => _rear == _list.length ? true : false;

  @override
  bool get isEmpty => _list.isEmpty;

  @override
  T? get peek => _list[_front];

  @override
  String toString() {
    return _list.toString();
  }
}

// Doubly or Single Linked List Implementation .... Speace Complexity is O(n)
class QueueLinkedList<T> implements Queue<T> {
  final _list = LinkedList<T>();

  @override // O(1)
  bool enqueue(T element) {
    _list.append(element);
    return true;
  }

  @override
  T? dequeue() => _list.pop(); // O(1)

  @override
  bool get isEmpty => _list.isEmpty; // O(1)

  @override
  T? get peek => _list.head?.data; // O(1)

  @override
  String toString() => _list.toString();
}

// Ring Buffer Implementation .... Circular buffer -- Speace Complexity is O(n) But this doesn't require new memory allocation
/* 
 A ring buffer, also known as a circular buffer, is a fixed-size list.
 This data structure strategically wraps around to the beginning when there are no more items to remove at the end.
*/

class QueueRingBuffer<T> implements Queue<T> {
  QueueRingBuffer(int length) : _ringBuffer = RingBuffer<T>(length);

  final RingBuffer<T> _ringBuffer;

  @override // O(1)
  bool enqueue(T element) {
    if (_ringBuffer.isFull) {
      return false;
    }
    _ringBuffer.write(element);
    return true;
  }

  @override
  T? dequeue() => _ringBuffer.read(); // O(1)

  @override
  bool get isEmpty => _ringBuffer.isEmpty; // O(1)

  @override
  T? get peek => _ringBuffer.peek; // O(1)

  @override
  String toString() => _ringBuffer.toString();
}

// Ring Buffer Implementation 2 .... Circular buffer -- Speace Complexity is O(n) But this doesn't require new memory allocation
class CircularQueue<T> implements Queue<T> {
  CircularQueue(int length)
      : _list = List.filled(length, null, growable: false);

  final List<T?> _list;
  int _front = 0;
  int _rear = 0; //1
  int _size = 0; //1

  @override // O(1)
  bool enqueue(T element) {
    if (isFull) {
      return false;
    }
    _list[_rear] = element;
    _rear = ((_rear + 1) % _list.length);
    _size++;
    return true;
  }

  @override // O(1)
  T? dequeue() {
    if (isEmpty) {
      return null;
    }

    final element = _list[_front];
    _list[_front] = null;
    _front = ((_front + 1) % _list.length);
    _size--;
    return element;
  }

  bool get isFull => _size == _list.length; // O(1)

  T? get rear => _list[_rear];

  @override
  bool get isEmpty => _size == 0; // O(1)

  @override
  T? get peek => _list[_front]; // O(1)

  @override
  String toString() => _list.toString();
}

// Double-Stack Implementation .. Speace Complexity is O(n) 
class QueueStack<T> implements Queue<T> {
  final _leftStack = <T>[];
  final _rightStack = <T>[];

  @override // O(1) worst O(n)
  bool enqueue(T element) {
    _rightStack.add(element);
    return true;
  }

  @override // O(1) worst O(n)
  T? dequeue() {
    if (_leftStack.isEmpty) {
      _leftStack.addAll(_rightStack.reversed);
      _rightStack.clear();
    }

    if (_leftStack.isEmpty) return null;

    return _leftStack.removeLast();
  }

  @override
  bool get isEmpty => _leftStack.isEmpty && _rightStack.isEmpty; // O(1)

  @override
  T? get peek => _leftStack.isNotEmpty ? _leftStack.last : _rightStack.first; // O(1)

  @override
  String toString() {
    final combined = [
      ..._leftStack.reversed,
      ..._rightStack,
    ].join(', ');
    return '[$combined]';
  }
}
