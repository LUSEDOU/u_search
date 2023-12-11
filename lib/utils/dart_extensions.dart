import 'package:flutter/material.dart';

extension IterableExtension<T> on Iterable<T> {
  Iterable<T?> whereNotNull() => where((T? element) => element != null);

  T? firstWhereOrNull(bool Function(T element) test) {
    try {
      return firstWhere(test);
    } catch (_) {
      return null;
    }
  }

  Iterable<T> changeWhere(
      bool Function(T element) test, T Function(T element) change) {
    return map((e) {
      if (test(e)) {
        return change(e);
      }
      return e;
    });
  }

  Iterable<T> changeWhereOrNull(
      bool Function(T element) test, T Function(T element) change) {
    return map((e) {
      if (test(e)) {
        return change(e);
      }
      return e;
    });
  }
}

extension ContextExtension on BuildContext {
    MediaQueryData get mediaQuery => MediaQuery.of(this);
    Size get size => mediaQuery.size;
    double get width => size.width;
    double get height => size.height;

    ThemeData get theme => Theme.of(this);
}
