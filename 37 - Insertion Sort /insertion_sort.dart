void main() {
  List<int> num = [8, 4, 2, 5, 1, 0];
  print(insertionSortAlgo(num));
}

List<int> insertionSortAlgo(List<int> list) {
  // Start from the second element in array ..
  for (int i = 1; i < list.length; i++) {
    //Choosing the first element in out unsorted subarray .
    int current = list[i];

    //Finding the position of the last element in the sorted subarray .
    int j = i - 1;

    while (j >= 0 && list[j] > current) {
      list[j + 1] = list[j];
      j--;
    }

    list[j + 1] = current;
  }
  return list;
}




// With For loop ..
List<int> insertionSortForLoop(List<int> list) {
  for (int i = 1; i < list.length; i++) {
    int current = list[i];

    int j;
    for (j = i - 1; (j > -1) && (current < list[j]); j--) {
      list[j + 1] = list[j];
    }
    list[j + 1] = current;
  }

  return list;
}

// Start from the second element in array ..
// Insertion Sort algorithm ...O(n^2)