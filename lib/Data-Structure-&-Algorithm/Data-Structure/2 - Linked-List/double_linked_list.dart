/// Represents the elements that make up the [DoubleLinkedList].
/// A [Node] can be either an *end* node, i.e. virtual nodes at the beginning and end of the [DoubleLinkedList]
/// that don't contain any value, or an *inner* node, that do contain a value.
class Node<T> {
  /// Reference to the [DoubleLinkedList] this [Node] belongs to
  final DoubleLinkedList<T> list;
  T? _content;
  late Node<T> _previous;
  late Node<T> _next;
  final bool _isEnd;

  /// Reference to the previous [Node] in the [DoubleLinkedList]
  Node<T> get previous => _previous;

  /// Reference to the next [Node] in the [DoubleLinkedList]
  Node<T> get next => _next;

  /// Value of the [Node], if [this] is an *end* node (i.e. the begin or end node),
  /// calling [content] throws an [LinkedListException.endNoContent]
  T get content {
    if (_isEnd) throw LinkedListException.endNoContent();
    return _content as T;
  }

  /// Whether [this] is the begin node
  bool get isBegin => _previous == this;

  /// Whether [this] is the end node
  bool get isEnd => _next == this;

  /// Whether [this] is the first node
  bool get isFirst => !isBegin && _previous == list.begin;

  /// Whether [this] is the last node
  bool get isLast => !isEnd && _next == list.end;

  /// Creates a new [Node] containing the value [element] right before [this] in [list]
  Node<T> insertBefore(T element) {
    if (isBegin) throw LinkedListException.cannotInsertBeforeBegin();
    final newNode = Node._(list, element, previous: _previous, next: this);
    _previous._next = newNode;
    _previous = newNode;
    list._length++;
    return newNode;
  }

  /// Creates a new [Node] containing the value [element] right after [this] in [list]
  Node<T> insertAfter(T element) {
    if (isEnd) throw LinkedListException.cannotInsertAfterEnd();
    final newNode = Node._(list, element, previous: this, next: _next);
    _next._previous = newNode;
    _next = newNode;
    list._length++;
    return newNode;
  }

  /// Removes [this] from [list]
  Node<T> remove() {
    if (_isEnd) throw LinkedListException.cannotRemoveEnd();
    _next._previous = _previous;
    _previous._next = _next;
    list._length--;
    return next;
  }

  Node._(this.list, this._content, {Node<T>? previous, Node<T>? next})
      : _isEnd = false {
    _previous = previous ?? this;
    _next = next ?? this;
  }

  Node._end(this.list) : _isEnd = true {
    _next = this;
  }

  Node._begin(this.list) : _isEnd = true {
    _previous = this;
  }

  @override
  String toString() => '($content)';
}

/// Generic double-linked list data structure
class DoubleLinkedList<E> {
  int _length = 0;
  late final Node<E> begin;
  late final Node<E> end;

  /// Get the first inner node of [this].
  /// If [this] is empty, then returns the [end] node.
  Node<E> get first => begin.next;

  /// Get the last inner node of [this].
  /// If [this] is empty, then returns the [begin] node.
  Node<E> get last => end.previous;

  /// Whether [this] is empty.
  bool get isEmpty => _length == 0;

  /// Whether [this] is not empty.
  bool get isNotEmpty => !isEmpty;

  /// Get the number of elements in [this].
  int get length => _length;

  /// Get a lazy iterable with all the elements in [this].
  Iterable<E> get content sync* {
    for (var node = first; node != end; node = node.next) {
      yield node.content;
    }
  }

  void _initialize() {
    _length = 0;
    begin = Node._begin(this);
    end = Node._end(this);
    begin._next = end;
    end._previous = begin;
  }

  /// Creates an empty [DoubleLinkedList]
  DoubleLinkedList.empty() {
    _initialize();
  }

  /// Creates a new [DoubleLinkedList] with the contents of the passed [Iterable].
  /// Note that this does not perform a deep copy.
  DoubleLinkedList.fromIterable(Iterable<E> contents) {
    _initialize();
    Node<E> previousNode = begin;
    for (final element in contents) {
      previousNode = previousNode.insertAfter(element);
    }
  }

  /// Creates a new [DoubleLinkedList] with the contents of the passed [DoubleLinkedList].
  /// Note that this does not perform a deep copy.
  DoubleLinkedList.from(DoubleLinkedList<E> from)
      : this.fromIterable(from.content);

