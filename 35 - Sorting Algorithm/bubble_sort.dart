void main() {
  List<int> num = [8, 4, 2, 5, 1, 0];

  print(bubbleSortWhile(num));
}

// Improved bubble Sort ...
List<int> bubbleSort(List<int> list) {
  bool swapped;
  int count = 0;

  for (int i = 0; i < list.length - 1; i++) {
    swapped = false;

    for (int j = 0; j < list.length - i - 1; j++) {
      count++;

      //  Swap ..
      if (list[j] > list[j + 1]) {
        swapp(list, j);
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

// Space Complexty : O(1)

List<int> bubbleSortWhile(List<int> list) {
  bool swapped = true;

  while (swapped) {
    swapped = false;

    for (int k = 0; k < list.length - 1; k++) {
      if (list[k] > list[k + 1]) {
        swapp(list, k);
        swapped = true;
      }
    }

    if (swapped == false) break;
  }

  return list;
}




void swapp(List<int> list, int index) {
  int temp = list[index];
  list[index] = list[index + 1];
  list[index + 1] = temp;
}
