
import '../../Data-Structure/12 - Graph/grahp.dart';
import '../../Data-Structure/3 - Queues/queue.dart';

void main() {
  final graph = AdjacencyList<String>();

  final a = graph.createVertex('A');
  final b = graph.createVertex('B');
  final c = graph.createVertex('C');
  final d = graph.createVertex('D');
  final e = graph.createVertex('E');
  final f = graph.createVertex('F');
  final g = graph.createVertex('G');
  final h = graph.createVertex('H');

  graph.addEdge(a, b, weight: 1);
  graph.addEdge(a, c, weight: 1);
  graph.addEdge(a, d, weight: 1);
  graph.addEdge(b, e, weight: 1);
  graph.addEdge(c, f, weight: 1);
  graph.addEdge(c, g, weight: 1);
  graph.addEdge(e, h, weight: 1);
  graph.addEdge(e, f, weight: 1);
  graph.addEdge(f, g, weight: 1);

  final vertices = graph.breadthFirstSearch(b);
  vertices.forEach(print);
}

/*
Breadth-first search (BFS) algorithm.
  - The BFS algorithm visits the closest vertices from the starting vertex before moving on to further vertices.

BFS can be used to solve a wide variety of problems:
  1. Generating a minimum-spanning tree.
  2. Finding potential paths between vertices.
  3. Finding the shortest path between two vertices.

*/

extension BreadthFirstSearch<E> on Graph<E> {
  List<Vertex<E>> breadthFirstSearch(Vertex<E> source) {
    final queue = QueueStack<Vertex<E>>();

    Set<Vertex<E>> enqueued = {};
    List<Vertex<E>> visited = [];

    // queue keeps track of the neighboring vertices to visit next.
    queue.enqueue(source);
    // enqueued remembers which vertices have been enqueued before, so you don’t enqueue the same vertex twice.
    enqueued.add(source);

    while (true) {
      final vertex = queue.dequeue();
      if (vertex == null) break;

      visited.add((vertex));

      final neighborEdges = edges(vertex);

      for (final edge in neighborEdges) {
        if (!enqueued.contains(edge.destination)) {
          queue.enqueue(edge.destination);
          enqueued.add(edge.destination);
        }
      }
    }

    return visited;
  }
}

/* 
Performance :
  When traversing a graph using BFS, each vertex is enqueued once.
  This process has a time complexity of O(V). During this traversal, you also visit all the edges.
  The time it takes to visit all edges is O(E). 
  Adding the two together means that the overall time complexity for breadth-first search is O(V + E).
  The space complexity of BFS is O(V) since you have to store the vertices in three separate structures: 
    queue, enqueued and visited.
*/

// Recursive BFS
extension RecursiveBFS<E> on Graph<E> {
  List<Vertex<E>> bfs(Vertex<E> source) {
    final queue = QueueStack<Vertex<E>>();
    final Set<Vertex<E>> enqueued = {};
    List<Vertex<E>> visited = [];

    queue.enqueue(source);
    enqueued.add(source);

    _bfs(queue, enqueued, visited);
    return visited;
  }

  // Recursive Helper method
  void _bfs(
    QueueStack<Vertex<E>> queue,
    Set<Vertex<E>> enqueued,
    List<Vertex<E>> visited,
  ) {
    final vertex = queue.dequeue();

    if (vertex == null) return;

    visited.add(vertex);
    final neighborEdges = edges(vertex);

    for (final edge in neighborEdges) {
      if (!enqueued.contains(edge.destination)) {
        queue.enqueue(edge.destination);
        enqueued.add(edge.destination);
      }
    }

    _bfs(queue, enqueued, visited);
  }
}

// Check if Graph is Connected or NOT
extension Connected<E> on Graph<E> {
  bool isConnected() {
    if (vertices.isEmpty) return true;

    final visited = breadthFirstSearch(vertices.first);

    for (final vertex in vertices) {
      if (!visited.contains(vertex)) {
        return false;
      }
    }
    return true;
  }
}
