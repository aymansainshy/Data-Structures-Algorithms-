
import '../../Data-Structure/10 - Heaps/heap.dart';

void main() {
  final sorted = heapSort([6, 12, 2, 26, 8, 18, 21, 9, 5]);
  print(sorted);

  final list = [6, 12, 2, 26, 8, 18, 21, 9, 5];
  print(list);
  list.heapSortInPlace();
  print(list);
}

/*

• Heapsort leverages the heap data structure to sort elements in a list.
• The algorithm works by moving the values from the top of the heap to an ordered list. 
  This can be performed in place if you use an index to separate the end of the heap from the sorted list elements.
*/

List<E> heapSort<E extends Comparable<dynamic>>(List<E> list) {
  final heap = Heap<E>(
    elements: list.toList(),
    priority: Priority.min,
  );

  final sorted = <E>[];

  while (!heap.isEmpty) {
    final value = heap.remove();
    sorted.add(value!);
  }

  return sorted;
}
/*
 
 The performance of heapsort is O(n log n) for its best, worst and average cases.
 This uniformity in performance is because you have to traverse the whole list once,
 and every time you swap elements, you must perform a down-sift, which is an O(log n) operation.

 The space complexity of your first implementation, heapsort,
 was linear since you needed the extra list copies. However,
 your second implementation, heapsortInPlace, had a constant O(1) space complexity.
 Heapsort isn’t a stable sort because it depends on how the elements are put into the heap.
 If you were heapsorting a deck of cards by their rank, for example, you might see their
 suite change order compared to the original deck.
*/

// Sorting in Place
extension HeapSort<E extends Comparable<dynamic>> on List<E> {
  void heapSortInPlace() {
    if (isEmpty) return;

    final start = length ~/ 2 - 1;
    for (var i = start; i >= 0; i--) {
      _siftDown(start: i, end: length);
    }

    for (var end = length - 1; end > 0; end--) {
      _swapValues(0, end);
      _siftDown(start: 0, end: end);
    }
  }

  // Helper Methods
  int _leftChildIndex(int parentIndex) {
    return 2 * parentIndex + 1;
  }

  int _rightChildIndex(int parentIndex) {
    return 2 * parentIndex + 2;
  }

  void _swapValues(int indexA, int indexB) {
    final temp = this[indexA];
    this[indexA] = this[indexB];
    this[indexB] = temp;
  }

  void _siftDown({required int start, required int end}) {
    var parent = start;

    while (true) {
      final left = _leftChildIndex(parent);
      final right = _rightChildIndex(parent);
      var chosen = parent;

      if (left < end && this[left].compareTo(this[chosen]) > 0) {
        chosen = left;
      }

      if (right < end && this[right].compareTo(this[chosen]) > 0) {
        chosen = right;
      }
      if (chosen == parent) return;
      _swapValues(parent, chosen);
      parent = chosen;
    }
  }
}
