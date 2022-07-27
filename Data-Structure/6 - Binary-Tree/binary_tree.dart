import 'dart:math';

void main() {
  final binaryNode = createBinaryTree();

  // print(binaryNode.toString());
  binaryNode.traverseInOrder((node) {
    print(node.data);
  });
}

BinaryNode<int> createBinaryTree() {
  final zero = BinaryNode(0);
  final one = BinaryNode(1);
  final five = BinaryNode(5);
  final seven = BinaryNode(7);
  final eight = BinaryNode(8);
  final nine = BinaryNode(9);

  seven.leftChild = one;
  seven.rightChild = nine;

  one.leftChild = zero;
  one.rightChild = five;

  nine.leftChild = eight;

  return seven;
}

class BinaryNode<T> {
  BinaryNode(this.data);

  T data;
  BinaryNode<T>? leftChild;
  BinaryNode<T>? rightChild;

  /* In-Order Traversal Algorithm :
  - An in-order traversal visits the nodes of a binary tree in the following order, starting from the root node:
  1. If the current node has a left child, recursively visit this child first.
  2. Then visit the node itself.
  3. If the current node has a right child, recursively visit this child. 
  */
  void traverseInOrder(void Function(BinaryNode<T> node) performAction) {
    if (leftChild != null) {
      leftChild?.traverseInOrder(performAction);
    }

    performAction(this);

    if (rightChild != null) {
      rightChild?.traverseInOrder(performAction);
    }
  }

  /* Pre-Order Traversal algorithm :
     Pre-order traversal always visits the current node first, then recursively visits the left and right child
  */
  void traversePreOrder(void Function(BinaryNode<T> node) performAction) {
    performAction(this);

    if (leftChild != null) {
      leftChild?.traversePreOrder(performAction);
    }

    if (rightChild != null) {
      rightChild?.traversePreOrder(performAction);
    }
  }

  /* Post-Order Traversal algorithm :
     Post-order traversal only visits the current node after the left and right child have been visited recursively.
  */
  void traversePostOrder(void Function(BinaryNode<T> node) performAction) {
    if (leftChild != null) {
      leftChild?.traversePostOrder(performAction);
    }

    if (rightChild != null) {
      rightChild?.traversePostOrder(performAction);
    }

    performAction(this);
  }
  /*
   • traverseInOrder: left → action → right
   • traversePreOrder: action → left → right
   • traversePostOrder: left → right → action

   Each one of these traversal algorithms has a time and space complexity of O(n).
  */

  // This will recursively create a string representing the binary tree.
  @override
  String toString() {
    return _diagram(this);
  }

  String _diagram(BinaryNode<T>? node,
      [String top = '', String root = '', String bottom = '']) {
    if (node == null) {
      return '$root null\n';
    }

    if (node.leftChild == null && node.rightChild == null) {
      return '$root ${node.data}\n';
    }

    final a = _diagram(
      node.rightChild,
      '$top ',
      '$top┌──',
      '$top│ ',
    );

    final b = '$root${node.data}\n';

    final c = _diagram(
      node.leftChild,
      '$bottom│ ',
      '$bottom└──',
      '$bottom ',
    );

    return '$a$b$c';
  }
}

// Height of a Tree :
// Given a binary tree, find the height of the tree.
// The height of the binary tree is determined by the distance between the root and the furthest leaf.
// The height of a binary tree with a single node is zero since the single node is both the root and the furthest leaf.
// A recursive approach for finding the height of a binary tree doesn’t take much code:

// This algorithm has a time complexity of O(n) since you need to traverse through all the nodes.
// This algorithm incurs a space cost of O(n) since you need to make the same n recursive calls to the call stack.
int height(BinaryNode? node) {
  if (node == null) {
    return 0;
  }

  return 1 + max(height(node.leftChild), height(node.rightChild));
}

// Serialization :
// A common task in software development is representing a complex object using another data type.
// This process is known as serialization and allows custom types to be used in systems that only support a closed set of data types. An example of serialization is JSON.
// Your task is to devise a way to serialize a binary tree into a list, and a way to deserialize the list back into the same binary tree.
// This solution will use the pre-order traversal strategy.
extension Serializable<T> on BinaryNode<T> {
  void traversePreOrderWithNull(void Function(T? data) action) {
    action(data);
    if (leftChild == null) {
      action(null);
    } else {
      leftChild!.traversePreOrderWithNull(action);
    }
    if (rightChild == null) {
      action(null);
    } else {
      rightChild!.traversePreOrderWithNull(action);
    }
  }
}

// The time complexity of the serialization step is O(n). Since you’re creating a new list,
// this also incurs an O(n) space cost.
List<T?> serialize<T>(BinaryNode<T>? node) {
  final list = <T?>[];

  node?.traversePreOrderWithNull((data) {
    list.add(data);
  });

  return list;
}

// Deserialization
// However, the time complexity of this function isn’t desirable.
// Since you’re calling removeAt(0) as many times as elements in the list, this algorithm has an O(n2) time complexity.
// Fortunately, there’s an easy way to remedy that.
BinaryNode<T>? deserialize<T>(List<T?> list) {
  if (list.isEmpty) return null;

  final value = list.removeAt(0);
  if (value == null) return null;

  final node = BinaryNode(value);
  node.leftChild = deserialize(list);
  node.rightChild = deserialize(list);

  return node;
}
