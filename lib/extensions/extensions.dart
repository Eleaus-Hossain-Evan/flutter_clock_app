import 'package:intl/intl.dart';

extension DateTimeExt on DateTime {
  String toHHMMAA() {
    return DateFormat('hh:mm aa').format(this);
  }

  String toHHMM() {
    return DateFormat('hh:mm').format(this);
  }
}
