import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_tools/extensions/nullability_extensions.dart';

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
