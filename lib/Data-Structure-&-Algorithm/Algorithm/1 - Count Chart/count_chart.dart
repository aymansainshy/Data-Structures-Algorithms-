void main() {
  Map chartCount = countChart("ayman sainshy");
  print(chartCount);
}

Map countChart(String text) {
  // Make a map (or object ) to hold the charactors
  Map resutl = {};

  String newText = text.split(" ").toList().join(); // Without Spaces

  // Convert the text to Upercase or lowercase
  String lowerCaseText = newText.toLowerCase();

  // Make loop through the text
  // lowerCaseText.runes.forEach((int rune) {
  //   var charactor = String.fromCharCode(rune);
  //   print(charactor);
  //  });

  for (int i = 0; i < lowerCaseText.length; i++) {
    String charactor = lowerCaseText[i];
    // Charactor found in the map ?? + 1
    if (resutl.containsKey(charactor)) {
      resutl[charactor] += 1;
    } else {
      // Not found in the map 1
      resutl[charactor] = 1;
    }
  }

  // return Map
  return resutl;
}
