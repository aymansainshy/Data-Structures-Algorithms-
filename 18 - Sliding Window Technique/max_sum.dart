import 'dart:math';

void main() {
  List list = [1, 4, 2, 10, 2, 3, 1, 0, 20];
  int k = 4;

  print(maxSum1(list, k));

  /////////////////
   int result;
  
  print('\n\n\n\n\n');
  result = maxConsecutiveSubsetSum([7, 9, 20, 4, 9, 3, 11, 4, 3], 2);    // 29
  print(result == 29);
  result = maxConsecutiveSubsetSum([7, 9, 20, 4, 9, 3, 11, 4, 3], 3);    // 36
  print(result == 36);
  result = maxConsecutiveSubsetSum([4, 2, 1, 6, 2], 4);    // 13
  print(result == 13);
  result = maxConsecutiveSubsetSum([1, 1, 1], 3);    // 3
  print(result == 3);
  result = maxConsecutiveSubsetSum([], 3);    // null
  print(result == 0);
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




/**
 * 🔥🔥🔥🔥 Sliding Window Pattern 🔥🔥🔥🔥
 * 
 *      - Easy to implement
 *      - Can be tricky to reason about
 *      - Good at making O(n^2) Subset / Subarray problems O(n)
 * 
 *      -----
 *     | sum |
 *      -----
 *   [                 ]
 * 
 *        ⬆️_____⬆️  
 * 
 * view live @ https://dartpad.dartlang.org/1e9810331f8d04d2909c5c2c6f7b7ac6
 * 
 *  Write a function called maxConsecutiveSubsetSum that accepts
 *  a list of integers and an integer n. Return an integer representing
 *  maximum sum of n consecutive elements in the array.
 *  n will never be smaller than the length of the list
 * 
 * maxConsecutiveSubsetSum([7, 9, 20, 4, 9, 3, 11, 4, 3], 2);    // 29
 * maxConsecutiveSubsetSum([4, 5, 7, 9, 20, 4, 9, 3, 11, 4, 3], 3);    // 36
 * maxConsecutiveSubsetSum([4, 2, 1, 6, 2], 4);    // 13
 * maxConsecutiveSubsetSum([1, 1, 1], 3);    // 3
 * maxConsecutiveSubsetSum([], 3);    // null
 * 
 * */



int maxConsecutiveSubsetSum(List<int> list, int n) {
  if (list.length < n) return 0;
  
  // We don't need to set this to a min value, because we are immediately
  // establishing a baseline (which may be negative)
  int maxSum = 0;
  
  // Sum the first n elements to establish our baseline.
  for (int i = 0; i < n; i++) maxSum += list[i];
  
  int p1 = 0;
  int p2 = n;
  int tempSum = maxSum;
  
   
  // n = 3
  //    [ 4,  5,  7,   9,   20,  4,   9,   3,   11,   4,   3 ]
  //      p1___________p2

  // maxSum: 16
  // tempSum: 16
  
  // Continue until the edge of our window (i.e. p2) reaches the end of the list.
  while (p2 < list.length) {
    // Calculate prospective sum using window edges so that sum includes p2 and excludes p1 values.
    // tempSum =  16  -    4     +    9
    tempSum = tempSum - list[p1] + list[p2];
    // Update condition
    if (tempSum > maxSum)
      maxSum = tempSum;
    // Slide the window along the list
    p1++;
    p2++;
  }
  
  return maxSum;
}
