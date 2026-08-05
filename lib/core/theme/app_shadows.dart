import 'package:flutter/material.dart';

class AppShadows {
  AppShadows._();

  static const BoxShadow soft = BoxShadow(
    color: Color(0x08000000), // 3% opacity
    blurRadius: 16,
    offset: Offset(0, 4),
  );

  static const BoxShadow medium = BoxShadow(
    color: Color(0x0C000000), // 4.5% opacity
    blurRadius: 24,
    offset: Offset(0, 8),
  );

  static const BoxShadow primary = BoxShadow(
    color: Color(0x1A4F6DFF), // 10% opacity primary shadow
    blurRadius: 16,
    offset: Offset(0, 6),
  );
}
