import '../3 - Queues/queue.dart';

void main() {
  final tree = makeBeverageTree();

  // tree.forEachDepthFirst((node) => print(node.data));
  final searchResult1 = tree.search('ginger ale');
  print(searchResult1?.data); // ginger ale
  final searchResult2 = tree.search('water');
  print(searchResult2?.data); // null
}

TreeNode<String> makeBeverageTree() {
  final tree = TreeNode('beverages');
  final hot = TreeNode('hot');
  final cold = TreeNode('cold');
  final tea = TreeNode('tea');
  final coffee = TreeNode('coffee');
  final chocolate = TreeNode('cocoa');
  final blackTea = TreeNode('black');
  final greenTea = TreeNode('green');
  final chaiTea = TreeNode('chai');
  final soda = TreeNode('soda');
  final milk = TreeNode('milk');
  final gingerAle = TreeNode('ginger ale');
  final bitterLemon = TreeNode('bitter lemon');

  tree.add(hot);
  tree.add(cold);

  hot.add(tea);
  hot.add(coffee);
  hot.add(chocolate);

  cold.add(soda);
  cold.add(milk);

  tea.add(blackTea);
  tea.add(greenTea);
  tea.add(chaiTea);

  soda.add(gingerAle);
  soda.add(bitterLemon);

  return tree;
}

/* The tree is a data structure of profound importance. 
   It’s used to tackle many recurring challenges in software development, such as:

• Representing hierarchical relationships.
• Managing sorted data.
• Facilitating fast lookup operations. 

[ Root ]
 - The topmost node in the tree is called the root of the tree. It is the only node that has no parent.
   The root node is the first node in the tree.

[ Leaf ]
 - A node is a leaf if it has no children

[ Branch ]
 - A node is a branch if it has at least one child

[ Tree ]
 - A tree is a data structure that is a collection of nodes.

[ Binary Tree ]
 - A binary tree is a tree that has at most two children for each node.

[ Binary Search Tree ]
 - A binary search tree is a binary tree that is ordered by the value of the nodes.

*/

class TreeNode<T> {
  TreeNode(this.data);

  T data;
  List<TreeNode<T>> children = [];

  void add(TreeNode<T> child) {
    children.add(child);
  }

  // Depth-First Traversal Algorithm
  void forEachDepthFirst(void Function(TreeNode<T> node) preformAction) {
    preformAction(this);

    for (final child in children) {
      child.forEachDepthFirst(preformAction);
    }
  }

  // Level-Order Traversal Algorithm
  void forEachLevelOrder(void Function(TreeNode<T> node) performAction) {
    final queue = QueueStack<TreeNode<T>>();

    performAction(this);
    children.forEach(queue.enqueue);

    var node = queue.dequeue();

    while (node != null) {
      performAction(node);
      node.children.forEach(queue.enqueue);
      node = queue.dequeue();
    }
  }

  // Search for a node in the tree
  TreeNode? search(T data) {
    TreeNode? result;

    forEachLevelOrder((node) { // O(n)
      if (node.data == data) {
        result = node;
      }
    });

    return result;
  }

  // Print a Tree in Level Order
  void printEachLevel<T>(TreeNode<T> tree) {
    final result = StringBuffer();

    var queue = QueueStack<TreeNode<T>>();
    var nodesLeftInCurrentLevel = 0;
    queue.enqueue(tree);

    while (!queue.isEmpty) {
      nodesLeftInCurrentLevel = queue.length;
  
      while (nodesLeftInCurrentLevel > 0) {
        final node = queue.dequeue();
        if (node == null) break;
        result.write('${node.data} ');
        for (var element in node.children) {
          queue.enqueue(element);
        }
        nodesLeftInCurrentLevel -= 1;
      }
   
      result.write('\n');
    }
    print(result);
  }

  // Search
  // TreeNode? search(T value) {
  //   if (data == value) {
  //     return this;
  //   }

  //   for (final child in children) {
  //     final node = child.search(value);
  //     if (node != null) {
  //       return node;
  //     }
  //   }

  //   return null;
  // }
}

class Widget {}

class Padding extends Widget {
  Padding({this.value = 0.0, this.child});
  double value;
  Widget? child;
}

class Text extends Widget {
  Text([this.value = '']);
  String value;
}

class Column extends Widget {
  Column({this.children});
  List<Widget>? children;
}

final column = Column(
  children: [
    Padding(
      value: 12.0,
      child: Text("Hello"),
    ),
    Column(
      children: [
        Text("This is mini Flutter"),
        Text("Buided by AYMAN"),
      ],
    )
  ],
);
