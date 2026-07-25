import 'package:flutter/material.dart';
import 'package:jobnest/core/widgets/app_card.dart';
import 'package:jobnest/features/candidates/candidate_profile_screen.dart';

class CandidateListCard extends StatefulWidget {
  final String name;
  final String role;
  final String location;
  final String experience;
  final List<String> skills;
  final int matchPercentage;
  final double score;

  const CandidateListCard({
    super.key,
    required this.name,
    required this.role,
    required this.location,
    required this.experience,
    required this.skills,
    required this.matchPercentage,
    required this.score,
  });

  @override
  State<CandidateListCard> createState() => _CandidateListCardState();
}

class _CandidateListCardState extends State<CandidateListCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: Matrix4.translationValues(0, _isHovered ? -2 : 0, 0),
        child: AppCard(
          padding: EdgeInsets.zero,
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CandidateProfileScreen(
                    name: widget.name,
                    role: widget.role,
                    location: widget.location,
                    experience: widget.experience,
                  ),
                ),
              );
            },
            borderRadius: BorderRadius.circular(20),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 28,
                        backgroundColor: theme.colorScheme.primaryContainer,
                        child: Text(
                          widget.name[0],
                          style: theme.textTheme.titleLarge?.copyWith(
                            color: theme.colorScheme.onPrimaryContainer,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.name,
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              widget.role,
                              style: theme.textTheme.labelMedium?.copyWith(
                                color: theme.colorScheme.primary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.deepPurpleAccent.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          "${widget.matchPercentage}% Match",
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: Colors.deepPurpleAccent,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      _buildIconLabel(context, Icons.location_on_rounded, widget.location),
                      const SizedBox(width: 16),
                      _buildIconLabel(context, Icons.work_history_rounded, widget.experience),
                      const SizedBox(width: 16),
                      _buildIconLabel(context, Icons.star_rounded, "Score: ${widget.score}"),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: widget.skills.map((s) => _buildSkillTag(context, s)).toList(),
                  ),
                  const SizedBox(height: 20),
                  const Divider(),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      OutlinedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CandidateProfileScreen(
                                name: widget.name,
                                role: widget.role,
                                location: widget.location,
                                experience: widget.experience,
                              ),
                            ),
                          );
                        },
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        child: const Text("View Profile"),
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.chat_bubble_outline_rounded, size: 20),
                            tooltip: "Message",
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.close_rounded, size: 20, color: Colors.red),
                            tooltip: "Reject",
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.check_rounded, size: 20, color: Colors.green),
                            tooltip: "Shortlist",
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIconLabel(BuildContext context, IconData icon, String label) {
    final theme = Theme.of(context);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: theme.colorScheme.onSurfaceVariant),
        const SizedBox(width: 4),
        Text(
          label,
          style: theme.textTheme.labelMedium?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }

  Widget _buildSkillTag(BuildContext context, String label) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        label,
        style: theme.textTheme.labelSmall?.copyWith(
          color: theme.colorScheme.onSurface,
        ),
      ),
    );
  }
}
