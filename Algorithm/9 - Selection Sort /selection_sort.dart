void main() {
  List<int> num = [8, 4, 2, 5, 1, 0];
  print(selectionSortAlog(num));
}

// Selection Sort algorithm ...O(n^2)
// Best and Worst case is O(n^2)

// Space Complexty : O(1)
List<int> selectionSortAlog(List<int> list) {
  for (int i = 0; i < list.length; i++) {
    // Find the smallest emlemnt in the list ...
    int smallest = i;

    for (int j = i + 1; j < list.length; j++) {
      if (list[j] < list[smallest]) {
        smallest = j;
      }
    }

    // Swap the smallest element with the first element ...
    if (smallest != i) {
      swapp(list, i, smallest);
    }
  }

  return list;
}



void swapp(List<int> list, int i, int smallest) {
  int temp = list[i];
  list[i] = list[smallest];
  list[smallest] = temp;
}
