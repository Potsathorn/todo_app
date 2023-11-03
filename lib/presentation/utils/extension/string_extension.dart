extension StringRfc3339Extension on String {
  DateTime toDateTimeFromRfc3339() {
    return DateTime.parse(this);
  }
}
