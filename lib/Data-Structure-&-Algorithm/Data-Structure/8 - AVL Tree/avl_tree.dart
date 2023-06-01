import 'dart:math' as math;

// AVL Trees are self-balancing trees.
void main() {
  final tree = AvlTree<int>();
  for (var i = 0; i < 15; i++) {
    tree.insert(i);
  }
  print(tree);
}

class AVLnode<T> {
  AVLnode(this.data);

  T data;
  AVLnode<T>? leftChild;
  AVLnode<T>? rightChild;

  // balance factor.
  int height = 0;
  int get leftHeight => leftChild?.height ?? -1;
  int get rightHeight => rightChild?.height ?? -1;
  int get balanceFactor => leftHeight - rightHeight;

  void traverseInOrder(void Function(T data) action) {
    leftChild?.traverseInOrder(action);
    action(data);
    rightChild?.traverseInOrder(action);
  }

  void traversePreOrder(void Function(T data) action) {
    action(data);
    leftChild?.traversePreOrder(action);
    rightChild?.traversePreOrder(action);
  }

  void traversePostOrder(void Function(T data) action) {
    leftChild?.traversePostOrder(action);
    rightChild?.traversePostOrder(action);
    action(data);
  }

  @override
  String toString() {
    return _diagram(this);
  }

  String _diagram(
    AVLnode<T>? node, [
    String top = '',
    String root = '',
    String bottom = '',
  ]) {
    if (node == null) {
      return '$root null\n';
    }
    if (node.leftChild == null && node.rightChild == null) {
      return '$root ${node.data}\n';
    }
    final a = _diagram(node.rightChild, '$top ', '$top┌──', '$top│ ');
    final b = '$root${node.data}\n';
    final c = _diagram(node.leftChild, '$bottom│ ', '$bottom└──', '$bottom ');
    return '$a$b$c';
  }
}

class AvlTree<E extends Comparable<dynamic>> {
  AVLnode<E>? root;

  void insert(E data) {
    root = _insertAt(root, data);
  }

  AVLnode<E> _insertAt(AVLnode<E>? node, E data) {
    if (node == null) {
      return AVLnode(data);
    }
    if (data.compareTo(node.data) < 0) {
      node.leftChild = _insertAt(node.leftChild, data);
    } else {
      node.rightChild = _insertAt(node.rightChild, data);
    }

    final balancedNode = balanced(node);
    balancedNode.height =
        math.max(balancedNode.leftHeight, balancedNode.rightHeight) + 1;
    return balancedNode;
  }

  void remove(E data) {
    root = _remove(root, data);
  }

  AVLnode<E>? _remove(AVLnode<E>? node, E data) {
    if (node == null) return null;
    if (data == node.data) {
      if (node.leftChild == null && node.rightChild == null) {
        return null;
      }
      if (node.leftChild == null) {
        return node.rightChild;
      }
      if (node.rightChild == null) {
        return node.leftChild;
      }
      node.data = node.rightChild!.min.data;
      node.rightChild = _remove(node.rightChild, node.data);
    } else if (data.compareTo(node.data) < 0) {
      node.leftChild = _remove(node.leftChild, data);
    } else {
      node.rightChild = _remove(node.rightChild, data);
    }

    final balancedNode = balanced(node);
    balancedNode.height = math.max(balancedNode.leftHeight, balancedNode.rightHeight) + 1;
    return balancedNode;
  }

  bool contains(E data) {
    var current = root;
    while (current != null) {
      if (current.data == data) {
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

  /* [ROTATIONS] : 
     The procedures used to balance a binary search tree are known as rotations.
     There are four rotations in total, one for each of the four different ways that a tree can be unbalanced. 
     These are known as left rotation, left-right rotation, right rotation and right-left rotation
  */
  AVLnode<E> leftRotate(AVLnode<E> node) {
    final pivot = node.rightChild!;
    node.rightChild = pivot.leftChild;
    pivot.leftChild = node;

    node.height = math.max(node.leftHeight, node.rightHeight) + 1;
    pivot.height = math.max(pivot.leftHeight, pivot.rightHeight) + 1;

    return pivot;
  }

  AVLnode<E> rightRotate(AVLnode<E> node) {
    final pivot = node.leftChild!;
    node.leftChild = pivot.rightChild;
    pivot.rightChild = node;

    node.height = math.max(node.leftHeight, node.rightHeight) + 1;
    pivot.height = math.max(pivot.leftHeight, pivot.rightHeight) + 1;

    return pivot;
  }

  AVLnode<E> leftRightRotate(AVLnode<E> node) {
    if (node.leftChild == null) {
      return node;
    }
    node.leftChild = leftRotate(node.leftChild!);
    return rightRotate(node);
  }

  AVLnode<E> rightLeftRotate(AVLnode<E> node) {
    if (node.rightChild == null) {
      return node;
    }
    node.rightChild = rightRotate(node.rightChild!);
    return leftRotate(node);
  }

  AVLnode<E> balanced(AVLnode<E> node) {
    switch (node.balanceFactor) {
      case 2:
        final AVLnode left = node.leftChild!;
        if (left.balanceFactor == -1) {
          return leftRightRotate(node);
        } else {
          return rightRotate(node);
        }

      case -2:
        final AVLnode right = node.rightChild!;
        if (right.balanceFactor == 1) {
          return rightLeftRotate(node);
        } else {
          return leftRotate(node);
        }

      default:
        return node;
    }
  }

  @override
  String toString() => root.toString();
}

extension _MinFinder<E> on AVLnode<E> {
  AVLnode<E> get min => leftChild?.min ?? this;
}

/*
  Key Points
• A self-balancing tree avoids performance degradation by performing a balancing procedure whenever you add or remove elements in the tree.
• AVL trees preserve balance by readjusting parts of the tree when the tree is no longer balanced.
• Balance is achieved by four types of tree rotations on node insertion and removal: right rotation,
  left rotation, right-left rotation and left-right rotation.
*/ 