import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

DateFormat localizedDateFormatOnlyDate(BuildContext context) => DateFormat.yMd(Localizations.localeOf(context).languageCode);
DateFormat localizedDateFormatOnlyTime(BuildContext context) => DateFormat.Hm(Localizations.localeOf(context).languageCode);
DateFormat localizedDateFormatOnlyTimeWSeconds(BuildContext context) => DateFormat.Hms(Localizations.localeOf(context).languageCode);