void main() {
  List<int> list = [5, 3, 2, 8, 15, 4, 8, 6, 10, 12, 2, 9];

  print(quickSort(list, 0, list.length - 1));
}

// QuickSort Algorithm Naive Implementation ....

// This Approch has some issues and questions:
// - Calling where three times on the same list isn’t time-efficient.
// - Creating a new list for every partition isn’t space-efficient. Could you possibly sort in place?

List<E> quickSortNaiveImpl<E extends Comparable<dynamic>>(List<E> list) {
  if (list.length < 2) return list;

  final pivot = list[0];

  final less = list.where((value) => value.compareTo(pivot) < 0);

  final equal = list.where((value) => value.compareTo(pivot) == 0);

  final greater = list.where((value) => value.compareTo(pivot) > 0);

  return [
    ...quickSortNaiveImpl(less.toList()),
    ...equal,
    ...quickSortNaiveImpl(greater.toList()),
  ];
}

//////////////////////////////////////////////////////////////////////////////////

// QuickSort Algorithm Partition Implementation ....
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

// Pivot Index ..... [9,2,3,55,32,1,22,0] 5
int pivot(List<int> list, int start, int end) {
  var pivot = list[start]; // 9
  int swapedIndex = start; // 3

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

extension Swappable<E> on List<E> {
  void swap(int indexA, int indexB) {
    if (indexA == indexB) return;
    final temp = this[indexA];
    this[indexA] = this[indexB];
    this[indexB] = temp;
  }
}
