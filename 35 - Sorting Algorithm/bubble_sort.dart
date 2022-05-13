void main() {
  List<int> num = [8, 4, 2, 5, 1, 0];

  print(bubbleSort2(num));
}

List<int> bubbleSort(List<int> list) {
  for (int i = 0; i < list.length; i++) {
    for (int j = 0; j < list.length - 1; j++) {
      if (list[j] > list[j + 1]) {
        //  Swap ..
        int temp = list[j];

        list[j] = list[j + 1];
        list[j + 1] = temp;
      }
    }
  }
  return list;
}

// Improved bubble Sort ...
List<int> bubbleSort2(List<int> list) {
  bool swapped;
  int count = 0;

  for (int i = 0; i < list.length - 1; i++) {
    swapped = false;

    for (int j = 0; j < list.length - i - 1; j++) {
      count++;

      //  Swap ..
      if (list[j] > list[j + 1]) {
        int temp = list[j];
        list[j] = list[j + 1];
        list[j + 1] = temp;
        swapped = true;
      }
    }
    if (swapped == false) break;
  }
  print("Number of iteration : $count");
  return list;
}


// Best case is O(n)
// Worst case is O(n^2)