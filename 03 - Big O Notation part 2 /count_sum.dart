// Calculate excution time ;

void main() {
  Stopwatch stopwatch = Stopwatch()..start();

  print(addUpTo2(1000000));

  print('AddUpTo excuted in ${stopwatch.elapsed}');
}

// Sum of n = 5 .... 5+4+3+2+1
double addUpTo(int n) {
  double total = 0;

  for (int i = 1; i <= n; i++) {
    total += i;
  }
  return total;
}

// Sum of n = 5 .... 5+4+3+2+1
double addUpTo2(int n) {
  return n * (n + 1) / 2;
}

// .010860
// .004517