# Implementation Plan - Fix Errors in Dashboard Files

This plan addresses several errors and warnings found in the dashboard feature files, primarily focusing on fixing broken imports, missing icons, and unused variables.

## User Review Required

> [!IMPORTANT]
> I will be changing `AppIcons.notifications` to `AppIcons.notifications_outlined` in `dashboard_header.dart` as the former does not exist in the `AppIcons` class.

## Proposed Changes

### Dashboard Feature

#### [MODIFY] [dashboard_header.dart](file:///Users/macbook/AndroidStudioProjects/jobnest/lib/features/dashboard/presentation/widgets/dashboard_header.dart)
- Fix broken relative import of `app_icons.dart`.
- Replace undefined `AppIcons.notifications` with `AppIcons.notifications_outlined`.
- Remove unused `isDark` variable.
- Remove unused `_isTablet` function.

#### [MODIFY] [dashboard_screen.dart](file:///Users/macbook/AndroidStudioProjects/jobnest/lib/features/dashboard/presentation/screens/dashboard_screen.dart)
- Remove unused import of `dashboard_app_bar.dart`.

## Verification Plan

### Manual Verification
- Run `analyze_file` on the modified files to ensure all errors and warnings are resolved.
