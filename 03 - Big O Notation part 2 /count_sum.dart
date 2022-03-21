// Calculate excution time ;

void main() {
  Stopwatch stopwatch = Stopwatch()..start();

  print(addUpTo2(1000000));
  countUpAndDown(100);

  print('AddUpTo excuted in ${stopwatch.elapsed}');
}
                                //    9
// Sum of n = 10 .... 1+2+3+4+....+ (n-1) + (n)

// Sum of n = 5 .... 5+4+3+2+1    // O(n)
double addUpTo(int n) {
  double total = 0;

  for (int i = 1; i <= n; i++) {
    total += i;
  }

  return total;
}

// Sum of n = 5 .... 5+4+3+2+1    // O(1)
double addUpTo2(int n) {
  return n * (n + 1) / 2;     
}

///////////////////////////////////// O(n)
void countUpAndDown(int n) {
  print("Going Up");
  for (int i = 1; i < n; i++) {
    print(i);
  }
  print("At the top");
  for (int j = n - 1; j >= 0; j--) {   
    print(j);
  }
  print("Back Down");
}

////////////////////////////// O(n^2)
void printAllPairs(n) {
  for (int i = 0; i < n; i++) {
    for (int j = 0; j < n; j++) {
      print("$i ,$j");
    }
  }
}
// .010860
// .005808
