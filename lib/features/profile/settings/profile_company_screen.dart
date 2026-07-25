import 'package:flutter/material.dart';
import 'package:jobnest/core/widgets/app_card.dart';

class ProfileCompanyScreen extends StatelessWidget {
  const ProfileCompanyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        backgroundColor: theme.colorScheme.surface,
        elevation: 0,
        title: const Text("Company Profile"),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
            child: AppCard(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Edit Company Details",
                    style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 24),
                  _buildTextField(context, "Company Name", "TechNova Solutions"),
                  const SizedBox(height: 16),
                  _buildTextField(context, "Industry", "Software & Technology"),
                  const SizedBox(height: 16),
                  _buildTextField(context, "Company Size", "500 - 1000 Employees"),
                  const SizedBox(height: 16),
                  _buildTextField(context, "Website", "https://technova.dev"),
                  const SizedBox(height: 16),
                  _buildTextField(context, "Headquarters", "Koramangala, Bangalore"),
                  const SizedBox(height: 32),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: () {},
                      style: FilledButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: const Text("Save Changes"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(BuildContext context, String label, String hint) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          decoration: InputDecoration(
            hintText: hint,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          ),
        ),
      ],
    );
  }
}
