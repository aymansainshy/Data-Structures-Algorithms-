void main() {
  List<int> list = [5, 3, 2, 8, 15, 4, 8, 6, 10, 12, 2, 9];

  print(quickSort(list, 0, list.length - 1));
}


// QuickSort Algorithm ....
List quickSort(List<int> list, int left, int right) {

  if (left < right) {
    int pivotIndex = pivot(list, left, right);
    // left
    quickSort(list, left, pivotIndex - 1);
    // right
    quickSort(list, pivotIndex + 1, right);
  }

  return list;
}


// Pivot Index .....
int pivot(List<int> list, int start, int end) {
  var pivot = list[start];
  int swapedIndex = start;

  for (int i = start + 1; i < list.length; i++) {
    if (pivot > list[i]) {
      swapedIndex++;
      swapp(list, swapedIndex, i);
    }
  }

  swapp(list, start, swapedIndex);

  return swapedIndex;
}



// Swapp 
void swapp(List<int> list, int first, int second) {
  int temp = list[first];
  list[first] = list[second];
  list[second] = temp;
}
