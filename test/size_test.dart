import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_tools/converter/bytes_to_string.dart';

void main() {
  test('Testing if string to color returns unique color', () {
    expect(formatBytes(1300, decimals: 1), "1.3 KB");
    expect(formatBytes(1600, decimals: 1), "1.6 KB");
    expect(formatBytes(15000, decimals: 1), "14.6 KB");
    expect(formatBytes(1200000, decimals: 1), "1.1 MB");
  });
}
