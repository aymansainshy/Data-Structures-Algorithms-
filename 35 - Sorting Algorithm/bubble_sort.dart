void main() {
  List<int> num = [8, 4, 2, 5, 1, 0];

  print(bubbleSortWhile(num));
}


// Best case is O(n)
// Worst case is O(n^2)

// Space Complexty : O(1)  


List<int> bubbleSortAlgo(List<int> list) {
  bool swapped;

  for (int i = 0; i < list.length - 1; i++) {
    swapped = false;

    for (int j = 0; j < list.length - i - 1; j++) {
      if (list[j] > list[j + 1]) {
        swapp(list, j, j + 1);
        swapped = true;
      }
    }

    if (swapped == false) break;
  }

  return list;
}



List<int> bubbleSortWhile(List<int> list) {
  bool swapped = true;

  while (swapped) {
    swapped = false;

    for (int k = 0; k < list.length - 1; k++) {
      if (list[k] > list[k + 1]) {
        swapp(list, k, k + 1);
        swapped = true;
      }
    }

    if (swapped == false) break;
  }

  return list;
}



void swapp(List<int> list, int first, int second) {
  int temp = list[first];
  list[first] = list[second];
  list[second] = temp;
}
