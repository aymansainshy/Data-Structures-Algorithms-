void main() {
  List<int> list = [88, 32, 2, 44, 6, 77, 0, 1, 3, 3];

  print(mergeSort(list));
}

// MergeSort Algorithm ...O(n log n)
// Worst case is O(n log n)
List mergeSort(List list) {
  if (list.length <= 1) return list;

  int middle = list.length ~/ 2;

  List left = list.sublist(0, middle);
  List right = list.sublist(middle);

  left = mergeSort(left); // Recursive call
  right = mergeSort(right); // Recursive call 

  return merge(left, right);
}




// It's merge two sorted list into one sorted list .......O(n)
List merge(List left, List right) {
  List result = [];

  while (left.isNotEmpty && right.isNotEmpty) {
    if (left.first < right.first) {
      result.add(left.removeAt(0));
      // print(result);
    } else {
      result.add(right.removeAt(0));
      // print(result);
    }
  }

  result.addAll(left);
  result.addAll(right);
  // print(result);

  return result;
}

//////////////////////////////////////////////////////////////////////////////////////////////

List merge2(List left, List right) {
  List mergedList = [];

  int i = 0;
  int j = 0;

  while (i < left.length && j < right.length) {
    if (left[i] < right[j]) {
      mergedList.add(left[i]);
      i++;
      print(mergedList);
    } else {
      mergedList.add(right[j]);
      j++;
      print(mergedList);
    }
  }

  mergedList.addAll(left.sublist(i));
  mergedList.addAll(right.sublist(j));
  print(mergedList);

  // while (i < left.length) {
  //   mergedList.add(left[i]);
  //   i++;
  // }

  // while (j < right.length) {
  //   mergedList.add(right[j]);
  //   j++;
  // }

  return mergedList;
}
