void main() {
  // final node1 = Node(data: 1);
  // final node2 = Node(data: 2);
  // final node3 = Node(data: 3);

  // node1.next = node2;
  // node2.next = node3;

  final linkedList = LinkedList<int>();

  linkedList.push(1);
  linkedList.push(4);
  linkedList.push(8);
  linkedList.append(18);
  var currentNode = linkedList.nodeAt(2)!;
  linkedList.insertAfter(currentNode, 30);

  print(linkedList.toString());
  print(linkedList.size.toString());

  linkedList.removeAt(3);
  // linkedList.pop();
  // linkedList.removeAfter(currentNode);
  print(linkedList.toString());
  print(linkedList.size.toString());

  for (var node in linkedList) {
    print(node);
  }

  // print(linkedList.getAt(3));
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////

class Node<T> {
  Node({required this.data, this.next});

  T data;
  Node<T>? next;

  @override
  String toString() {
    if (next == null) return '$data';
    return '$data -> ${next.toString()}';
  }
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////

class LinkedList<T> extends Iterable<T> {
  Node<T>? head;
  Node<T>? tail;
  int size = 0;

  @override
  bool get isEmpty => head == null;

  // Insert First - Push - O(1)
  void push(T data) {
    head = Node(data: data, next: head);
    tail ??= head;
    size++;
  }

  // Insert Last - append - O(1)
  void append(T data) {
    if (isEmpty) {
      push(data);
      return;
    }

    // make the current tail to point to new node
    tail!.next = Node(data: data);

    // change the tail to be the new node
    tail = tail!.next;
    size++;
  }

  // GET data at Index
  T? getAt(int index) {
    var currentNode = head;
    var currentIndex = 0;

    while (currentNode != null) {
      if (currentIndex == index) {
        return currentNode.data;
      }

      currentIndex++;
      currentNode = currentNode.next;
    }

    return null;
  }

  // GET Node At Index
  Node<T>? nodeAt(int index) {
    var currentNode = head;
    var currentIndex = 0;

    while (currentNode!.next != null && currentIndex < index) {
      currentNode = currentNode.next;
      currentIndex++;
    }

    return currentNode;
  }

  // InsertAfter Particular Node - O(1)
  Node<T> insertAfter(Node<T> node, T data) {
    if (tail == node) {
      append(data);
      size++;
      return tail!;
    }

    node.next = Node(data: data, next: node.next);
    size++;
    return node.next!;
  }

  // Pop - Remove node at the front - O(1)
  T? pop() {
    if (isEmpty) return null;

    final data = head?.data;
    head = head?.next;

    if (isEmpty) {
      tail = null;
    }

    size--;

    return data;
  }

  // RemoveLast - Remove Last Node  - O(n)
  T? removeLast() {
    if (isEmpty) return null;

    if (head?.next == null) return pop();

    var current = head;
    while (current!.next != null) {
      current = current.next;
    }

    final data = tail?.data;
    tail = current;
    tail?.next = null;
    size--;

    return data;
  }

  // RemoverAfter - Remove after particular node  - O(1)
  T? removeAfter(Node<T> node) {
    if (isEmpty) return null;

    if (node.next == tail) {
      tail = node;
      size--;
      return tail!.data;
    }

    var removedNode = node.next;
    var data = removedNode?.data;

    node.next = removedNode?.next;
    size--;
    return data;
  }

  // RemoveAt particuler index  - O(n)
  T? removeAt(int index) {
    if (index < 0 || index > size) {
      return null;
    }

    Node<T>? currenNode = head;
    Node<T>? previous;

    var currentIndex = 0;

    T? data = currenNode!.data;

    if (index == 0) {
      pop();
    } else {
      while (currentIndex < index) {
        previous = currenNode;
        currenNode = currenNode?.next;
        currentIndex++;
      }

      previous?.next = currenNode?.next;
      size--;
    }
    return data;
  }

  // Clear all Data
  void clear() {
    head = null;
    size = 0;
  }

  void printNodesRecursively<T>(Node<T>? node) {
    if (node == null) return;

    printNodesRecursively(node.next);

    print(node.data);
  }

  void printListInReverse<T>(LinkedList<T> list) {
    printNodesRecursively(list.head);
  }

  Node<T>? getMiddle<T>(LinkedList<T> list) {
    var slow = list.head;
    var fast = list.head;

    while (fast?.next != null) {
      fast = fast?.next?.next;
      slow = slow?.next;
    }
    
    return slow;
  }


  @override
  String toString() {
    if (isEmpty) return 'Empty list !';
    return head.toString();
  }

  @override
  Iterator<T> get iterator => _LinkedListIterator<T>(this);
}

// Add Iterator to iterate over emlement in linkedList .....
class _LinkedListIterator<T> implements Iterator<T> {
  _LinkedListIterator(LinkedList<T> list) : _list = list;

  final LinkedList<T> _list;
  Node<T>? _currentNode;
  bool _firstPass = true;

  @override
  T get current => _currentNode!.data;

  @override
  bool moveNext() {
    if (_list.isEmpty) return false;

    if (_firstPass) {
      _currentNode = _list.head;
      _firstPass = false;
    } else {
      _currentNode = _currentNode?.next;
    }

    return _currentNode != null;
  }
}
