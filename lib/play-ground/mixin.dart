void main() {
  print(2.add15());
}

extension IntegerIxtension on int {
  int add15() => this + 15;
}

abstract class Animal {
  void breathe() => print("Breathing ...");
}

class Dolphen extends Animal with Swimming {}

class Shark extends Animal with Swimming {}

class Bar extends Animal with Flying {}

class Dove extends Animal with Flying {}

class Dog extends Animal with Swimming {}

mixin Swimming {
  void swim() => print("Swimming ..");
}

mixin Flying {
  void fly() => print("flying ...");
}
