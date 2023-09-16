/*
3. Longest Substring Without Repeating Characters

  Given a string s, find the length of the longest substring without repeating characters.

  Constraints:
     1- 0 <= s.length <= 5 * 104
     2- s consists of English letters, digits, symbols and spaces
 */
void main() {
  final resutl = lengthOfLongestSubstring(" ");
  print(resutl.toString());
}

int lengthOfLongestSubstring(String s) {
  String result = "";

  if (s.isNotEmpty && s.length == 1) {
    return 1;
  }

  for (var i = 0; i < s.length - 1; i++) {
    var longSubString = "";
    longSubString += s[i];

    for (var j = i + 1; j < s.length; j++) {
      if (longSubString.contains(s[j])) {
        break;
      }
      longSubString += s[j];
    }

    if (result.length < longSubString.length) {
      result = longSubString;
    }
  }
  return result.length;
}

// int lengthOfLongestSubstring(String s) {
//   List<String> result = [];
//
//   if (s.isNotEmpty && s.length == 1) {
//     return 1;
//   }
//
//   for (var i = 0; i < s.length - 1; i++) {
//     List<String> visitedCharList = [];
//     visitedCharList.add(s[i]);
//
//     for (var j = i + 1; j < s.length; j++) {
//       if (visitedCharList.contains(s[j])) {
//         break;
//       }
//       visitedCharList.add(s[j]);
//     }
//
//     if (result.length < visitedCharList.length) {
//       result = visitedCharList;
//     }
//   }
//   return result.length;
// }
