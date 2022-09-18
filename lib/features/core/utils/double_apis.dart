extension NumberParsing on double {
  String toStringWithFixedDecimal({int decimalPlaces = 3}) {
    final string = toStringAsFixed(decimalPlaces);

    if (string.contains('.') && !string.endsWith('.')) {
      int charactersToRemoveCount = 0;

      for (int i = string.length - 1; i >= 0; i--) {
        if (string[i] == '0') {
          charactersToRemoveCount++;
        } else {
          if (string[i] == '.') {
            charactersToRemoveCount++;
            break;
          } else {
            break;
          }
        }
      }

      return string.substring(0, string.length - charactersToRemoveCount);
    } else {
      return string;
    }
  }
}
