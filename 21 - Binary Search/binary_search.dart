void main() {
  List numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16];

  print(binarySearch(numbers, 13));

  // binarySearch(numbers, 13);
}

int binarySearch(List list, int value) {
  int start = 0;
  int end = list.length - 1;

  int middle = ((start + end) / 2).floor();

  while (list[middle] != value) {
    print("$start ---- $middle ---- $end");
    print("${list[start]} --- ${list[middle]} --- ${list[end]}\n");

    if (value < list[middle]) {
      end = middle - 1;
    } else {
      start = middle + 1;
    }

    middle = ((start + end) / 2).floor();
  }

  return middle;
}
