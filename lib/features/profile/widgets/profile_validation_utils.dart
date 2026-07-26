import 'package:flutter/material.dart';

/// Single Shared Profile Validation & Accessibility utility module.
/// Provides enterprise-grade form validation, keyboard navigation support,
/// semantic accessibility wrappers, and focus management across all 15 Profile screens.
/// Enforces JobNest design language, high contrast guidelines, and responsive text scaling (100%-200%).

// ============================================================================
// 1. STANDARDIZED PROFILE VALIDATORS
// ============================================================================

class ProfileValidators {
  // TODO:
  // Replace dummy validation with backend validation.

  // TODO:
  // API error mapping.

  /// Validates required fields with clear recovery guidance.
  static String? validateRequired(String? value, [String? fieldName]) {
    if (value == null || value.trim().isEmpty) {
      final name = fieldName ?? "This field";
      return "$name is required. Please enter a valid value.";
    }
    return null;
  }

  /// Validates enterprise email format (e.g., recruiter@company.com).
  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Email address is required. Please enter a valid work email.";
    }
    final trimmed = value.trim();
    // Professional email regex
    final emailRegex = RegExp(r'^[\w\.-]+@([\w-]+\.)+[\w-]{2,6}$');
    if (!emailRegex.hasMatch(trimmed)) {
      return "Please enter a valid enterprise email address (e.g., name@company.com).";
    }
    return null;
  }

  /// Validates international or domestic phone numbers.
  static String? validatePhone(String? value, {bool isRequired = true}) {
    if (value == null || value.trim().isEmpty) {
      return isRequired ? "Phone number is required for verification." : null;
    }
    final trimmed = value.trim();
    // Allow digits, spaces, plus, hyphens, and parentheses; min length 7, max 18
    final phoneRegex = RegExp(r'^\+?[\d\s\-\(\)]{7,18}$');
    if (!phoneRegex.hasMatch(trimmed)) {
      return "Please enter a valid phone number with area code (e.g., +1 800 555 0199).";
    }
    return null;
  }

  /// Validates website URLs (company websites, LinkedIn profiles, portfolios).
  static String? validateUrl(String? value, {bool isRequired = false}) {
    if (value == null || value.trim().isEmpty) {
      return isRequired ? "Website URL is required." : null;
    }
    final trimmed = value.trim();
    final urlRegex = RegExp(r'^(https?:\/\/)?([\w\d\-_]+\.)+[\w\d\-_]{2,}(\/.*)?$');
    if (!urlRegex.hasMatch(trimmed)) {
      return "Please enter a valid URL formatting (e.g., https://company.com).";
    }
    return null;
  }

  /// Validates 4-digit foundation or graduation year.
  static String? validateYear(String? value, {bool isRequired = false}) {
    if (value == null || value.trim().isEmpty) {
      return isRequired ? "Year is required." : null;
    }
    final trimmed = value.trim();
    final year = int.tryParse(trimmed);
    final currentYear = DateTime.now().year;
    if (year == null || trimmed.length != 4 || year < 1850 || year > currentYear + 5) {
      return "Please enter a valid 4-digit year between 1850 and ${currentYear + 5}.";
    }
    return null;
  }

  /// Validates full names or organization names (length and symbol rules).
  static String? validateName(String? value, [String? fieldName]) {
    if (value == null || value.trim().isEmpty) {
      final name = fieldName ?? "Name";
      return "$name is required.";
    }
    final trimmed = value.trim();
    if (trimmed.length < 2) {
      return "${fieldName ?? 'Name'} must be at least 2 characters long.";
    }
    if (trimmed.length > 80) {
      return "${fieldName ?? 'Name'} cannot exceed 80 characters.";
    }
    return null;
  }

  /// Validates enterprise account password complexity rules.
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Password is required for account security.";
    }
    if (value.length < 8) {
      return "Password must be at least 8 characters long.";
    }
    final hasLetter = value.contains(RegExp(r'[a-zA-Z]'));
    final hasNumber = value.contains(RegExp(r'[0-9]'));
    if (!hasLetter || !hasNumber) {
      return "Password must include both letters and numbers for enterprise security.";
    }
    return null;
  }

  /// Validates numeric fields (team size, requisition limits, experience years, salary targets).
  static String? validateNumeric(
    String? value, {
    double? min,
    double? max,
    bool isInteger = false,
    bool isRequired = false,
    String? fieldName,
  }) {
    if (value == null || value.trim().isEmpty) {
      return isRequired ? "${fieldName ?? 'This field'} is required." : null;
    }
    final trimmed = value.trim();
    final numVal = isInteger ? int.tryParse(trimmed) : double.tryParse(trimmed);
    if (numVal == null) {
      return "Please enter a valid ${isInteger ? 'whole number' : 'numeric number'}.";
    }
    if (min != null && numVal < min) {
      return "Value must be greater than or equal to $min.";
    }
    if (max != null && numVal > max) {
      return "Value must be less than or equal to $max.";
    }
    return null;
  }

  /// Validates dropdown selections.
  static String? validateDropdown<T>(T? value, [String? fieldName]) {
    if (value == null || (value is String && value.trim().isEmpty)) {
      return "Please select ${fieldName ?? 'an option'} from the list.";
    }
    return null;
  }
}

// ============================================================================
// 2. ACCESSIBILITY & SEMANTIC HELPERS
// ============================================================================

class ProfileAccessibilityUtils {
  // TODO:
  // Accessibility localization.

  /// Wraps any widget in clean accessibility semantics for screen readers (VoiceOver/TalkBack).
  static Widget semanticWrap({
    required Widget child,
    required String label,
    String? hint,
    bool isButton = false,
    bool isHeader = false,
    bool isSelected = false,
    bool isTextField = false,
    bool enabled = true,
    VoidCallback? onTap,
  }) {
    return Semantics(
      label: label,
      hint: hint,
      button: isButton,
      header: isHeader,
      selected: isSelected,
      textField: isTextField,
      enabled: enabled,
      onTap: onTap,
      excludeSemantics: true,
      child: child,
    );
  }

  /// Wraps text elements to ensure they scale cleanly from 100% up to 200% accessibility scale
  /// without causing overflow or clipping.
  static Widget accessibleText(
    String text, {
    TextStyle? style,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow overflow = TextOverflow.ellipsis,
  }) {
    return Builder(
      builder: (context) {
        final textScale = MediaQuery.of(context).textScaler.scale(1.0);
        // If user scale is very large (>= 1.5), allow more lines to prevent text clipping
        final effectiveMaxLines = maxLines != null && textScale >= 1.5 ? maxLines * 2 : maxLines;

        return Text(
          text,
          style: style,
          textAlign: textAlign,
          maxLines: effectiveMaxLines,
          overflow: overflow,
        );
      },
    );
  }
}

// ============================================================================
// 3. KEYBOARD NAVIGATION & FOCUS MANAGEMENT
// ============================================================================

class ProfileFocusManager {
  /// Moves focus to the next field or completes submission.
  static void nextFocus(BuildContext context, [FocusNode? nextNode]) {
    if (nextNode != null) {
      FocusScope.of(context).requestFocus(nextNode);
    } else {
      FocusScope.of(context).nextFocus();
    }
  }

  /// Unfocuses keyboard cleanly after dialogs close or forms are saved.
  static void unfocus(BuildContext context) {
    final currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus && currentFocus.hasFocus) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }

  /// Traverses focus back to previous control when modals/dialogs close.
  static void previousFocus(BuildContext context) {
    FocusScope.of(context).previousFocus();
  }
}
