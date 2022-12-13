import '../10 - Heaps/heap.dart';
import '../3 - Queues/queue.dart';
export '../10 - Heaps/heap.dart' show Priority;

void main() {
  // var priorityQueue = PriorityQueue(elements: [1, 12, 3, 4, 1, 6, 8, 7]);

  // while (!priorityQueue.isEmpty) {
  //   print(priorityQueue.dequeue()!);
  // }

  final p1 = Person(name: 'Josh', age: 21, isMilitary: true);
  final p2 = Person(name: 'Jake', age: 22, isMilitary: true);
  final p3 = Person(name: 'Clay', age: 28, isMilitary: false);
  final p4 = Person(name: 'Cindy', age: 29, isMilitary: false);
  final p5 = Person(name: 'Sabrina', age: 30, isMilitary: true);

  final waitlist = [p1, p2, p3, p4, p5];

  var priorityQueue2 = PriorityQueue(elements: waitlist);
  while (!priorityQueue2.isEmpty) {
    print(priorityQueue2.dequeue());
  }
}

/*
  A priority queue is another version of a queue in which elements
  are dequeued in priority order instead of FIFO order.

  A priority queue can be either of these two:
    1. Max-priority, in which the element at the front is always the largest.
    2. Min-priority, in which the element at the front is always the smallest.

  
You can create a priority queue in the following ways:

1. Sorted list: This is useful to obtain the maximum or minimum value of an element in O(1) time.
   However, insertion is slow and will require O(n) time since you have to first search for
   the insertion location and then shift every element after that location.

2. Balanced binary search tree: This is useful in creating a double-ended priority queue,
   which features getting both the minimum and maximum value in O(log n) time.
   Insertion is better than a sorted list, also O(log n).

3. Heap: This is a natural choice for a priority queue. 
   A heap is more efficient than a sorted list because a heap only needs to be partially sorted.\
   Inserting and removing from a heap are O(log n) while simply querying the highest priority value is O(1).  
*/

class PriorityQueue<E extends Comparable<dynamic>> implements Queue<E> {
  PriorityQueue({List<E>? elements, Priority priority = Priority.max}) {
    _heap = Heap<E>(elements: elements, priority: priority);
  }

  late Heap<E> _heap;

  @override // O(log n).
  bool enqueue(E element) {
    _heap.insert(element);
    return true;
  }

  @override // O(log n).
  E? dequeue() => _heap.remove();

  @override
  bool get isEmpty => _heap.isEmpty;

  @override
  E? get peek => _heap.peek;
}

class Person extends Comparable<Person> {
  final String name;
  final int age;
  final bool isMilitary;

  Person({
    required this.name,
    required this.age,
    required this.isMilitary,
  });

  @override
  int compareTo(Person other) {
    if (isMilitary == other.isMilitary) {
      return age.compareTo(other.age);
    }
    return isMilitary ? 1 : -1;
  }

  @override
  String toString() {
    final military = (isMilitary) ? ', (military)' : '';
    return '$name, age $age$military';
  }
}
