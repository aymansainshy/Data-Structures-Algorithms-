void main() {
  // final graph = AdjacencyList<String>();
  final graph = AdjacencyMatrix<String>();

  final singapore = graph.createVertex('Singapore');
  final tokyo = graph.createVertex('Tokyo');
  final hongKong = graph.createVertex('Hong Kong');
  final detroit = graph.createVertex('Detroit');
  final sanFrancisco = graph.createVertex('San Francisco');
  final washingtonDC = graph.createVertex('Washington DC');
  final austinTexas = graph.createVertex('Austin Texas');
  final seattle = graph.createVertex('Seattle');

  graph.addEdge(singapore, hongKong, weight: 300);
  graph.addEdge(singapore, tokyo, weight: 500);
  graph.addEdge(hongKong, tokyo, weight: 250);
  graph.addEdge(tokyo, detroit, weight: 450);
  graph.addEdge(tokyo, washingtonDC, weight: 300);
  graph.addEdge(hongKong, sanFrancisco, weight: 600);
  graph.addEdge(detroit, austinTexas, weight: 50);
  graph.addEdge(austinTexas, washingtonDC, weight: 292);
  graph.addEdge(sanFrancisco, washingtonDC, weight: 337);
  graph.addEdge(washingtonDC, seattle, weight: 277);
  graph.addEdge(sanFrancisco, seattle, weight: 218);
  graph.addEdge(austinTexas, sanFrancisco, weight: 297);

  print(graph);

  final cost = graph.weight(singapore, tokyo)?.toInt();
  print('It costs \$$cost to fly from Singapore to Tokyo.');

  print('San Francisco Outgoing Flights: ');
  print('-------------------------------- ');
  for (final edge in graph.edges(sanFrancisco)) {
    print('${edge.source} to ${edge.destination}');
  }

  ////////////////////////////////////////////////////
  // final graph = AdjacencyList<String>();
  final megan = graph.createVertex('Megan');
  final sandra = graph.createVertex('Sandra');
  final pablo = graph.createVertex('Pablo');
  final edith = graph.createVertex('Edith');
  final ray = graph.createVertex('Ray');
  final luke = graph.createVertex('Luke');
  final manda = graph.createVertex('Manda');
  final vicki = graph.createVertex('Vicki');
  
  graph.addEdge(megan, sandra, weight: 1);
  graph.addEdge(megan, pablo, weight: 1);
  graph.addEdge(megan, edith, weight: 1);
  graph.addEdge(pablo, ray, weight: 1);
  graph.addEdge(pablo, luke, weight: 1);
  graph.addEdge(edith, manda, weight: 1);
  graph.addEdge(edith, vicki, weight: 1);
  graph.addEdge(manda, pablo, weight: 1);
  graph.addEdge(manda, megan, weight: 1);

  print(graph);

  final megansFriends = Set.of(
    graph.edges(megan).map((edge) {
      return edge.destination.data;
    }),
  );

  final pablosFriends = Set.of(
    graph.edges(pablo).map((edge) {
      return edge.destination.data;
    }),
  );

  final mutualFriends = megansFriends.intersection(pablosFriends);

  print(mutualFriends);
}

// Defining a Vertex  ...
class Vertex<T> {
  const Vertex({
    required this.index,
    required this.data,
  });

  final int index;
  final T data;

  @override
  String toString() => data.toString();
}

// Defining an Edge ...
// To connect two vertices, there must be an edge between them.
class Edge<T> {
  Edge(
    this.source,
    this.destination, [
    this.weight,
  ]);

  final Vertex<T> source;
  final Vertex<T> destination;
  final double? weight;
}

// Defining a Graph Interface
enum EdgeType { directed, undirected }

abstract class Graph<E> {
  // Returns all of the vertices in the graph.
  Iterable<Vertex<E>> get vertices;

  // Creates a vertex and adds it to the graph.
  Vertex<E> createVertex(E data);

