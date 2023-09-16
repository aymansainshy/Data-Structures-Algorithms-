void main() {
  List<int> nums = [2, 11, 7, 15];

  int target = 9;

  print(target + nums.length);
}

List<int>? twoSum(List<int> nums, int target) {
  var previousValue = {};

  for (var i = 0; i < nums.length; i++) {
    var currentNum = nums[i];

    var neededValue = target - currentNum;

    var index2 = previousValue[neededValue];

    if (index2 != null) {
      return [index2, i];
    } else {
      previousValue[currentNum] = i;
    }
  }
  return null;
}
