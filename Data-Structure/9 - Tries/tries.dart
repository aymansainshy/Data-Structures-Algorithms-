void main() {
  final trie = StringTrie();
  trie.insert('cut');
  trie.insert('cute');
  assert(trie.contains('cut'));
  print('"cut" is in the trie');
  assert(trie.contains('cute'));
  print('"cute" is in the trie');
  print('\n--- Removing "cut" ---');
  trie.remove('cut');
  assert(!trie.contains('cut'));
  assert(trie.contains('cute'));
  print('"cute" is still in the trie');

////////////////////////////////////////////
  trie.insert('car');
  trie.insert('card');
  trie.insert('care');
  trie.insert('cared');
  trie.insert('cars');
  trie.insert('carbs');
  trie.insert('carapace');
  trie.insert('cargo');
  print('Collections starting with "car"');
  final prefixedWithCar = trie.matchPrefix('car');
  print(prefixedWithCar);
  print('\nCollections starting with "care"');
  final prefixedWithCare = trie.matchPrefix('care');
  print(prefixedWithCare);
}

/*
  The trie, pronounced “try”, is a tree that specializes in storing data that can be represented as a collection, 
  such as English words
*/

// IMPLEMENTAION :
class TrieNode<T> {
  TrieNode({this.key, this.parent});

  T? key;

  TrieNode<T>? parent;

  Map<T, TrieNode<T>?> children = {};

  bool isTerminating = false;
}

// STRING TRIE
class StringTrie {
  TrieNode<int> root = TrieNode(key: null, parent: null);

  // This for keeping track of all the Strings .
  // but this can make you lose the space complexity that trie gave you.
  final Set<String> _allStrings = {};
  Set<String> get allStrings => _allStrings;

  int get length => _allStrings.length;
  bool get isEmpty => _allStrings.isEmpty;

  /*
    INSERTING ...
    The time complexity for this algorithm is O(k), where k is the number of code units you’re trying to insert.
    This cost is because you need to traverse through or create a new node for each code unit. 
  */
  void insert(String text) {
    var current = root;

    for (var codeUnit in text.codeUnits) {
      current.children[codeUnit] ??= TrieNode(
        key: codeUnit,
        parent: current,
      );

      current = current.children[codeUnit]!;
    }

    current.isTerminating = true;
    _allStrings.add(text);
  }

  /*
    CONTAIN ...
    Like insert, the time complexity of contains is O(k), 
    where k is the length of the string that you’re using for the search. 
    This time complexity comes from traversing through k nodes to determine whether the code unit collection is in the trie.
  */
  bool contains(String text) {
    var current = root;

    for (var codeUnit in text.codeUnits) {
      final child = current.children[codeUnit];

      if (child == null) {
        return false;
      }

      current = child;
    }

    return current.isTerminating;
  }

  /*
   REMOVE ...
   The time complexity of this algorithm is O(k), 
   where k represents the number of code units in the string that you’re trying to remove.
  */
  void remove(String text) {
    var current = root;

    for (final codeUnit in text.codeUnits) {
      final child = current.children[codeUnit];

      if (child == null) {
        return;
      }

      current = child;
    }

    if (!current.isTerminating) {
      return;
    }

    current.isTerminating = false;
    _allStrings.remove(text);

    while (current.parent != null &&
        current.children.isEmpty &&
        !current.isTerminating) {
      current.parent!.children[current.key!] = null;
      current = current.parent!;
    }
  }

  /*
   PREFIX MATCHING ...
   matchPrefix has a time complexity of O(k × m),
    where k represents the longest collection matching the prefix and m represents the number of collections that match the prefix.
    Recall that lists have a time complexity of O(k × n), 
    where n is the number of elements in the entire collection. 
    For large sets of data in which each collection is uniformly distributed,
    tries have far better performance than using lists for prefix matching.
  */
  List<String> matchPrefix(String prefix) {
    var current = root;

    for (final codeUnit in prefix.codeUnits) {
      final child = current.children[codeUnit];

      if (child == null) {
        return [];
      }
      current = child;
    }

    return _moreMatches(prefix, current);
  }

  List<String> _moreMatches(String prefix, TrieNode<int> node) {
    List<String> results = [];

    if (node.isTerminating) {
      results.add(prefix);
    }

    for (final child in node.children.values) {
      final codeUnit = child!.key!;
      results.addAll(
        _moreMatches(
          '$prefix${String.fromCharCode(codeUnit)}',
          child,
        ),
      );
    }
    return results;
  }
}

// generic TRIE ..
class Trie<E, T extends Iterable<E>> {
  TrieNode<E> root = TrieNode(key: null, parent: null);

  void insert(T collection) {
    var current = root;

    for (E element in collection) {
      current.children[element] ??= TrieNode(
        key: element,
        parent: current,
      );
      current = current.children[element]!;
    }
    current.isTerminating = true;
  }
}
