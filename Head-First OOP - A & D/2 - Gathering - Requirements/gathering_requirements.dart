class DogDoor {
  late bool _open;

  DogDoor({bool open = false}) {
    this._open = open;
  }

  void open() {
    print("The dog door opens. ");
    _open = true;
  }

  void close() {
    print("The dog door closes. ");
    _open = false;
  }

  bool isOpen() {
    return _open;
  }
}
