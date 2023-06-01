import '../../Data-Structure/11 - Priority Queues/priority_queues.dart';
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

  graph.addEdge(a, b, weight: 8, edgeType: EdgeType.directed);
  graph.addEdge(a, f, weight: 9, edgeType: EdgeType.directed);
  graph.addEdge(a, g, weight: 1, edgeType: EdgeType.directed);
  graph.addEdge(g, c, weight: 3, edgeType: EdgeType.directed);
  graph.addEdge(c, b, weight: 3, edgeType: EdgeType.directed);
  graph.addEdge(c, e, weight: 1, edgeType: EdgeType.directed);
  graph.addEdge(e, b, weight: 1, edgeType: EdgeType.directed);
  graph.addEdge(e, d, weight: 2, edgeType: EdgeType.directed);
  graph.addEdge(b, e, weight: 1, edgeType: EdgeType.directed);
  graph.addEdge(b, f, weight: 3, edgeType: EdgeType.directed);
  graph.addEdge(f, a, weight: 2, edgeType: EdgeType.directed);
  graph.addEdge(h, g, weight: 5, edgeType: EdgeType.directed);
  graph.addEdge(h, f, weight: 2, edgeType: EdgeType.directed);

  final dijkstra = Dijkstra(graph);

  final allPaths = dijkstra.shortestPaths(a);
  print(allPaths);

  final path = dijkstra.shortestPath(b, a);
  print(path);

  print(dijkstra.shortestPathsLists(a));
}

/*
   Dijkstra’s algorithm : 
    - is particularly useful in GPS networks to help find the shortest path between two locations.
    - Dijkstra’s algorithm is known as a greedy algorithm. 

  Some applications of Dijkstra’s algorithm include:
   1. Communicable disease transmission: Discovering where biological diseases are spreading the fastest.
   2. Telephone networks: Routing calls to the highest-bandwidth paths available in the network.
   3. Mapping: Finding the shortest and fastest paths for travelers.

  
  Key Points
   • Dijkstra’s algorithm finds the shortest path from a starting vertex to the rest of the vertices in a graph.
   • The algorithm is greedy, meaning it chooses the shortest path at each step.
   • The priority queue data structure helps to efficiently return the vertex with the shortest path. 
*/

class Pair<T> extends Comparable<Pair<T>> {
  Pair(this.distance, [this.vertex]);

  double distance;
  Vertex<T>? vertex;

  @override
  int compareTo(Pair<T> other) {
    if (distance == other.distance) return 0;
    if (distance > other.distance) return 1;
    return -1;
  }

  @override
  String toString() => '($distance,$vertex)';
}

class Dijkstra<E> {
  Dijkstra(this.graph);

  final Graph<E> graph;

  Map<Vertex<E>, Pair<E>?> shortestPaths(Vertex<E> source) {
    final queue = PriorityQueue<Pair<E>>(priority: Priority.min);
    final visited = <Vertex<E>>{};
    final paths = <Vertex<E>, Pair<E>?>{};

    for (final vertex in graph.vertices) {
      paths[vertex] = null;
    }

    queue.enqueue(Pair(0, source));
    paths[source] = Pair(0);
    visited.add(source);

    while (!queue.isEmpty) {
      final current = queue.dequeue()!;

      final savedDistance = paths[current.vertex]!.distance;
      if (current.distance > savedDistance) continue;

      visited.add(current.vertex!);

      for (final edge in graph.edges(current.vertex!)) {
        final neighbor = edge.destination;

        if (visited.contains(neighbor)) continue;

        final weight = edge.weight ?? double.infinity;
        final totalDistance = current.distance + weight;

        final knownDistance = paths[neighbor]?.distance ?? double.infinity;

        if (totalDistance < knownDistance) {
          paths[neighbor] = Pair(totalDistance, current.vertex);
          queue.enqueue(Pair(totalDistance, neighbor));
        }
      }
    }

    return paths;
  }

  List<Vertex<E>> shortestPath(
    Vertex<E> source,
    Vertex<E> destination, {
    Map<Vertex<E>, Pair<E>?>? paths,
  }) {
    final allPaths = paths ?? shortestPaths(source);

    if (!allPaths.containsKey(destination)) return [];

    var current = destination;
    final path = <Vertex<E>>[current];

    while (current != source) {
      final previous = allPaths[current]?.vertex;
      if (previous == null) return [];
      path.add(previous);
      current = previous;
    }

    return path.reversed.toList();
  }
}

extension ShortestPaths<E> on Dijkstra<E> {
  Map<Vertex<E>, List<Vertex<E>>> shortestPathsLists(Vertex<E> source) {
    final allPathsLists = <Vertex<E>, List<Vertex<E>>>{};

    final allPaths = shortestPaths(source);

    for (final vertex in graph.vertices) {
      final path = shortestPath(source, vertex, paths: allPaths);

      allPathsLists[vertex] = path;
    }

    return allPathsLists;
  }
}
