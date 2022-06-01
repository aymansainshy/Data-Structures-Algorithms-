void main() {
  print(collectOddValues([1, 2, 4, 5, 6, 2, 3, 7, 9, 33, 21, 55]));
}

// 1-  Recursion with Helper method
List collectOddValues(List list) {
  List result = [];

  void helper(List helperInput) {
    print(helperInput);

    if (helperInput.isEmpty) {
      return;
    }

    if (helperInput[0] % 2 != 0) {
      result.add(helperInput[0]);
    }

    helperInput = helperInput.sublist(1, helperInput.length);
    helper(helperInput);
  }

  helper(list);

  return result;
}

// 2-  Pure Recursion
List collectOddValues2(List list) {
  List newList = [];

  if (list.isEmpty) {
    return newList;
  }

  if (list[0] % 2 != 0) {
    newList.add(list[0]);
  }

  list = list.sublist(1, list.length);

  newList = List.from(newList)..addAll(collectOddValues2(list));

  return newList;
}
