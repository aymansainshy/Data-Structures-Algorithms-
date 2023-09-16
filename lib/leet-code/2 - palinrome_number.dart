void main() {
  var isPalindrom = isPalindrome(122);
  print(isPalindrom);
}

bool isPalindrome(int x) {
  int originalNumber = x; // 1221
  int reversedNumber = 0; // 122

  while (x > 0) {
    int remainder = x % 10; // 1
    reversedNumber = reversedNumber * 10 + remainder; // 1221
    x = x ~/ 10; // 0.1
  }

  return originalNumber == reversedNumber;
}
