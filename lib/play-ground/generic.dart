class Tuple {
  final int? _a;
  final int? _b;
  final int? _c;

  Tuple(this._a, this._b, this._c);

  Tuple.formList(List<int> list)
      : _a = list.asMap().containsKey(0) ? list[0] : null,
        _b = list.asMap().containsKey(0) ? list[1] : null,
        _c = list.asMap().containsKey(0) ? list[2] : null;

  int? get first => _a;
  int? get second => _b;
  int? get third => _c;
} //

void main() {
  final myStream = streamCount(10);

  myStream.listen(
    (event) => print("Data is $event"),
    onError: (errer) => print("Error Occurred "),
    onDone: () => print("Done !"),
  );
}

Stream<int> streamCount(int max) async* {
  for (int i = 0; i <= max; i++) {
    await Future.delayed(const Duration(seconds: 1));
    yield i;
  }
}
