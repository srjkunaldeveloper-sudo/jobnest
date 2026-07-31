import '../../../core/constants/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:jobnest/core/constants/app_radius.dart';
import 'package:jobnest/core/widgets/app_card.dart';
import 'package:jobnest/features/profile/widgets/profile_validation_utils.dart';

/// Single Shared Profile Dialog & Form utility module for Dialogs, Bottom Sheets,
/// Form Validation, Input Fields, Button Behaviors, Search/Filter Experiences,
/// and Navigation Protection across all 15 Profile screens.
/// Follows JobNest enterprise design language and accessibility standards.

// ============================================================================
// 1. STANDARDIZE DIALOGS & WARNING FEEDBACK
// ============================================================================

class ProfileDialogs {
  /// Base Confirmation / Warning Dialog with standardized typography, radius, and spacing.
  static Future<T?> showConfirmationDialog<T>(
    BuildContext context, {
    required String title,
    required String description,
    required String primaryText,
    required VoidCallback onPrimaryPressed,
    String? secondaryText,
    VoidCallback? onSecondaryPressed,
    IconData? icon,
    bool isDanger = false,
    bool isWarning = false,
  }) {
    // TODO:
    // Replace placeholder dialogs with API responses.
    final theme = Theme.of(context);
    final effectiveColor = isDanger
        ? theme.colorScheme.error
        : (isWarning ? Colors.amber.shade700 : theme.colorScheme.primary);
    final effectiveIcon = icon ??
        (isDanger
            ? AppIcons.delete_outline_rounded
            : (isWarning ? AppIcons.warning_amber_rounded : AppIcons.info_outline_rounded));

    return showDialog<T>(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: AppRadius.large),
        contentPadding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
        actionsPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        content: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 420),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: effectiveColor.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(effectiveIcon, size: 36, color: effectiveColor),
              ),
              const SizedBox(height: 16),
              Text(
                title,
                style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Text(
                description,
                style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        actions: [
          Wrap(
            alignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 12,
            runSpacing: 8,
            children: [
              if (secondaryText != null)
                OutlinedButton(
                  onPressed: () {
                    Navigator.of(ctx).pop();
                    if (onSecondaryPressed != null) onSecondaryPressed();
                  },
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size(110, 48),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                  ),
                  child: Text(secondaryText),
                ),
              FilledButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                  onPrimaryPressed();
                },
                style: FilledButton.styleFrom(
                  minimumSize: const Size(120, 48),
                  backgroundColor: isDanger ? theme.colorScheme.error : theme.colorScheme.primary,
                  foregroundColor: isDanger ? theme.colorScheme.onError : theme.colorScheme.onPrimary,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                ),
                child: Text(primaryText, style: const TextStyle(fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Pre-configured Standard Dialogs
  static void showSaveChangesDialog(BuildContext context, VoidCallback onSave) {
    showConfirmationDialog(
      context,
      title: "Save Changes",
      description: "Are you sure you want to save these profile updates to your organization record?",
      primaryText: "Save Changes",
      secondaryText: "Discard",
      onPrimaryPressed: onSave,
      icon: AppIcons.save_outlined,
    );
  }

  static void showDiscardChangesDialog(BuildContext context, VoidCallback onDiscard) {
    showConfirmationDialog(
      context,
      title: "Discard Changes",
      description: "You have unsaved changes in this section. Are you sure you want to discard them?",
      primaryText: "Discard & Leave",
      secondaryText: "Keep Editing",
      onPrimaryPressed: onDiscard,
      isWarning: true,
      icon: AppIcons.edit_off_outlined,
    );
  }

  static void showDeleteItemDialog(BuildContext context, {required String itemName, required VoidCallback onDelete}) {
    showConfirmationDialog(
      context,
      title: "Delete $itemName",
      description: "This action cannot be undone. Are you sure you want to permanently delete this $itemName?",
      primaryText: "Delete Permanently",
      secondaryText: "Cancel",
      onPrimaryPressed: onDelete,
      isDanger: true,
      icon: AppIcons.delete_forever_outlined,
    );
  }

  static void showLogoutDialog(BuildContext context, VoidCallback onLogout) {
    showConfirmationDialog(
      context,
      title: "Log Out",
      description: "You will be signed out of your enterprise recruiter session on this device.",
      primaryText: "Log Out",
      secondaryText: "Cancel",
      onPrimaryPressed: onLogout,
      isDanger: true,
      icon: AppIcons.logout_rounded,
    );
  }

  static void showRemoveTeamMemberDialog(BuildContext context, {required String memberName, required VoidCallback onRemove}) {
    showConfirmationDialog(
      context,
      title: "Remove Team Member",
      description: "Are you sure you want to revoke recruiter workspace access for $memberName?",
      primaryText: "Remove Access",
      secondaryText: "Cancel",
      onPrimaryPressed: onRemove,
      isDanger: true,
      icon: AppIcons.person_remove_outlined,
    );
  }

  static void showDeleteAccountDialog(BuildContext context, VoidCallback onDelete) {
    showConfirmationDialog(
      context,
      title: "Delete Recruiter Account",
      description: "WARNING: This will permanently delete your organization profile, hiring pipeline, and candidate history.",
      primaryText: "Delete Account",
      secondaryText: "Cancel",
      onPrimaryPressed: onDelete,
      isDanger: true,
      icon: AppIcons.warning_rounded,
    );
  }

  static void showResetPreferencesDialog(BuildContext context, VoidCallback onReset) {
    showConfirmationDialog(
      context,
      title: "Reset Preferences",
      description: "This will restore all default hiring preferences and communication rules to system defaults.",
      primaryText: "Reset to Defaults",
      secondaryText: "Cancel",
      onPrimaryPressed: onReset,
      isWarning: true,
      icon: AppIcons.restore_rounded,
    );
  }

  static void showCancelSubscriptionDialog(BuildContext context, VoidCallback onCancel) {
    showConfirmationDialog(
      context,
      title: "Cancel Subscription",
      description: "Cancelling your enterprise plan will downgrade your workspace to the free tier at the end of the billing cycle.",
      primaryText: "Cancel Subscription",
      secondaryText: "Keep Plan",
      onPrimaryPressed: onCancel,
      isWarning: true,
      icon: AppIcons.cancel_outlined,
    );
  }

  static void showRestoreDefaultsDialog(BuildContext context, VoidCallback onRestore) {
    showConfirmationDialog(
      context,
      title: "Restore Defaults",
      description: "Are you sure you want to restore all organization and profile parameters to dummy defaults?",
      primaryText: "Restore Defaults",
      secondaryText: "Cancel",
      onPrimaryPressed: onRestore,
      isWarning: true,
      icon: AppIcons.refresh_rounded,
    );
  }
}

// ============================================================================
// 2. STANDARDIZE BOTTOM SHEETS & FILTERS
// ============================================================================

class ProfileBottomSheets {
  /// Standardized Bottom Sheet with rounded top corners, Safe Area, drag handle, and no keyboard overlap.
  static Future<T?> showStandardSheet<T>(
    BuildContext context, {
    required String title,
    required Widget child,
    bool isScrollControlled = true,
    EdgeInsetsGeometry? padding,
  }) {
    final theme = Theme.of(context);

    return showModalBottomSheet<T>(
      context: context,
      isScrollControlled: isScrollControlled,
      showDragHandle: true,
      backgroundColor: theme.colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) => SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            top: 8,
            bottom: MediaQuery.of(ctx).viewInsets.bottom + 20,
          ),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(ctx).size.height * 0.85,
              maxWidth: 650,
            ),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        title,
                        style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                        onPressed: () => Navigator.of(ctx).pop(),
                        icon: const Icon(AppIcons.close_rounded),
                        tooltip: "Close",
                      ),
                    ],
                  ),
                  const Divider(height: 24),
                  child,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Standardized Filter & Sort Bottom Sheet
  static void showFilterSortSheet(
    BuildContext context, {
    required String title,
    required List<String> filterOptions,
    required List<String> selectedFilters,
    required Function(List<String>) onApply,
    required VoidCallback onReset,
  }) {
    List<String> tempSelected = List.from(selectedFilters);

    showStandardSheet(
      context,
      title: title,
      child: StatefulBuilder(
        builder: (ctx, setSheetState) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Select criteria to filter records:",
                style: Theme.of(ctx).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(ctx).colorScheme.onSurfaceVariant,
                    ),
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 8,
                runSpacing: 10,
                children: filterOptions.map((option) {
                  final isSelected = tempSelected.contains(option);
                  return FilterChip(
                    label: Text(option),
                    selected: isSelected,
                    onSelected: (selected) {
                      setSheetState(() {
                        if (selected) {
                          tempSelected.add(option);
                        } else {
                          tempSelected.remove(option);
                        }
                      });
                    },
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  );
                }).toList(),
              ),
              const SizedBox(height: 32),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        setSheetState(() => tempSelected.clear());
                        onReset();
                        Navigator.of(ctx).pop();
                      },
                      style: OutlinedButton.styleFrom(
                        minimumSize: const Size(0, 48),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                      ),
                      child: const Text("Reset All"),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: FilledButton(
                      onPressed: () {
                        onApply(tempSelected);
                        Navigator.of(ctx).pop();
                      },
                      style: FilledButton.styleFrom(
                        minimumSize: const Size(0, 48),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                      ),
                      child: const Text("Apply Filters", style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}

// ============================================================================
// 3. STANDARDIZE FORM EXPERIENCE & INPUT CONSISTENCY
// ============================================================================

class ProfileFormFields {
  /// Standardized Text / Multiline / Password / Email / Phone Input
  static Widget textField({
    required String label,
    String? hint,
    TextEditingController? controller,
    String? initialValue,
    IconData? prefixIcon,
    bool isPassword = false,
    bool isMultiline = false,
    bool isDisabled = false,
    bool isLoading = false,
    bool isSuccess = false,
    bool autofocus = false,
    int? maxLength,
    TextInputType keyboardType = TextInputType.text,
    TextInputAction textInputAction = TextInputAction.next,
    String? helperText,
    String? errorText,
    String? Function(String?)? validator,
    void Function(String)? onChanged,
    void Function(String)? onSubmitted,
  }) {
    // TODO:
    // Connect form validation to backend.
    return _ProfileTextFieldStateful(
      label: label,
      hint: hint,
      controller: controller,
      initialValue: initialValue,
      prefixIcon: prefixIcon,
      isPassword: isPassword,
      isMultiline: isMultiline,
      isDisabled: isDisabled,
      isLoading: isLoading,
      isSuccess: isSuccess,
      autofocus: autofocus,
      maxLength: maxLength,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      helperText: helperText,
      errorText: errorText,
      validator: validator,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
    );
  }

  /// Standardized Dropdown Input
  static Widget dropdown<T>({
    required String label,
    required T? value,
    required List<DropdownMenuItem<T>> items,
    required void Function(T?)? onChanged,
    IconData? prefixIcon,
    String? hint,
    bool isDisabled = false,
    bool isRequired = false,
    String? helperText,
    String? Function(T?)? validator,
  }) {
    return Builder(
      builder: (context) {
        final theme = Theme.of(context);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: theme.textTheme.labelMedium?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            DropdownButtonFormField<T>(
              initialValue: value,
              items: items,
              onChanged: isDisabled ? null : onChanged,
              validator: validator ?? (isRequired ? (v) => ProfileValidators.validateDropdown(v, label) : null),
              icon: const Icon(AppIcons.keyboard_arrow_down_rounded),
              decoration: InputDecoration(
                hintText: hint,
                helperText: helperText,
                prefixIcon: prefixIcon != null ? Icon(prefixIcon, size: 20) : null,
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: theme.dividerColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: theme.colorScheme.primary, width: 2),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  /// Standardized Chip Input / Tag Selector
  static Widget chipInput({
    required String label,
    required List<String> availableTags,
    required List<String> selectedTags,
    required Function(List<String>) onChanged,
  }) {
    return Builder(
      builder: (context) {
        final theme = Theme.of(context);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: theme.textTheme.labelMedium?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: availableTags.map((tag) {
                final isSelected = selectedTags.contains(tag);
                return FilterChip(
                  label: Text(tag),
                  selected: isSelected,
                  onSelected: (selected) {
                    final updated = List<String>.from(selectedTags);
                    if (selected) {
                      updated.add(tag);
                    } else {
                      updated.remove(tag);
                    }
                    onChanged(updated);
                  },
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                );
              }).toList(),
            ),
          ],
        );
      },
    );
  }
}

class _ProfileTextFieldStateful extends StatefulWidget {
  final String label;
  final String? hint;
  final TextEditingController? controller;
  final String? initialValue;
  final IconData? prefixIcon;
  final bool isPassword;
  final bool isMultiline;
  final bool isDisabled;
  final bool isLoading;
  final bool isSuccess;
  final bool autofocus;
  final int? maxLength;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final String? helperText;
  final String? errorText;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function(String)? onSubmitted;

  const _ProfileTextFieldStateful({
    required this.label,
    this.hint,
    this.controller,
    this.initialValue,
    this.prefixIcon,
    required this.isPassword,
    required this.isMultiline,
    required this.isDisabled,
    required this.isLoading,
    required this.isSuccess,
    required this.autofocus,
    this.maxLength,
    required this.keyboardType,
    required this.textInputAction,
    this.helperText,
    this.errorText,
    this.validator,
    this.onChanged,
    this.onSubmitted,
  });

  @override
  State<_ProfileTextFieldStateful> createState() => _ProfileTextFieldStatefulState();
}

class _ProfileTextFieldStatefulState extends State<_ProfileTextFieldStateful> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    Widget? suffix;
    if (widget.isLoading) {
      suffix = const Padding(
        padding: EdgeInsets.all(12),
        child: SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2)),
      );
    } else if (widget.isSuccess) {
      suffix = const Icon(AppIcons.check_circle_rounded, color: Colors.green, size: 20);
    } else if (widget.isPassword) {
      suffix = IconButton(
        icon: Icon(_obscureText ? AppIcons.visibility_off_outlined : AppIcons.visibility_outlined, size: 20),
        onPressed: () => setState(() => _obscureText = !_obscureText),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label, style: theme.textTheme.labelMedium?.copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(height: 6),
        TextFormField(
          controller: widget.controller,
          initialValue: widget.controller == null ? widget.initialValue : null,
          obscureText: _obscureText,
          enabled: !widget.isDisabled,
          autofocus: widget.autofocus,
          maxLength: widget.maxLength,
          maxLines: widget.isMultiline ? 4 : 1,
          keyboardType: widget.isMultiline ? TextInputType.multiline : widget.keyboardType,
          textInputAction: widget.isMultiline ? TextInputAction.newline : widget.textInputAction,
          validator: widget.validator,
          onChanged: widget.onChanged,
          onFieldSubmitted: widget.onSubmitted,
          style: TextStyle(color: widget.isDisabled ? theme.disabledColor : theme.colorScheme.onSurface),
          decoration: InputDecoration(
            hintText: widget.hint,
            helperText: widget.helperText,
            errorText: widget.errorText,
            prefixIcon: widget.prefixIcon != null ? Icon(widget.prefixIcon, size: 20) : null,
            suffixIcon: suffix,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: widget.isSuccess ? Colors.green : theme.dividerColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: widget.isSuccess ? Colors.green : theme.colorScheme.primary, width: 2),
            ),
          ),
        ),
      ],
    );
  }
}

