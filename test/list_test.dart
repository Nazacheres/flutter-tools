import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_tools/colors/string_to_color.dart';
import 'package:flutter_tools/extensions/list_extension.dart';

void main() {
  test('Testing if list population works', () {

    final shortlist = List.of([1,2,3,4]);
    final longList = List.of([1,2,3,4,5,6,7,8,9,10]);
    final empty = List.empty();
    final oneItem = List.of([1]);

    expect(shortlist..addBetweenAll(0), [1,0,2,0,3,0,4]);
    expect(longList..addBetweenAll(0), [1,0,2,0,3,0,4,0,5,0,6,0,7,0,8,0,9,0,10]);
    expect(empty..addBetweenAll(0), empty);
    expect(oneItem..addBetweenAll(0), oneItem);
  });
}