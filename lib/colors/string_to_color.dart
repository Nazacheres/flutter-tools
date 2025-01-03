import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_tools/extensions/nullability_extensions.dart';

extension HexColor on Color {
  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true, bool leading10rad = false}) => '${leadingHashSign ? '#' : leading10rad ? '0x' : ''}'
      '${(a*255).toInt().toRadixString(16).padLeft(2, '0')}'
      '${(r*255).toInt().toRadixString(16).padLeft(2, '0')}'
      '${(g*255).toInt().toRadixString(16).padLeft(2, '0')}'
      '${(b*255).toInt().toRadixString(16).padLeft(2, '0')}';
}

/// https://github.com/allansrc/string_to_hex
int _getInt(str) {
  var hash = 5381;

  for (var i = 0; i < str.length; i++) {
    hash = ((hash << 4) + hash) + str.codeUnitAt(i) as int;
  }

  return hash;
}

/// return a hex-color.
/// to get unique results string should be at least 5 characters long
Color toColor(String inputString, {saturation = 0.3, lightness = 0.8}) {
  try {
    var hash = 0;
    for (var i = 0; i < inputString.length; i++) {
      hash = inputString.codeUnitAt(i) + ((hash << 5) - hash);
    }

    int h = hash.abs() % 360;
    return HSLColor.fromAHSL(1, h.toDouble(), saturation, lightness).toColor();
  } catch (err) {
    if (kDebugMode) {
      print('Couldnt convert string to color: $err');
    }
    rethrow;
  }
}
