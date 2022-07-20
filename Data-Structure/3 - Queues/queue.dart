import '../2 - Linked-List/single_linked_list.dart';
import '../4 - Circular-buffer/circular_buffer.dart';

void main() {
  // final queue = QueueList<String>();

  // queue.enqueue("Ayman");
  // queue.enqueue("Mohammed");
  // queue.enqueue("Ali");
  // queue.enqueue("Adam");

  // print(queue);

  // queue.dequeue();
  // print(queue);

  // print(queue.peek);

  // queue.dequeue();
  // print(queue);

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

  final queue = QueueRingBuffer<int>(4);
  queue.enqueue(1);
  queue.enqueue(2);
  queue.enqueue(3);
  queue.enqueue(4);
  
  print(queue.peek);

  print(queue.dequeue());
  print(queue); 

  
  print(queue.peek);
  print(queue);
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

// Ring Buffer Implementation .... Circular buffer
/* 
 A ring buffer, also known as a circular buffer, is a fixed-size list.
 This data structure strategically wraps around to the beginning when there are no more items to remove at the end.
*/

class QueueRingBuffer<T> implements Queue<T> {
  QueueRingBuffer(int length) : _ringBuffer = RingBuffer<T>(length);

  final RingBuffer<T> _ringBuffer;

  @override
  bool enqueue(T element) {
    if (_ringBuffer.isFull) {
      return false;
    }
    _ringBuffer.write(element);
    return true;
  }

  @override
  T? dequeue() => _ringBuffer.read();

  @override
  bool get isEmpty => _ringBuffer.isEmpty;

  @override
  T? get peek => _ringBuffer.peek;

  @override
  String toString() => _ringBuffer.toString();
}
