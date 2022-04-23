void main() {
  List numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16];

  print(binarySearch2(numbers, 0, numbers.length - 1, 13));

  // binarySearch(numbers, 13);
}

int binarySearch(List list, int value) {
  int start = 0;
  int end = list.length - 1;

  int middle = ((start + end) / 2).floor();

  while (list[middle] != value && start <= end) {

    if (value < list[middle]) {
      end = middle - 1;
    } else {
      start = middle + 1;
    }

    middle = ((start + end) / 2).floor();
  }

  if (list[middle] == value) return middle;

  return -1;
}



// Recursive Binary Search ..................
int binarySearch2(List list, int start, int end, int value) {

  if (end >= start) {
    int mid = ((start + end) / 2).floor();

    if (list[mid] == value) return mid;

    if (list[mid] > value) return binarySearch2(list, start, mid - 1, value);

    return binarySearch2(list, mid + 1, end, value);
  }

  return -1;
}



// print("$start ---- $middle ---- $end");
// print("${list[start]} --- ${list[middle]} --- ${list[end]}\n");