import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_tools/extensions/date_extension.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/date_symbol_data_local.dart';

final dateTimeToTest = DateTime(2020, 12, 31, 13, 30, 45);

void main() {
  testWidgets('Testing if date matches formatted date based on locale', (WidgetTester tester) async {
    await checkDataFormatting(tester, "cs", "31. 12. 2020 13:30");
    await checkDataFormatting(tester, "en", "12/31/2020 13:30");
    await checkDataFormatting(tester, "de", "31.12.2020 13:30");
    await checkDataFormatting(tester, "it", "31/12/2020 13:30");
    await checkDataFormatting(tester, "sk", "31. 12. 2020 13:30");
    await checkDataFormatting(tester, "hr", "31. 12. 2020. 13:30");
    await checkDataFormatting(tester, "ro", "31.12.2020 13:30");
    await checkDataFormatting(tester, "bg", "31.12.2020 г. 13:30 ч.");
    await checkDataFormatting(tester, "fr", "31/12/2020 13:30");
    await checkDataFormatting(tester, "pl", "31.12.2020 13:30");
    await checkDataFormatting(tester, "ru", "31.12.2020 13:30");
    await checkDataFormatting(tester, "sr", "31.12.2020. 13:30");
    await checkDataFormatting(tester, "sl", "31. 12. 2020 13:30");
    // await checkDataFormatting(tester, "ukr", "01.01.2020 13:30");
  });
}

Future<void> checkDataFormatting(WidgetTester tester, String localeTag, String formattedResult) async {
  await tester.pumpWidget(
    MaterialApp(locale: Locale(localeTag), localizationsDelegates: const [
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ], supportedLocales: <Locale>[
      Locale.fromSubtags(languageCode: localeTag),
    ], home: Builder(
      builder: (BuildContext context) {
        initializeDateFormatting();

        debugPrint(localeTag + ": " + dateTimeToTest.toPrettyDateWithTime(context));

        expect(dateTimeToTest.toPrettyDateWithTime(context), formattedResult);

        return Container();
      },
    )),
  );
}