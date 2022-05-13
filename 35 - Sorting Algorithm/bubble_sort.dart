void main() {
  List<int> num = [8, 4, 5, 2, 1, 0];

  print(bubbleSort(num));
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

  for (int i = list.length; i > 0; i--) {
    swapped = false;
    
    for (int j = 0; j < i - 1; j++) {
      count++;

      //  Swap ..
      if (list[j] > list[j + 1]) {
        int temp = list[j];
        list[j] = list[j + 1];
        list[j + 1] = temp;
        swapped = true;
      }

    }
    if (swapped) break;
  }
  print("Number of iteration : $count");
  return list;
}
