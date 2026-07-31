import '../../../../core/constants/app_icons.dart';
import 'package:flutter/material.dart';

import '../../../../shared/widgets/app_buttons.dart';
import '../../../../shared/widgets/app_logo.dart';
import '../../../../shared/widgets/app_text_field.dart';
import '../../data/models/auth_requests.dart';
import '../providers/auth_provider.dart';
import '../providers/auth_state.dart';
import '../widgets/auth_foundation.dart';

class LoginScreen extends StatefulWidget {
  final AuthProvider authProvider;
  final VoidCallback onLoginSuccess;
  final VoidCallback onForgotPassword;

  const LoginScreen({
    super.key,
    required this.authProvider,
    required this.onLoginSuccess,
    required this.onForgotPassword,
  });

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  
  bool _rememberMe = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  void _handleLogin() async {
    // Dismiss keyboard on submit
    FocusScope.of(context).unfocus();

    if (_formKey.currentState?.validate() ?? false) {
      // Ensure we don't proceed if already loading
      if (widget.authProvider.state.status == AuthStatus.loading) return;

      final request = LoginRequest(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );

      await widget.authProvider.login(request);

      if (mounted && widget.authProvider.state.status == AuthStatus.authenticated) {
        widget.onLoginSuccess();
      }
    }
  }

  String? _validateEmail(String? value) {
    final trimmedValue = value?.trim();
    if (trimmedValue == null || trimmedValue.isEmpty) {
      return 'Email is required';
    }
    // Basic email validation regex
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(trimmedValue)) {
      return 'Enter a valid corporate email address';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters long';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: AuthCard(
              child: ListenableBuilder(
                listenable: widget.authProvider,
                builder: (context, _) {
                  final state = widget.authProvider.state;
                  final isLoading = state.status == AuthStatus.loading;

                  return FocusTraversalGroup(
                    policy: WidgetOrderTraversalPolicy(),
                    child: Form(
                      key: _formKey,
                      child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const AuthHeader(
                          title: 'Welcome Back',
                          subtitle: 'Log in to your JobNest Enterprise account.',
                          topWidget: AppLogo(size: 80),
                        ),
                        const SizedBox(height: 32),

                        // Error Message Display
                        if (state.status == AuthStatus.error && state.errorMessage != null)
                          Container(
                            padding: const EdgeInsets.all(12),
                            margin: const EdgeInsets.only(bottom: 24),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.errorContainer,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              state.errorMessage!,
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.onErrorContainer,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),

                        AppTextField(
                          label: 'Email',
                          hint: 'Enter your corporate email',
                          prefixIcon: const Icon(AppIcons.email_outlined),
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          validator: _validateEmail,
                          enabled: !isLoading,
                        ),
                        const SizedBox(height: 20),

                        AppTextField(
                          label: 'Password',
                          hint: 'Enter your password',
                          prefixIcon: const Icon(AppIcons.lock_outline),
                          isPassword: true,
                          controller: _passwordController,
                          validator: _validatePassword,
                          enabled: !isLoading,
                        ),
                        const SizedBox(height: 16),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            RememberMeCheckbox(
                              value: _rememberMe,
                              onChanged: isLoading
                                  ? (val) {}
                                  : (value) {
                                      setState(() {
                                        _rememberMe = value ?? false;
                                      });
                                    },
                            ),
                            ForgotPasswordButton(
                              onPressed: isLoading ? () {} : widget.onForgotPassword,
                            ),
                          ],
                        ),
                        const SizedBox(height: 32),

                        AppPrimaryButton(
                          text: 'Log In',
                          isLoading: isLoading,
                          onPressed: _handleLogin,
                          icon: AppIcons.login,
                        ),
                      ],
                    ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
