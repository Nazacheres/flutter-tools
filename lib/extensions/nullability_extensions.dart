import 'dart:core';

T? tryOrNull<T>(Function function) {
  try {
    return function.call() as T;
  } catch (e) {
    return null;
  }
}

Future<T?> tryOrNullAsync<T>(Future<T> Function() function) async {
  try {
    return await function.call();
  } catch (e) {
    return null;
  }
}