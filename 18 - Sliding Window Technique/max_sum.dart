import 'dart:math';

void main() {
  List list = [1, 4, 2, 10, 2, 3, 1, 0, 20];
  int k = 4;

  print(maxSum1(list, k));
}

double maxSum(List list, int k) {
  /// O(n) With Sliding Window Technique ....
  double maxSum = 0;
  double windowSum = 0;

  if (list.length < k) {
    print("Invalid ...");
    return 0;
  }

  for (int i = 0; i < k; i++) {
    maxSum += list[i];
  }

  windowSum = maxSum;

  for (int i = k; i <= list.length; i++) {
    windowSum = windowSum - list[i - k] + list[i];
    maxSum = max(windowSum, maxSum);
  }

  return maxSum;
}




double maxSum1(List list, int k) {
  /// O(n^2)
  if (k > list.length) {
    print("Invalid ...");
    return 0;
  }

  double maxSum = -double.infinity;

  for (int i = 0; i < list.length - k + 1; i++) {
    double currentSum = 0.0;
    for (int j = 0; j < k; j++) {
      currentSum += list[i + j];
    }

    maxSum = max(currentSum, maxSum);
  }

  return maxSum;
}