// ============================================================================
// 4. STANDARDIZE BUTTON BEHAVIOR & MICRO-INTERACTIONS
// ============================================================================

enum ProfileButtonType { primary, secondary, outlined, text, danger }

class ProfileButton extends StatefulWidget {
  final String text;
  final VoidCallback? onPressed;
  final ProfileButtonType type;
  final IconData? icon;
  final bool isLoading;
  final bool isDisabled;
  final double? width;

  const ProfileButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.type = ProfileButtonType.primary,
    this.icon,
    this.isLoading = false,
    this.isDisabled = false,
    this.width,
  });

  @override
  State<ProfileButton> createState() => _ProfileButtonState();
}

class _ProfileButtonState extends State<ProfileButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    // TODO:
    // Replace dummy save actions.
    final theme = Theme.of(context);
    final effectiveDisabled = widget.isDisabled || widget.isLoading || widget.onPressed == null;

    Widget buttonContent = widget.isLoading
        ? SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: widget.type == ProfileButtonType.outlined || widget.type == ProfileButtonType.text
                  ? theme.colorScheme.primary
                  : Colors.white,
            ),
          )
        : Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (widget.icon != null) ...[
                Icon(widget.icon, size: 18),
                const SizedBox(width: 8),
              ],
              Text(
                widget.text,
                style: const TextStyle(fontWeight: FontWeight.bold),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          );

    Widget btn;
    final shape = RoundedRectangleBorder(borderRadius: BorderRadius.circular(24));
    final minimumSize = Size(widget.width ?? 0, 48);

    switch (widget.type) {
      case ProfileButtonType.primary:
        btn = FilledButton(
          onPressed: effectiveDisabled ? null : widget.onPressed,
          style: FilledButton.styleFrom(minimumSize: minimumSize, shape: shape),
          child: buttonContent,
        );
        break;
      case ProfileButtonType.secondary:
        btn = FilledButton.tonal(
          onPressed: effectiveDisabled ? null : widget.onPressed,
          style: FilledButton.styleFrom(minimumSize: minimumSize, shape: shape),
          child: buttonContent,
        );
        break;
      case ProfileButtonType.outlined:
        btn = OutlinedButton(
          onPressed: effectiveDisabled ? null : widget.onPressed,
          style: OutlinedButton.styleFrom(minimumSize: minimumSize, shape: shape),
          child: buttonContent,
        );
        break;
      case ProfileButtonType.text:
        btn = TextButton(
          onPressed: effectiveDisabled ? null : widget.onPressed,
          style: TextButton.styleFrom(minimumSize: minimumSize, shape: shape),
          child: buttonContent,
        );
        break;
      case ProfileButtonType.danger:
        btn = FilledButton(
          onPressed: effectiveDisabled ? null : widget.onPressed,
          style: FilledButton.styleFrom(
            minimumSize: minimumSize,
            shape: shape,
            backgroundColor: theme.colorScheme.error,
            foregroundColor: theme.colorScheme.onError,
          ),
          child: buttonContent,
        );
        break;
    }

    return Listener(
      onPointerDown: (_) {
        if (!effectiveDisabled) setState(() => _isPressed = true);
      },
      onPointerUp: (_) => setState(() => _isPressed = false),
      onPointerCancel: (_) => setState(() => _isPressed = false),
      child: AnimatedScale(
        scale: _isPressed ? 0.97 : 1.0,
        duration: const Duration(milliseconds: 120),
        curve: Curves.easeOutCubic,
        child: SizedBox(width: widget.width, child: btn),
      ),
    );
  }
}

