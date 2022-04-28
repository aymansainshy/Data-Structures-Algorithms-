void main() {
  naivApproach("This is a dummy text", "dummy");
}

// Naive Approach : Finding Pattern

// Searching Specific word or charactor in String .
// It's finding approach for searching in String .

void naivApproach(String text, String pattern) {
  int textLength = text.length;
  int patternLength = pattern.length;

  for (int i = 0; i < textLength - patternLength; i++) {
    int j;

    for (j = 0; j < patternLength; j++) {
      print(text[i + j] + " " + pattern[j]);
      
      if (text[i + j] != pattern[j]) {
        print("Break !");
        break;
      }
    }

    if (j == patternLength) {
      print("Pattern found at index $i");
      // break;
    }
  }
}
