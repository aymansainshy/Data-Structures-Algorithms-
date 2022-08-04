import '../6 - Binary-Tree/binary_tree.dart';

void main() {
  final tree = BinarySearchTree<int>();
  final tree2 = buildExampleTree();

  for (var i = 0; i < 5; i++) {
    tree.insert(i);
  }

  print(tree2);
  tree2.remove(1);
  print(tree2);
  // print(tree2.contains(4));
}

BinarySearchTree<int> buildExampleTree() {
  var tree = BinarySearchTree<int>();
  tree.insert(3);
  tree.insert(1);
  tree.insert(4);
  tree.insert(0);
  tree.insert(2);
  tree.insert(5);
  return tree;
}

/*
  A binary search tree, or BST, is a data structure that facilitates fast lookup, insert and removal operations.

  - binary search tree imposes two rules on the binary tree you saw in the previous chapter:

     1. The left subtree of a node contains only nodes with value less than the perent nodes.
     2. The right subtree of a node contains only nodes with value greater or equal than the pernent nodes.

  - As a result, lookup, insert and removal have an average time complexity of O(log n). 
*/

class BinarySearchTree<T extends Comparable<dynamic>> {
  BinaryNode<T>? root;

  void insert(T data) {
    root = _insertAt(root, data);
  }

  BinaryNode<T> _insertAt(BinaryNode<T>? node, T data) {
    if (node == null) {
      return BinaryNode(data);
    }

    if (data.compareTo(node.data) < 0) {
      node.leftChild = _insertAt(node.leftChild, data);
    } else {
      node.rightChild = _insertAt(node.rightChild, data);
    }

    return node;
  }

  // Finding an element in a binary useing Traversal mechanisms ..
  bool containss(T data) {
    if (root == null) return false;
    var found = false;

    root!.traverseInOrder((other) {
      if (data == other) {
        found = true;
      }
    });

    return found;
  }

  bool contains(T data) {
    var current = root;

    while (current != null) {
      if (data == current.data) {
        return true;
      }
      if (data.compareTo(current.data) < 0) {
        current = current.leftChild;
      } else {
        current = current.rightChild;
      }
    }

    return false;
  }

  void remove(T value) {
    root = _remove(root, value);
  }

  BinaryNode<T>? _remove(BinaryNode<T>? node, T data) {
    if (node == null) return null;

    if (data == node.data) {
      // handle the removal cases for (1) a leaf node.
      if (node.leftChild == null && node.rightChild == null) {
        return null;
      }

      // (2) a node with one child.
      if (node.leftChild == null) {
        return node.rightChild;
      }

      // (3) a node with two children.
      if (node.rightChild == null) {
        return node.leftChild;
      }

      // node.data = node.rightChild!.min.data;
      node.data = _findMin(node.rightChild!)!.data;
      node.rightChild = _remove(node.rightChild, node.data);
    } else if (data.compareTo(node.data) < 0) {
      node.leftChild = _remove(node.leftChild, data);
    } else {
      node.rightChild = _remove(node.rightChild, data);
    }

    return node;
  }

  BinaryNode<T>? _findMin(BinaryNode<T>? node) {
    if (node == null) return null;
    if (node.leftChild == null) return node;
    return _findMin(node.leftChild);
  }

  BinaryNode<T>? findMin2(BinaryNode<T>? node) {
    if (node == null) return null;

    BinaryNode<T>? currentNode = node;

    while (currentNode?.leftChild != null) {
      currentNode = currentNode?.leftChild;
    }
    return currentNode;
  }

  BinaryNode<T>? findMax(BinaryNode<T>? node) {
    if (node == null) return null;

    BinaryNode<T>? currentNode = node;

    while (currentNode?.rightChild != null) {
      currentNode = currentNode?.rightChild;
    }
    return currentNode;
  }

  @override
  String toString() => root.toString();
}

extension _MinFinder<T> on BinaryNode<T> {
  BinaryNode<T> get min => leftChild == null ? this : leftChild!.min;
}

/*
  Key Points to remember:

    - The left subtree of a node contains only nodes with value less than the perent nodes.
    - The right subtree of a node contains only nodes with value greater or equal than the pernent nodes.
    - As a result, lookup, insert and removal have an average time complexity of O(log n).

• The binary search tree (BST) is a powerful data structure for holding sorted data.
• Elements of the binary search tree must be comparable. 
  You can achieve this using a generic constraint or by supplying a closure to perform the comparison.
• Performance will degrade to O(n) as the tree becomes unbalanced.
  This is undesirable, but self-balancing trees such as the AVL tree can overcome the problem.
*/

// Binary Tree or Binary Search Tree // O(n) ...........
extension Checker<T extends Comparable<dynamic>> on BinaryNode<T> {
  bool isBinarySearchTree() {
    return _isBST(this, min: null, max: null);
  }

  bool _isBST(BinaryNode<T>? tree, {T? min, T? max}) {
    if (tree == null) return true;

    if (min != null && tree.data.compareTo(min) <= 0) {
      return false;
    } else if (max != null && tree.data.compareTo(max) >= 0) {
      return false;
    }

    return _isBST(tree.leftChild, min: min, max: tree.data) &&
        _isBST(tree.rightChild, min: tree.data, max: max);
  }
}

// Equality : Given two binary trees, how would you test if they are equal or not?
// The time complexity of this function is O(n). The space complexity of this function is also O(n).
bool treesEqual(BinarySearchTree first, BinarySearchTree second) {
  return _isEqual(first.root, second.root);
}

bool _isEqual(BinaryNode? first, BinaryNode? second) {
  if (first == null && second == null) return true;
  if (first == null || second == null) return false;

  return first.data == second.data &&
      _isEqual(first.leftChild, second.leftChild) &&
      _isEqual(first.rightChild, second.rightChild);
}

// Is it a Subtree? Create a method that checks if the current tree contains all the elements of another tree.
// The time and space complexity for this algorithm is O(n).
extension Subtree<T> on BinarySearchTree {
  bool containsSubtree(BinarySearchTree subtree) {
    Set set = <T>{};

    root?.traverseInOrder((node) {
      set.add(node);
    });

    var isEqual = true;

    subtree.root?.traverseInOrder((node) {
      isEqual = isEqual && set.contains(node);
    });

    return isEqual;
  }
}