  /// Creates a new [DoubleLinkedList] with the contents of [this].
  /// Note that this does not perform a deep copy.
  DoubleLinkedList<E> copy() => DoubleLinkedList.from(this);

  /// Creates a new [DoubleLinkedList] with the contents of the [this], applying [transform] to each element.
  /// Note that this does not perform a deep copy.
  /// For an in-place transformation, see [DoubleLinkedList.apply].
  DoubleLinkedList<T> map<T>(T Function(E element) transform) =>
      DoubleLinkedList.fromIterable(content.map(transform));

  /// Calls [function] with each element of [this].
  void forEach(void Function(E element) function) => content.forEach(function);

  /// Transforms each element of [this] by applying [transform] to each of them.
  /// For an out-of-place transformation, see [DoubleLinkedList.map].
  void apply(E Function(E element) transform) {
    for (var node = first; node != end; node = node.next) {
      node._content = transform(node.content);
    }
  }

  /// Returns a new [DoubleLinkedList] with only the elements of [this] that satisfy [test].
  DoubleLinkedList<E> where<T>(bool Function(E element) test) =>
      DoubleLinkedList.fromIterable(content.where(test));

  /// Checks whether [this] contains [element].
  bool contains(E element) => content.contains(element);

  /// Reduces [this] to a single value by iteratively combining its elements using [combine].
  /// If [this] is empty, then a [LinkedListException.noElement] is thrown.
  /// If [this] has only one element, it is returned.
  E reduce(E Function(E value, E element) combine) {
    if (isEmpty) throw LinkedListException.noElement();
    return content.reduce(combine);
  }

  /// Reduces [this] to a single value by iteratively combining each element with an existing value.
  /// Uses [initialValue] as the initial value, then iterates through the
  /// elements and updates the value with each element using the [combine] function.
  T fold<T>(T initialValue, T Function(T value, E element) combine) =>
      content.fold(initialValue, combine);

  /// Returns a [List] with the contents of [this]
  List<E> toList() => content.toList();

  /// Returns a [Set] with the contents of [this]
  Set<E> toSet() => content.toSet();

  /// Checks whether any element in [this] satisfies [test]
  bool any(bool Function(E element) test) => content.any(test);

  /// Checks whether every element in [this] satisfies [test]
  bool every(bool Function(E element) test) => content.every(test);

  /// Returns the first [Node] whose value satisfies [test].
  Node<E> firstWhere(bool Function(E element) test, {bool orEnd = false}) {
    /// If no such element exists, it throws [LinkedListException.noElement] if [orEnd] is false, or [end] otherwise.
    /// Returns the first [Node] whose value satisfies [test].
    /// If no such element exists, it throws [LinkedListException.noElement] if [orEnd] is false, or [end] otherwise.
    for (var node = first; node != end; node = node.next) {
      if (test(node.content)) return node;
    }
    if (orEnd) return end;
    throw LinkedListException.noElement();
  }

  /// Returns the last [Node] whose value satisfies [test].
  /// If no such element exists, it throws [LinkedListException.noElement] if [orBegin] is false, or [begin] otherwise.
  Node<E> lastWhere(bool Function(E element) test, {bool orBegin = false}) {
    for (var node = last; node != begin; node = node.previous) {
      if (test(node.content)) return node;
    }
    if (orBegin) return begin;
    throw LinkedListException.noElement();
  }

  @override
  String toString() => '[${content.join(' | ')}]';
}

// extends Equatable
class LinkedListException {
  final String message;

  @override
  List<Object> get props => [message];

  LinkedListException._(this.message);

  /// Represents error that occurs when trying to select an element that doesn't exists.
  /// For example, trying to use [DoubleLinkedList.reduce] with an empty list
  LinkedListException.noElement() : this._('No element');

  /// Represents error that occurs when trying to remove a begin or end node
  LinkedListException.cannotRemoveEnd()
      : this._('An end node cannot be removed');

  /// Represents error that occurs when trying to access the content of an end node
  LinkedListException.endNoContent() : this._('End node has no content');

  /// Represents error that occurs when trying to insert a node before the begin node
  LinkedListException.cannotInsertBeforeBegin()
      : this._('A node cannot be inserted before begin node');

  /// Represents error that occurs when trying to insert a node after the end node
  LinkedListException.cannotInsertAfterEnd()
      : this._('A node cannot be inserted after end node');
}

extension IterableToDoubleLinkedList<T> on Iterable<T> {
  /// Returns a new [DoubleLinkedList] from [this]
  DoubleLinkedList<T> toDoubleLinkedList() =>
      DoubleLinkedList.fromIterable(this);
}
