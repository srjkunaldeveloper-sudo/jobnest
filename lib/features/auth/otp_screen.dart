import '../../core/constants/app_icons.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pinput/pinput.dart';

import 'package:jobnest/core/constants/app_spacing.dart';
import 'package:jobnest/core/constants/app_text.dart';
import 'package:jobnest/core/constants/app_radius.dart';
import 'package:jobnest/core/widgets/app_button.dart';

class OtpContent extends StatefulWidget {
  final String title;
  final String subtitlePrefix;
  final String contactInfo;
  final VoidCallback onVerify;
  final VoidCallback onBack;
  final String buttonText;

  const OtpContent({
    super.key,
    this.title = "Verify OTP",
    this.subtitlePrefix = "Enter the 6-digit code sent to\n",
    required this.contactInfo,
    required this.onVerify,
    required this.onBack,
    this.buttonText = "Verify & Login",
  });

  @override
  State<OtpContent> createState() => _OtpContentState();
}

class _OtpContentState extends State<OtpContent> {
  final TextEditingController _otpController = TextEditingController();
  final FocusNode _otpFocusNode = FocusNode();
  
  bool _isLoading = false;
  String? _otpError;
  int _timerSeconds = 30;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _otpFocusNode.requestFocus();
    });
  }

  void _startTimer() {
    setState(() => _timerSeconds = 30);
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timerSeconds > 0) {
        setState(() => _timerSeconds--);
      } else {
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _otpController.dispose();
    _otpFocusNode.dispose();
    super.dispose();
  }

  String get maskedContact {
    if (widget.contactInfo.contains('@')) {
      return widget.contactInfo; 
    }
    if (widget.contactInfo.length >= 10) {
      final last4 = widget.contactInfo.substring(widget.contactInfo.length - 5);
      return "+91 XXXXX$last4";
    }
    return widget.contactInfo;
  }

  void _handleVerifyOtp() async {
    final otp = _otpController.text.trim();

    // Validate empty or partial OTP (must be exactly 6 digits)
    if (otp.length != 6) {
      setState(() {
        _otpError = "Please enter the complete 6-digit OTP code";
      });
      return;
    }

    // Validate only numeric input
    if (!RegExp(r'^[0-9]+$').hasMatch(otp)) {
      setState(() {
        _otpError = "Only numeric input is allowed";
      });
      return;
    }

    // Dummy OTP validation (for QA/testing: 123456 or 000000 is correct, anything else is incorrect)
    if (otp != "123456" && otp != "000000") {
      setState(() {
        _otpError = "Invalid OTP code. Please try again (Use 123456)";
      });
      return;
    }

    setState(() {
      _otpError = null;
      _isLoading = true;
    });

    // ===== BACKEND TODO =====
    // TODO:
    // OTP service integration.
    // TODO:
    // Expiry validation from backend.
    // TODO:
    // Rate limiting.

    await Future.delayed(const Duration(seconds: 1));

    if (!mounted) return;
    
    widget.onVerify();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: theme.textTheme.headlineSmall?.copyWith(
        fontWeight: FontWeight.bold,
      ),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: AppRadius.medium,
        border: Border.all(color: theme.dividerColor),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: theme.colorScheme.primary, width: 2),
    );

    final submittedPinTheme = defaultPinTheme.copyDecorationWith(
      color: theme.colorScheme.surfaceContainerHighest,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: widget.onBack,
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: theme.colorScheme.surfaceContainerHighest,
            ),
            child: Icon(
              AppIcons.arrow_back,
              size: 20,
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ),
        AppSpacing.h24,
        Text(
          widget.title,
          style: theme.textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        AppSpacing.h8,
        Text.rich(
          TextSpan(
            text: widget.subtitlePrefix,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
              height: 1.5,
            ),
            children: [
              TextSpan(
                text: maskedContact,
                style: TextStyle(
                  color: theme.colorScheme.onSurface,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        AppSpacing.h48,
        
        Center(
          child: Pinput(
            length: 6,
            controller: _otpController,
            focusNode: _otpFocusNode,
            defaultPinTheme: defaultPinTheme,
            focusedPinTheme: focusedPinTheme,
            submittedPinTheme: submittedPinTheme,
            errorText: _otpError,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            onChanged: (value) {
              if (_otpError != null) {
                 setState(() => _otpError = null);
              }
            },
            onCompleted: (pin) => _handleVerifyOtp(),
          ),
        ),
        
        AppSpacing.h32,
        
        Center(
          child: _timerSeconds > 0
              ? Text(
                  "Resend code in 00:${_timerSeconds.toString().padLeft(2, '0')}",
                  style: AppText.body.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                )
              : TextButton(
                  onPressed: () {
                    _startTimer();
                    _otpController.clear();
                    _otpFocusNode.requestFocus();
                    if (_otpError != null) {
                      setState(() => _otpError = null);
                    }
                    // ===== BACKEND TODO =====
                    // TODO:
                    // Resend OTP API.
                    // TODO:
                    // Rate limiting.
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: theme.colorScheme.primary,
                  ),
                  child: const Text(
                    "Resend OTP",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
        ),
        
        AppSpacing.h24,
        
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              AppIcons.lock_outline,
              size: 16,
              color: theme.colorScheme.onSurfaceVariant,
            ),
            AppSpacing.w8,
            Text(
              "Your data is encrypted and secure.",
              style: AppText.caption.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
        AppSpacing.h16,
        
        AppButton(
          text: _isLoading ? "Verifying..." : widget.buttonText,
          isLoading: _isLoading,
          onPressed: _handleVerifyOtp,
        ),
      ],
    );
  }
}
