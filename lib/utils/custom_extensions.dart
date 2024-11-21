//bool
import 'package:flutter/material.dart';

extension BoolExtensions on bool {
  bool not() => !this;
}

//object
extension ObjectExtension on Object? {
  bool isNull() => this == null;

  bool isNotNull() => isNull().not();

  bool isNullOrEmpty() {
    if (this is String) {
      return (isNull() || (this as String).isEmpty);
    } else if (this is List) {
      return (isNull() || (this as List).isEmpty);
    } else {
      return isNull();
    }
  }

  bool isNotNullOrEmpty() => isNullOrEmpty().not();
}

// int
extension NumExtensions on num {
  BorderRadius toRadius() {
    return BorderRadius.circular(toDouble());
  }

  RoundedRectangleBorder toRoundedRectRadius() {
    return RoundedRectangleBorder(borderRadius: toRadius());
  }
}

// string
extension StringExtensions on String? {
  bool isNullOrEmpty() {
    return (this == null || this!.isEmpty);
  }

  bool isNullOrEmptyNot() {
    return (this != null && this!.isNotEmpty);
  }
}
