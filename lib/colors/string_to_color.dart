import 'package:flutter/foundation.dart';
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
int toColor(String inputString) {
  final stringNonEmpty = inputString;
  try {
    var hash = _getInt(stringNonEmpty);
    var r = (hash & 0xFF0000) >> 16;
    var g = (hash & 0x00FF00) >> 8;
    var b = hash & 0x0000FF;
    var rr = r.toString();
    var gg = g.toString();
    var bb = b.toString();
    return int.parse('0xFF' +
        (tryOrNull(() => rr.substring(rr.length - 2)) ?? '00') +
        (tryOrNull(() => rr.substring(gg.length - 2)) ?? '00') +
        (tryOrNull(() => rr.substring(bb.length - 2)) ?? '00'));
  } catch (err) {
    if (kDebugMode) {
      print('Couldnt convert string to color: $err');
    }
    rethrow;
  }
}
