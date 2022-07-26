
extension StringCasingExtension on String {
  String toCapitalized() => length > 0 ?'${this[0].toUpperCase()}${substring(1).toLowerCase()}':'';
  String toTitleCaseTest() => replaceAll(RegExp(' +'), ' ').split(' ').map((str) => str.toCapitalized()).join(' ');
}

extension CapitalizedStringExtension on String {
  String toTitleCase() {
    return stringCapitaliseEachWord(this);
  }
}


////   Capitalize each letter
String stringCapitaliseEachWord(String text) {
  final List<String> words = text.split(' ');
  if (words.length <= 1) {
    return text.toCapitalized();
  } else {
    final capitalizedWords = words.map((word) {
      if (word.trim().isNotEmpty) {
        final String firstLetter = word.trim().substring(0, 1).toUpperCase();
        final String remainingLetters = word.trim().substring(1).toLowerCase();
        return '$firstLetter$remainingLetters';
      }
      return '';
    });
    return capitalizedWords.join(' ');
  }
  //final List<String> words = text.split(' ');
}
