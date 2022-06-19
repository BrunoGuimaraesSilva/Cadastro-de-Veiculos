extension StringExtension on String {
  int toInt({int stdValue = 0}) {
    return int.tryParse(this) ?? stdValue;
  }
}
