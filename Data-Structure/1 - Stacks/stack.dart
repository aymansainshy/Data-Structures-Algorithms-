void main() {
  final stack = Stack<int>();

  stack.push(1);
  stack.push(4);
  stack.push(2);
  stack.push(10);
  stack.push(7);
  stack.pop();

  print(stack.peek);

  print(stack);

  List<int> nums = [12, 3, 6, 4];
  final iterableStatck = Stack.of(nums);
  print(iterableStatck);
  iterableStatck.pop();
  print(iterableStatck);
}

// NOTE : However, a Stack’s purpose is to limit the number of ways to access your data.
class Stack<T> {
  Stack() : _storage = <T>[];

  final List<T> _storage;

  void push(T element) => _storage.add(element);

  T pop() => _storage.removeLast();

  // The idea of peek is to look at the top element of the stack without mutating its contents.
  T get peek => _storage.last;

  bool get isEmpty => _storage.isEmpty;

  bool get isNotEmpty => !isEmpty;

  // Creating a Stack From an Iterable ...
  Stack.of(Iterable<T> elements) : _storage = List<T>.of(elements);

  // One of the prime use cases for stacks is to facilitate backtracking.
  // If you push a sequence of values into the stack, sequentially popping the stack will give you the values in reverse order.
  void printInReverse<T>(List<T> list) {
    var stack = Stack<T>();

    for (T value in list) {
      stack.push(value);
    }
    
    while (stack.isNotEmpty) {
      print(stack.pop());
    }
  }

  @override
  String toString() {
    return '--- Top ---\n'
        '${_storage.reversed.join('\n')}'
        '\n-----------';
  }
}
