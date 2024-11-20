import 'package:flutter/material.dart';

extension RelativeSizerExt on BuildContext {
  double get w => MediaQuery.of(this).size.width;

  double get h => MediaQuery.of(this).size.height;

  SizedBox get spaceV1 => SizedBox(height: h * 0.01);
  SizedBox get spaceV2 => SizedBox(height: h * 0.02);
  SizedBox get spaceV4 => SizedBox(height: h * 0.04);
  SizedBox get spaceV6 => SizedBox(height: h * 0.06);
  SizedBox get spaceV8 => SizedBox(height: h * 0.08);

  SizedBox get spaceH1 => SizedBox(width: w * 0.01);
  SizedBox get spaceH2 => SizedBox(width: w * 0.02);
  SizedBox get spaceH4 => SizedBox(width: w * 0.04);
  SizedBox get spaceH6 => SizedBox(width: w * 0.06);
  SizedBox get spaceH8 => SizedBox(width: w * 0.08);
}
