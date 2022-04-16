void main() {
  print(linearSearch([1,233,3,455,6,7,3,11,9.0], 22));
}

int linearSearch(List list, int value) {
  for (int i = 0; i < list.length; i++) {
    if (list[i] == value) {
      return i;
    }
  }

  return -1;
}
