extension DateTimeExtension on DateTime {
  String toRfc3339String() {
    return "${toIso8601String()}Z";
  }
}
