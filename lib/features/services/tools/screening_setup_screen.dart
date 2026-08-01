import 'package:flutter/material.dart';
import 'package:jobnest/core/widgets/app_card.dart';

class ScreeningSetupScreen extends StatefulWidget {
  const ScreeningSetupScreen({super.key});

  @override
  State<ScreeningSetupScreen> createState() => _ScreeningSetupScreenState();
}

class _ScreeningSetupScreenState extends State<ScreeningSetupScreen> {
  bool _autoScreen = true;
  bool _aiRanking = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // ===== BACKEND TODO =====
    // TODO: Screening setup future me save hogi backend me.
    return Scaffold(
      // backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        // backgroundColor: theme.colorScheme.surface,
        elevation: 0,
        title: const Text("Screening Setup"),
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text("Save Changes"),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1000),
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppCard(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Automation Rules",
                        style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 16),
                      SwitchListTile(
                        value: _autoScreen,
                        onChanged: (val) => setState(() => _autoScreen = val),
                        title: const Text("Auto Reject Candidates"),
                        subtitle: const Text("Automatically reject candidates who do not meet minimum criteria."),
                        activeTrackColor: Colors.deepPurpleAccent.withValues(alpha: 0.5),
                        activeThumbColor: Colors.deepPurpleAccent,
                        contentPadding: EdgeInsets.zero,
                      ),
                      const Divider(),
                      SwitchListTile(
                        value: _aiRanking,
                        onChanged: (val) => setState(() => _aiRanking = val),
                        title: const Text("AI Candidate Ranking"),
                        subtitle: const Text("Sort incoming applications based on AI match score rather than date."),
                        activeTrackColor: Colors.deepPurpleAccent.withValues(alpha: 0.5),
                        activeThumbColor: Colors.deepPurpleAccent,
                        contentPadding: EdgeInsets.zero,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                
                Text(
                  "Minimum Criteria",
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    letterSpacing: -0.3,
                  ),
                ),
                const SizedBox(height: 16),
                
                AppCard(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: _buildTextField("Minimum Experience", "e.g., 3 Years"),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: _buildTextField("Minimum Education", "e.g., Bachelor's Degree"),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      Row(
                        children: [
                          Expanded(
                            child: _buildTextField("Salary Range Max", "e.g., 20LPA"),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: _buildTextField("Location", "e.g., Remote / India"),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      _buildTextField("Required Skills (Comma separated)", "Flutter, Dart, Firebase"),
                      const SizedBox(height: 24),
                      _buildTextField("Availability / Notice Period", "e.g., 30 Days max"),
                    ],
                  ),
                ),
                const SizedBox(height: 48),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, String hint) {
    return TextField(
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      ),
    );
  }
}