  // Connects two vertices in the graph with either a directed or undirected edge. The weight is optional.
  void addEdge(
    Vertex<E> source,
    Vertex<E> destination, {
    EdgeType edgeType,
    double? weight,
  });

  // Returns a list of outgoing edges from a specific vertex.
  List<Edge<E>> edges(Vertex<E> source);

  // Returns the weight of the edge between two vertices.
  double? weight(
    Vertex<E> source,
    Vertex<E> destination,
  );
}

// 1 - Adjacency List Implementation
class AdjacencyList<E> implements Graph<E> {
  final Map<Vertex<E>, List<Edge<E>>> _connections = {};
  var _nextIndex = 0;

  @override
  Iterable<Vertex<E>> get vertices => _connections.keys;

  @override
  Vertex<E> createVertex(E data) {
    final vertex = Vertex(index: _nextIndex, data: data);

    _nextIndex++;

    _connections[vertex] = [];
    return vertex;
  }

  @override
  void addEdge(
    Vertex<E> source,
    Vertex<E> destination, {
    EdgeType edgeType = EdgeType.undirected,
    double? weight,
  }) {
    _connections[source]?.add(Edge(source, destination, weight));

    if (edgeType == EdgeType.undirected) {
      _connections[destination]?.add(Edge(destination, source, weight));
    }
  }

  @override
  List<Edge<E>> edges(Vertex<E> source) {
    return _connections[source] ?? [];
  }

  @override
  double? weight(Vertex<E> source, Vertex<E> destination) {
    final match = edges(source).where((edge) {
      return edge.destination == destination;
    });

    if (match.isEmpty) return null;

    return match.first.weight;
  }

  @override
  String toString() {
    final result = StringBuffer();

    _connections.forEach((vertex, edges) {
      final destinations = edges.map((edge) {
        return edge.destination;
      }).join(', ');

      result.writeln('$vertex --> $destinations');
    });
    return result.toString();
  }
}

// 2 - Adjacency Matrix Implementation
class AdjacencyMatrix<E> implements Graph<E> {
  final List<Vertex<E>> _vertices = [];
  final List<List<double?>?> _weights = [];
  var _nextIndex = 0;

  @override
  Iterable<Vertex<E>> get vertices => _vertices;

  @override
  Vertex<E> createVertex(E data) {
    final vertex = Vertex(index: _nextIndex, data: data);

    _nextIndex++;
    _vertices.add(vertex);

    for (var i = 0; i < _weights.length; i++) {
      _weights[i]?.add(null);
    }

    final row = List<double?>.filled(_vertices.length, null, growable: true);

    _weights.add(row);

    return vertex;
  }

  @override
  void addEdge(
    Vertex<E> source,
    Vertex<E> destination, {
    EdgeType edgeType = EdgeType.undirected,
    double? weight,
  }) {
    _weights[source.index]?[destination.index] = weight;

    if (edgeType == EdgeType.undirected) {
      _weights[destination.index]?[source.index] = weight;
    }
  }

  @override
  List<Edge<E>> edges(Vertex<E> source) {
    List<Edge<E>> edges = [];

    for (var column = 0; column < _weights.length; column++) {
      final weight = _weights[source.index]?[column];

      if (weight == null) continue;

      final destination = _vertices[column];
      edges.add(Edge(source, destination, weight));
    }
    return edges;
  }

  @override
  double? weight(Vertex<E> source, Vertex<E> destination) {
    return _weights[source.index]?[destination.index];
  }

  @override
  String toString() {
    final output = StringBuffer();

    for (final vertex in _vertices) {
      output.writeln('${vertex.index}: ${vertex.data}');
    }

    for (int i = 0; i < _weights.length; i++) {
      for (int j = 0; j < _weights.length; j++) {
        final value = (_weights[i]?[j] ?? '.').toString();
        output.write(value.padRight(6));
      }
      output.writeln();
    }
    return output.toString();
  }
}