// ============================================================================
// 5. SEARCH EXPERIENCE & FILTERS
// ============================================================================

class ProfileSearchField extends StatelessWidget {
  final String hint;
  final TextEditingController controller;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onClear;

  const ProfileSearchField({
    super.key,
    this.hint = "Search profile records...",
    required this.controller,
    this.onChanged,
    this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ValueListenableBuilder<TextEditingValue>(
      valueListenable: controller,
      builder: (context, value, _) {
        return TextField(
          controller: controller,
          onChanged: onChanged,
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: Icon(AppIcons.search_rounded, color: theme.colorScheme.onSurfaceVariant),
            suffixIcon: value.text.isNotEmpty
                ? IconButton(
                    icon: const Icon(AppIcons.clear_rounded, size: 20),
                    onPressed: () {
                      controller.clear();
                      if (onClear != null) onClear!();
                      if (onChanged != null) onChanged!("");
                    },
                  )
                : null,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(24), borderSide: BorderSide.none),
            filled: true,
            fillColor: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
          ),
        );
      },
    );
  }
}

class ProfileEmptySearchDisplay extends StatelessWidget {
  final String query;
  final VoidCallback? onReset;
  const ProfileEmptySearchDisplay({super.key, required this.query, this.onReset});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AppCard(
      padding: const EdgeInsets.all(32),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(AppIcons.search_off_rounded, size: 48, color: theme.colorScheme.onSurfaceVariant),
            const SizedBox(height: 16),
            Text(
              "No results found for \"$query\"",
              style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              "Try checking for spelling errors or searching with broader keywords.",
              style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant),
              textAlign: TextAlign.center,
            ),
            if (onReset != null) ...[
              const SizedBox(height: 20),
              OutlinedButton(
                onPressed: onReset,
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                ),
                child: const Text("Clear Search"),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// ============================================================================
// 6. NAVIGATION & UNSAVED CHANGES PROTECTION
// ============================================================================

class ProfileNavigationUtils {
  /// Protects against accidental loss of unsaved form data when navigating away or closing screens.
  static void confirmUnsavedChanges(
    BuildContext context, {
    required bool hasUnsavedChanges,
    required VoidCallback onProceed,
  }) {
    if (!hasUnsavedChanges) {
      onProceed();
      return;
    }

    ProfileDialogs.showDiscardChangesDialog(context, onProceed);
  }
}
