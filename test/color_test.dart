import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_tools/colors/string_to_color.dart';

void main() {
  test('Testing if string to color returns unique color', () {

    expect(toColor("Brian Adams"), toColor("Brian Adams"));
    expect(toColor("Fernando Alonso"), toColor("Fernando Alonso"));
    expect(toColor(" "), toColor(" "));
    expect(toColor("      "), toColor("      "));
    expect(toColor("Sixpack Joe"), toColor("Sixpack Joe"));
    expect(toColor("n"), toColor("n"));
    expect(toColor("nu"), toColor("nu"));
    expect(toColor("nul"), toColor("nul"));
    expect(toColor("null"), toColor("null"));
    expect(toColor("nulll"), toColor("nulll"));
    expect(toColor(""), toColor(""));
  });

  test('Convert color to string rad 10 and # for transportation purpose', () {
    final stringRed = Colors.red.toHex(leadingHashSign: false, leading10rad: true);
    print(stringRed);
    final redConverted = Color(int.parse(stringRed));
    print(redConverted);
    expect(Colors.red.toHex(), redConverted.toHex());
  });
}