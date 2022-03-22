import 'package:flutter/widgets.dart';
import 'package:flutter_tools/date/date_format_constant.dart';

extension DateTimePretty on DateTime {
  String toPrettyDateOnly(BuildContext context) => localizedDateFormatOnlyDate(context).format(this);
  String toPrettyTimeOnly(BuildContext context) => localizedDateFormatOnlyTime(context).format(this);
  String toPrettyDateWithTime(BuildContext context) => "${toPrettyDateOnly(context)} ${toPrettyTimeOnly(context)}";
}