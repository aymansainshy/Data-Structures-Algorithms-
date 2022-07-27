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
  // O(1)
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

/*
  To check if there are balanced parentheses in the string, you need to go through each character of the string. 
  When you encounter an opening parenthesis, you’ll push that onto a stack. 
  Conversely, if you encounter a closing parenthesis, you should pop the stack.
 */

bool checkParentheses(String text) {
  var stack = Stack<int>();

  final open = '('.codeUnitAt(0);
  final close = ')'.codeUnitAt(0);

  for (int codeUnit in text.codeUnits) {
    if (codeUnit == open) {
      stack.push(codeUnit);
    } else if (codeUnit == close) {
      if (stack.isEmpty) {
        return false;
      } else {
        stack.pop();
      }
    }
  }
  return stack.isEmpty;
}

bool checkParentheses2(String text) {
  final List<String> parentheses = ['(', ')', '[', ']', '{', '}'];

  var stack = Stack<int>();

  for (int i = 0; i < text.length; i++) {
    final char = text[i];
    if (parentheses.contains(char)) {
      if (char == '(' || char == '[' || char == '{') {
        stack.push(parentheses.indexOf(char));
      } else {
        if (stack.isEmpty) {
          return false;
        } else {
          final top = stack.pop();
          if (top != parentheses.indexOf(char)) {
            return false;
          }
        }
      }
    }
  }
  return stack.isEmpty;
}

class Book {
  final String title;
  final String author;

  Book(this.title, this.author);
}

class StackOfBooks {
  final List<Book> _books = [];

  void push(Book book) {
    _books.add(book);
  }

  Book pop() {
    return _books.removeLast();
  }

  Book peek() {
    return _books.last;
  }

  bool get isEmpty => _books.isEmpty;
}
