void main() {
  final heap = Heap<int>();
  heap.insert(8);
  heap.insert(6);
  heap.insert(5);
  heap.insert(4);
  heap.insert(3);
  heap.insert(2);
  heap.insert(1);
  print(heap);

  heap.insert(7);
  print(heap);

  final root = heap.remove();
  print(root);
  print(heap);

  final index = heap.indexOf(7);
  print("Index of 7 is : $index");

  // var heap = Heap(elements: [1, 12, 3, 4, 1, 6, 8, 7]);
  // print(heap);
  // while (!heap.isEmpty) {
  //   print(heap.remove());
  // }
}

/*
What’s a Heap? : 

  Heaps are another classical tree-based data structure with special properties to quickly fetch the largest or smallest element.
  A heap is a complete binary tree, also known as a binary heap, that can be constructed using a list.

  Note: 
    Don’t confuse these heaps with memory heaps. 
    The term heap is sometimes confusingly used in computer science to refer to a pool of memory.
    Memory heaps are a different concept and not what you’re studying here.

    1. Max-heap:
     - in which elements with a higher value have a higher priority.
     - parent nodes must always contain a value that is greater than or equal to the value in its children.
       The root node will always contain the highest value.

    2. Min-heap:
      - in which elements with a lower value have a higher priority.
      - parent nodes must always contain a value that is less than or equal to the value in its children.
        The root node will always contain the lowest value.
*/

enum Priority { max, min }

class Heap<E extends Comparable<dynamic>> {
  Heap({List<E>? elements, this.priority = Priority.max}) {
    this.elements = (elements == null) ? [] : elements;
    _buildHeap();
  }

  late final List<E> elements;
  final Priority priority;

  bool get isEmpty => elements.isEmpty;
  int get size => elements.length;
  E? get peek => (isEmpty) ? null : elements.first;

  void _buildHeap() {
    if (isEmpty) return;
    final start = elements.length ~/ 2 - 1;
    for (var i = start; i >= 0; i--) {
      _siftDown(i);
    }
  }

  /*
    Inserting ....
    The overall complexity of insert is O(log n). 
    Adding an element to a list takes only O(1) while sifting elements up in a heap takes O(log n).
  */
  void insert(E value) {
    elements.add(value);
    _siftUp(elements.length - 1);
  }

  void _siftUp(int index) {
    var child = index;
    var parent = _parentIndex(child);

    while (child > 0 && child == _higherPriority(child, parent)) {
      _swapValues(child, parent);
      child = parent;
      parent = _parentIndex(child);
    }
    ;
  }

  /*
    Removing ....
    The overall complexity of remove is O(log n).
    Swapping elements in a list is only O(1) while sifting elements down in a heap takes O(log n) time.
  */
  E? remove() {
    if (isEmpty) return null;

    _swapValues(0, elements.length - 1);

    final value = elements.removeLast();

    _siftDown(0);

    return value;
  }

  void _siftDown(int index) {
    var parent = index;
    while (true) {
      final left = _leftChildIndex(parent);
      final right = _rightChildIndex(parent);

      var chosen = _higherPriority(left, parent);

      chosen = _higherPriority(right, chosen);

      if (chosen == parent) return;

      _swapValues(parent, chosen);
      parent = chosen;
    }
  }

  /*
    Removing from an Arbitrary index ....
    Removing an arbitrary element from a heap is an O(log n) operation.
    However, it also requires knowing the index of the element you want to delete.
  */
  E? removeAt(int index) {
    final lastIndex = elements.length - 1;

    if (index < 0 || index > lastIndex) {
      return null;
    }

    if (index == lastIndex) {
      return elements.removeLast();
    }

    _swapValues(index, lastIndex);
    final value = elements.removeLast();

    _siftDown(index);
    _siftUp(index);

    return value;
  }

  //Find Index of Specific element ...
  int indexOf(E value, {int index = 0}) {
    if (index >= elements.length) {
      return -1;
    }

    if (_firstHasHigherPriority(value, elements[index])) {
      return -1;
    }

    if (value == elements[index]) {
      return index;
    }

    final left = indexOf(value, index: _leftChildIndex(index));
    if (left != -1) return left;
    return indexOf(value, index: _rightChildIndex(index));
  }

  // Helper methods ....
  int _leftChildIndex(int parentIndex) {
    return 2 * parentIndex + 1;
  }

  int _rightChildIndex(int parentIndex) {
    return 2 * parentIndex + 2;
  }

  int _parentIndex(int childIndex) {
    return (childIndex - 1) ~/ 2;
  }

  bool _firstHasHigherPriority(E valueA, E valueB) {
    if (priority == Priority.max) {
      return valueA.compareTo(valueB) > 0;
    }
    return valueA.compareTo(valueB) < 0;
  }

  int _higherPriority(int indexA, int indexB) {
    if (indexA >= elements.length) return indexB;
    final valueA = elements[indexA];
    final valueB = elements[indexB];
    final isFirst = _firstHasHigherPriority(valueA, valueB);
    return (isFirst) ? indexA : indexB;
  }

  void _swapValues(int indexA, int indexB) {
    final temp = elements[indexA];
    elements[indexA] = elements[indexB];
    elements[indexB] = temp;
  }

  @override
  String toString() => elements.toString();
}
