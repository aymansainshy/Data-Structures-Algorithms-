import '../../Data-Structure/1 - Stacks/stack.dart';
import '../../Data-Structure/12 - Graph/grahp.dart';

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
  graph.addEdge(c, g, weight: 1);
  graph.addEdge(e, f, weight: 1);
  graph.addEdge(e, h, weight: 1);
  graph.addEdge(f, g, weight: 1);
  graph.addEdge(f, c, weight: 1);

  final vertices = graph.depthFirstSearch(a);
  vertices.forEach(print);

  // final vertices = graph.dfs(a);
  // vertices.forEach(print);

  // final graph = AdjacencyList<String>();

  // final a = graph.createVertex('A');
  // final b = graph.createVertex('B');
  // final c = graph.createVertex('C');
  // final d = graph.createVertex('D');

  // graph.addEdge(a, b, edgeType: EdgeType.directed);
  // graph.addEdge(a, c, edgeType: EdgeType.directed);
  // graph.addEdge(c, a, edgeType: EdgeType.directed);
  // graph.addEdge(b, c, edgeType: EdgeType.directed);
  // graph.addEdge(c, d, edgeType: EdgeType.directed);

  print(graph);
  print(graph.hasCycle(a));
}

/* 
 There are a lot of applications for DFS:
   • Topological sorting.
   • Detecting a cycle.
   • Pathfinding, such as in maze puzzles.
   • Finding connected components in a sparse graph.

 To perform a DFS, you start with a given source vertex and attempt to explore a branch as far as possible until you reach the end. 

   - DFS will visit every single vertex at least once.
      This process has a time complexity of O(V + E).
   - The space complexity of depth-first search is O(V) since you have to store all the
      vertices in three separate data structures: stack, pushed and visited.

Key Points
 • Depth-first search (DFS) is another algorithm to traverse or search a graph.
 • DFS explores a branch as far as possible before backtracking to the next branch.
 • The stack data structure allows you to backtrack.
 • A graph is said to have a cycle when a path of edges and vertices leads back to the source vertex.
*/

extension DepthFirstSearch<E> on Graph<E> {
  List<Vertex<E>> depthFirstSearch(Vertex<E> source) {
    final stack = Stack<Vertex<E>>();
    final pushed = <Vertex<E>>{}; // Using Set ensures fast O(1) lookup.
    final visited = <Vertex<E>>[];

    stack.push(source);
    pushed.add(source);
    visited.add(source);

    outerLoop:
    while (stack.isNotEmpty) {
      final vertex = stack.peek;
      final neighbors = edges(vertex);

      for (final edge in neighbors) {
        if (!pushed.contains(edge.destination)) {
          stack.push(edge.destination);
          pushed.add(edge.destination);
          visited.add(edge.destination);

          continue outerLoop;
        }
      }
      stack.pop();
    }

    return visited;
  }
}

extension RecursiveDfs<E> on Graph<E> {
  List<Vertex<E>> dfs(Vertex<E> start) {
    List<Vertex<E>> visited = [];
    Set<Vertex<E>> pushed = {};
    _dfs(start, visited, pushed);
    return visited;
  }

  // helper method
  void _dfs(
    Vertex<E> source,
    List<Vertex<E>> visited,
    Set<Vertex<E>> pushed,
  ) {
    pushed.add(source);
    visited.add(source);

    final neighbors = edges(source);
    for (final edge in neighbors) {
      if (!pushed.contains(edge.destination)) {
        _dfs(edge.destination, visited, pushed);
      }
    }
  }
}

// Checking for Cycles .... The time complexity is O(V + E).
extension CyclicGraph<E> on Graph<E> {
  bool hasCycle(Vertex<E> source) {
    Set<Vertex<E>> pushed = {};
    return _hasCycle(source, pushed);
  }

  // Helper Method
  bool _hasCycle(Vertex<E> source, Set<Vertex<E>> pushed) {
    pushed.add(source);

    final neighbors = edges(source);

    for (final edge in neighbors) {
      if (!pushed.contains(edge.destination)) {
        if (_hasCycle(edge.destination, pushed)) {
          return true;
        }
      } else {
        return true;
      }
    }

    pushed.remove(source);
    return false;
  }
}
