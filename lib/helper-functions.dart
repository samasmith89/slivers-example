import 'package:flutter/material.dart';
import 'dart:math' as math;

Color randomColor() {
  return Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
      .withOpacity(1.0);
}

TextStyle cardTextStyle() {
  return const TextStyle(
      color: Colors.black, fontSize: 22, fontWeight: FontWeight.bold);
}
