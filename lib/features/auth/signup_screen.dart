import 'package:flutter/material.dart';
import 'package:jobnest/core/widgets/app_button.dart';
import 'package:jobnest/core/widgets/app_textfield.dart';
import 'package:jobnest/core/widgets/app_dropdown_field.dart';
import 'package:jobnest/core/widgets/app_card.dart';
import 'package:jobnest/features/auth/advanced_setup_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  int _currentStep = 1;

  void _nextStep() {
    if (_currentStep < 5) {
      setState(() => _currentStep++);
    } else {
      // TODO: Future authentication backend yaha connect hoga.
      // TODO: Session token validation backend se hogi.
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const AdvancedSetupScreen()),
      );
    }
  }

  void _prevStep() {
    if (_currentStep > 1) {
      setState(() => _currentStep--);
    } else {
      Navigator.pop(context); // Go back to Login
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: theme.colorScheme.onSurface),
          onPressed: _prevStep,
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            _buildStepIndicator(theme),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24.0),
                child: AppCard(
                  child: _buildCurrentStep(theme),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _currentStep < 5
          ? Padding(
              padding: const EdgeInsets.all(24.0),
              child: AppButton(
                text: "Continue",
                onPressed: _nextStep,
              ),
            )
          : null, // Step 5 has button inside
    );
  }

  // Custom Step Indicator (1, 2, 3, 4, 5)
  Widget _buildStepIndicator(ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(5, (index) {
          int step = index + 1;
          bool isActive = step <= _currentStep;
          return Row(
            children: [
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: isActive ? theme.colorScheme.primary : theme.colorScheme.surfaceContainerHighest,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    step.toString(),
                    style: TextStyle(
                      color: isActive ? theme.colorScheme.onPrimary : theme.colorScheme.onSurfaceVariant,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              if (step < 5)
                Container(
                  width: MediaQuery.of(context).size.width * 0.08,
                  height: 2,
                  color: isActive ? theme.colorScheme.primary : theme.colorScheme.surfaceContainerHighest,
                ),
            ],
          );
        }),
      ),
    );
  }

  // Switch Case to change forms dynamically
  Widget _buildCurrentStep(ThemeData theme) {
    switch (_currentStep) {
      case 1:
        return _buildStep1(theme);
      case 2:
        return _buildStep2(theme);
      case 3:
        return _buildStep3(theme);
      case 4:
        return _buildStep4(theme);
      case 5:
        return _buildStep5(theme);
      default:
        return _buildStep1(theme);
    }
  }

  // STEP 1: Account Creation
  Widget _buildStep1(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Create Your Account", style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Text("Let's get started with your details", style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
        const SizedBox(height: 30),
        _buildTextField("Full Name", Icons.person_outline),
        const SizedBox(height: 16),
        _buildTextField("Work Email", Icons.email_outlined),
        const SizedBox(height: 16),
        _buildTextField("Mobile Number", Icons.phone_outlined, prefix: "+91 "),
        const SizedBox(height: 16),
        _buildTextField("Password", Icons.lock_outline, isPassword: true),
        const SizedBox(height: 24),
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Already have an account? ",
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Text(
                  "Login",
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // STEP 2: Company Information
  Widget _buildStep2(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Company Information", style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Text("Tell us about your company", style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
        const SizedBox(height: 30),
        _buildTextField("Company Name", Icons.business),
        const SizedBox(height: 16),
        _buildDropdownField("Industry Type", Icons.category_outlined),
        const SizedBox(height: 16),
        _buildDropdownField("Company Size", Icons.groups_outlined),
        const SizedBox(height: 16),
        _buildTextField("Company Website (optional)", Icons.language),
      ],
    );
  }

  // STEP 3: Work Details
  Widget _buildStep3(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Work Details", style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Text("What is your role in hiring?", style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
        const SizedBox(height: 30),
        _buildDropdownField("Role (HR / Recruiter / Founder)", Icons.badge_outlined),
        const SizedBox(height: 16),
        _buildDropdownField("Hiring Type", Icons.work_outline),
        const SizedBox(height: 16),
        _buildTextField("Location", Icons.location_on_outlined),
      ],
    );
  }

  // STEP 4: Verification
  Widget _buildStep4(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Verify Your Account", style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Text("We need to verify your email and mobile", style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
        const SizedBox(height: 30),
        Text("Email OTP Verification", style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        _buildTextField("Enter Email OTP", Icons.mark_email_read_outlined),
        const SizedBox(height: 24),
        Text("Mobile OTP Verification", style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        _buildTextField("Enter Mobile OTP", Icons.sms_outlined),
      ],
    );
  }

  // STEP 5: Setup Complete
  Widget _buildStep5(ThemeData theme) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 40),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: theme.colorScheme.primaryContainer,
            shape: BoxShape.circle,
          ),
          child: Icon(Icons.check_circle, color: theme.colorScheme.primary, size: 80),
        ),
        const SizedBox(height: 24),
        Text("Setup Complete!", style: theme.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        Text("Your account has been created successfully.", textAlign: TextAlign.center, style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant, fontSize: 16)),
        const SizedBox(height: 50),
        AppButton(
          text: "Go to Dashboard",
          onPressed: _nextStep,
        ),
      ],
    );
  }

  // Reusable TextField wrapper
  Widget _buildTextField(String hint, IconData icon, {bool isPassword = false, String? prefix}) {
    return AppTextField(
      hint: hint,
      icon: icon,
      isPassword: isPassword,
      prefixText: prefix,
    );
  }

  // Reusable Dropdown wrapper
  Widget _buildDropdownField(String hint, IconData icon) {
    return AppDropdownField(
      hint: hint,
      icon: icon,
    );
  }
}
