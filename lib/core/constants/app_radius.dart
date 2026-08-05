import 'package:flutter/material.dart';

class AppRadius {
  AppRadius._();

  static const double buttonVal = 18;
  static const double cardVal = 22;
  static const double bottomSheetVal = 28;
  static const double dialogVal = 24;
  static const double textFieldVal = 18;
  static const double searchBarVal = 22;
  static const double floatingButtonVal = 22;
  static const double bottomNavigationVal = 26;
  static const double chipVal = 16;

  static final BorderRadius button = BorderRadius.circular(buttonVal);
  static final BorderRadius card = BorderRadius.circular(cardVal);
  static final BorderRadius bottomSheet = BorderRadius.circular(bottomSheetVal);
  static final BorderRadius dialog = BorderRadius.circular(dialogVal);
  static final BorderRadius textField = BorderRadius.circular(textFieldVal);
  static final BorderRadius searchBar = BorderRadius.circular(searchBarVal);
  static final BorderRadius floatingButton = BorderRadius.circular(floatingButtonVal);
  static final BorderRadius bottomNavigation = BorderRadius.circular(bottomNavigationVal);
  static final BorderRadius chip = BorderRadius.circular(chipVal);

  // Backward compatibility mappings
  static final BorderRadius small = BorderRadius.circular(6);
  static final BorderRadius medium = BorderRadius.circular(8);
  static final BorderRadius large = BorderRadius.circular(12);
  static final BorderRadius extraLarge = BorderRadius.circular(16);
  static final BorderRadius pill = BorderRadius.circular(100);
}