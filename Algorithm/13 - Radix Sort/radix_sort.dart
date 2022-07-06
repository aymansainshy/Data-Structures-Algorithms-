import 'dart:math' as math;

void main() {
  print(redixSort([27623, 1, 3325,5,666,]));
}

List redixSort(List numbers) {
  int mostDigitCount = mostDigits(numbers); // 5
     //   10000,1000,100,10,0
     // k = 5,   4,  2,  1, 0
  for (int k = 0; k < mostDigitCount; k++) {
    final digitBucket = List.generate(10, (_) => <int>[]); // [] [] [] [] ....

    for (int i = 0; i < numbers.length; i++) {
      int numAtDigit = getNumAtDigit(numbers[i], k);
      digitBucket[numAtDigit].add(numbers[i]);
      print(digitBucket);
    }

    numbers = [... digitBucket].expand((x) => x).toList();
  }
  
  return numbers;
}




int digitCount(int num) {
  if (num == 0) return 1;
  int log10(x) => math.log(x) ~/ math.ln10;
  int count = log10(num.abs()) + 1;
  return count;
}

 
int mostDigits(List numbers) {
  int maxDigits = 0;

  for (int i = 0; i < numbers.length; i++) {
    // math.max let us have the bigger number ...
    maxDigits = math.max(maxDigits, digitCount(numbers[i]));
  }
  return maxDigits;
}


int getNumAtDigit(int num, int indexFromRight) {
  // for removing the nagative sign use absolute fun abs()
  // math.pow(10, 2) => 10 * 10 , math.pow(10, 3) => 10*10*10
  // floor() => return the integer number <= the real number
  int number = (num.abs() / math.pow(10, indexFromRight)).floor() % 10;
  return number;
}
