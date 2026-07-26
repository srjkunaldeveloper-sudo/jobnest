import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/widgets/app_card.dart';
import '../providers/profile_data_provider.dart';
import '../widgets/profile_validation_utils.dart';

class ProfileTeamScreen extends StatefulWidget {
  const ProfileTeamScreen({super.key});

  @override
  State<ProfileTeamScreen> createState() => _ProfileTeamScreenState();
}

class _ProfileTeamScreenState extends State<ProfileTeamScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO:
    // Fetch roles.

    // TODO:
    // Update permissions.

    // TODO:
    // Assign role API.

    // TODO:
    // Custom permission sync.

    // TODO:
    // Role audit logs.

    // TODO:
    // Fetch team members.

    // TODO:
    // Invite team member API.

    final provider = Provider.of<ProfileDataProvider>(context);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Team Management & Roles"),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () => provider.toggleTeamEmptyState(),
            icon: Icon(
              provider.isTeamEmpty
                  ? Icons.people_alt_rounded
                  : Icons.group_off_outlined,
            ),
            tooltip: provider.isTeamEmpty
                ? "Show Populated Team"
                : "Simulate Empty Team State",
          ),
          const SizedBox(width: 8),
        ],
        bottom: TabBar(
          controller: _tabController,
          labelColor: theme.colorScheme.primary,
          unselectedLabelColor: theme.colorScheme.onSurfaceVariant,
          indicatorColor: theme.colorScheme.primary,
          indicatorWeight: 3,
          tabs: const [
            Tab(
              icon: Icon(Icons.people_outline_rounded, size: 20),
              text: "Team Members",
            ),
            Tab(
              icon: Icon(Icons.admin_panel_settings_outlined, size: 20),
              text: "Role Directory",
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildTeamMembersTab(context, provider),
          _buildRoleDirectoryTab(context, provider),
        ],
      ),
      floatingActionButton: _tabController.index == 0 && !provider.isTeamEmpty
          ? FloatingActionButton.extended(
              onPressed: () => _showInviteMemberDialog(context, provider),
              icon: const Icon(Icons.person_add_outlined),
              label: const Text("Invite Member"),
            )
          : null,
    );
  }

  Widget _buildTeamMembersTab(
    BuildContext context,
    ProfileDataProvider provider,
  ) {
    final theme = Theme.of(context);
    final members = provider.filteredTeamMembers;
    final filters = [
      "All",
      "Admin",
      "HR Manager",
      "Recruiter",
      "Hiring Manager",
      "Viewer",
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 900),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Banner / Description
              AppCard(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primaryContainer,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        Icons.shield_outlined,
                        color: theme.colorScheme.primary,
                        size: 26,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Enterprise Access Control",
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "Assign granular permissions and roles to recruiter team members. Manage access across 10 core modules.",
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Search Bar & Filter Chips
              if (!provider.isTeamEmpty) ...[
                TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText:
                        "Search team by name, email, or role...",
                    prefixIcon: const Icon(Icons.search_rounded),
                    suffixIcon: _searchController.text.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              _searchController.clear();
                              provider.updateTeamSearchQuery("");
                            },
                          )
                        : null,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                    fillColor: theme.colorScheme.surfaceContainerHighest
                        .withValues(alpha: 0.3),
                  ),
                  onChanged: (val) => provider.updateTeamSearchQuery(val),
                ),
                const SizedBox(height: 12),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: filters.map((filter) {
                      final isSelected =
                          provider.teamRoleFilter == filter;
                      return Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: FilterChip(
                          label: Text(filter),
                          selected: isSelected,
                          onSelected: (selected) {
                            provider.updateTeamRoleFilter(
                              selected ? filter : "All",
                            );
                          },
                          selectedColor: theme.colorScheme.primaryContainer,
                          labelStyle: TextStyle(
                            color: isSelected
                                ? theme.colorScheme.onPrimaryContainer
                                : theme.colorScheme.onSurface,
                            fontWeight: isSelected
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 16),
              ],

              // Members List or Empty State
              if (provider.isTeamEmpty || members.isEmpty)
                _buildEmptyState(context, provider)
              else
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: members.length,
                  separatorBuilder: (ctx, index) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final member = members[index];
                    return _buildMemberCard(context, provider, member);
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState(
    BuildContext context,
    ProfileDataProvider provider,
  ) {
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 24),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest
            .withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: theme.colorScheme.outline.withValues(alpha: 0.2),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.group_off_rounded,
            size: 64,
            color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
          ),
          const SizedBox(height: 16),
          Text(
            "No team members available.",
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            "Invite recruiter colleagues and hiring managers to collaborate on job requisitions and candidate pipelines.",
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () => _showInviteMemberDialog(context, provider),
            icon: const Icon(Icons.person_add_outlined),
            label: const Text("Add Team Member"),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMemberCard(
    BuildContext context,
    ProfileDataProvider provider,
    TeamMemberItem member,
  ) {
    final theme = Theme.of(context);
    final isUser = member.id == "1"; // Sonu Surya

    Color roleColor;
    switch (member.role) {
      case "Admin":
        roleColor = Colors.purple;
        break;
      case "HR Manager":
        roleColor = Colors.blue;
        break;
      case "Recruiter":
        roleColor = Colors.teal;
        break;
      case "Hiring Manager":
        roleColor = Colors.orange;
        break;
      default:
        roleColor = Colors.grey;
    }

    return AppCard(
      padding: const EdgeInsets.all(16),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) =>
                  _MemberRolePermissionsScreen(member: member),
            ),
          );
        },
        borderRadius: BorderRadius.circular(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundColor: roleColor.withValues(alpha: 0.15),
                  child: Text(
                    member.name.isNotEmpty
                        ? member.name.substring(0, 1).toUpperCase()
                        : "?",
                    style: TextStyle(
                      color: roleColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        spacing: 8,
                        children: [
                          Text(
                            member.name,
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          if (isUser)
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: theme.colorScheme.secondaryContainer,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                "YOU",
                                style: theme.textTheme.labelSmall?.copyWith(
                                  color:
                                      theme.colorScheme.onSecondaryContainer,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10,
                                ),
                              ),
                            ),
                          if (member.status == "Invited")
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.amber.withValues(alpha: 0.2),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                "INVITED",
                                style: theme.textTheme.labelSmall?.copyWith(
                                  color: Colors.amber.shade800,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10,
                                ),
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 2),
                      Text(
                        member.email,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Icon(
                  Icons.chevron_right_rounded,
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ],
            ),
            const SizedBox(height: 14),
            Divider(
              height: 1,
              color: theme.colorScheme.outline.withValues(alpha: 0.15),
            ),
            const SizedBox(height: 12),
            Wrap(
              alignment: WrapAlignment.spaceBetween,
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 8,
              runSpacing: 8,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: roleColor.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: roleColor.withValues(alpha: 0.3),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.badge_outlined,
                              size: 14, color: roleColor),
                          const SizedBox(width: 6),
                          Text(
                            member.role,
                            style: theme.textTheme.labelSmall?.copyWith(
                              color: roleColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (member.hasCustomPermissions) ...[
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.tertiaryContainer,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.tune_rounded,
                              size: 12,
                              color: theme.colorScheme.onTertiaryContainer,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              "Custom Permissions",
                              style: theme.textTheme.labelSmall?.copyWith(
                                color:
                                    theme.colorScheme.onTertiaryContainer,
                                fontWeight: FontWeight.bold,
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
                TextButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            _MemberRolePermissionsScreen(member: member),
                      ),
                    );
                  },
                  icon: const Icon(Icons.security_rounded, size: 16),
                  label: const Text("Role & Permissions"),
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    minimumSize: const Size(0, 32),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRoleDirectoryTab(
    BuildContext context,
    ProfileDataProvider provider,
  ) {
    final theme = Theme.of(context);
    final roles = provider.roleSummaries;

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 900),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppCard(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.secondaryContainer,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        Icons.admin_panel_settings_rounded,
                        color: theme.colorScheme.onSecondaryContainer,
                        size: 26,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Default Role Specifications",
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "Review enterprise access tiers and their corresponding module permissions. Custom overrides can be applied per team member.",
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: roles.length,
                separatorBuilder: (ctx, index) => const SizedBox(height: 14),
                itemBuilder: (context, index) {
                  final role = roles[index];
                  return _buildRoleSummaryCard(context, role);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRoleSummaryCard(BuildContext context, RoleSummary role) {
    final theme = Theme.of(context);
    Color roleColor;
    IconData roleIcon;

    switch (role.name) {
      case "Admin":
        roleColor = Colors.purple;
        roleIcon = Icons.shield_rounded;
        break;
      case "HR Manager":
        roleColor = Colors.blue;
        roleIcon = Icons.manage_accounts_rounded;
        break;
      case "Recruiter":
        roleColor = Colors.teal;
        roleIcon = Icons.person_search_rounded;
        break;
      case "Hiring Manager":
        roleColor = Colors.orange;
        roleIcon = Icons.fact_check_rounded;
        break;
      default:
        roleColor = Colors.grey;
        roleIcon = Icons.visibility_rounded;
    }

    return AppCard(
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: roleColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(roleIcon, color: roleColor, size: 24),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      role.name,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: roleColor,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      "${role.memberCount} Assigned Member${role.memberCount == 1 ? '' : 's'}",
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            role.description,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceContainerHighest
                  .withValues(alpha: 0.4),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.key_outlined,
                  size: 16,
                  color: theme.colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    "Permissions: ${role.permissionSummary}",
                    style: theme.textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showInviteMemberDialog(
    BuildContext context,
    ProfileDataProvider provider,
  ) {
    final nameController = TextEditingController();
    final emailController = TextEditingController();
    String selectedRole = "Recruiter";
    final formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text("Invite Team Member"),
          content: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 400),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Enter member details and assign an initial role. They will receive an email invitation.",
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Theme.of(context)
                                .colorScheme
                                .onSurfaceVariant,
                          ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        labelText: "Full Name",
                        prefixIcon: Icon(Icons.person_outline_rounded),
                        border: OutlineInputBorder(),
                      ),
                      validator: (v) => ProfileValidators.validateRequired(v, "Full Name"),
                    ),
                    const SizedBox(height: 14),
                    TextFormField(
                      controller: emailController,
                      decoration: const InputDecoration(
                        labelText: "Email Address",
                        prefixIcon: Icon(Icons.email_outlined),
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (v) => ProfileValidators.validateEmail(v),
                    ),
                    const SizedBox(height: 14),
                    DropdownButtonFormField<String>(
                      initialValue: selectedRole,
                      decoration: const InputDecoration(
                        labelText: "Assign Role",
                        prefixIcon: Icon(Icons.badge_outlined),
                        border: OutlineInputBorder(),
                      ),
                      items: [
                        "Admin",
                        "HR Manager",
                        "Recruiter",
                        "Hiring Manager",
                        "Viewer",
                      ].map((role) {
                        return DropdownMenuItem(
                          value: role,
                          child: Text(role),
                        );
                      }).toList(),
                      onChanged: (val) {
                        if (val != null) setState(() => selectedRole = val);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  provider.addTeamMember(
                    name: nameController.text.trim(),
                    email: emailController.text.trim(),
                    role: selectedRole,
                  );
                  Navigator.pop(ctx);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        "Invitation sent to ${emailController.text.trim()} as $selectedRole",
                      ),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                }
              },
              child: const Text("Send Invite"),
            ),
          ],
        ),
      ),
    );
  }
}

// =========================================================
// MEMBER ROLE & PERMISSIONS DETAILS SCREEN
// =========================================================

class _MemberRolePermissionsScreen extends StatefulWidget {
  final TeamMemberItem member;

  const _MemberRolePermissionsScreen({required this.member});

  @override
  State<_MemberRolePermissionsScreen> createState() =>
      _MemberRolePermissionsScreenState();
}

class _MemberRolePermissionsScreenState
    extends State<_MemberRolePermissionsScreen> {
  late String _currentRole;

  @override
  void initState() {
    super.initState();
    _currentRole = widget.member.role;
  }

  void _showRoleConfirmDialog(BuildContext context, String newRole) {
    final provider = Provider.of<ProfileDataProvider>(context, listen: false);
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Confirm Role Change"),
        content: Text(
          "Change role for ${widget.member.name} from $_currentRole to $newRole?\n\nThis will reset their module permissions to the $newRole default specifications.",
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              provider.assignRoleToMember(widget.member.id, newRole);
              setState(() {
                _currentRole = newRole;
              });
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    "Role updated to $newRole. Default permissions applied.",
                  ),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.primary,
              foregroundColor: Theme.of(context).colorScheme.onPrimary,
            ),
            child: const Text("Confirm Change"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProfileDataProvider>(context);
    final theme = Theme.of(context);

    // Get live member from provider to reflect changes
    final currentMember = provider.teamMembers.firstWhere(
      (m) => m.id == widget.member.id,
      orElse: () => widget.member,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text("${currentMember.name} - Access Control"),
        actions: [
          if (currentMember.id != "1")
            IconButton(
              icon: Icon(Icons.delete_outline_rounded,
                  color: theme.colorScheme.error),
              tooltip: "Remove Team Member",
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: const Text("Remove Team Member?"),
                    content: Text(
                      "Are you sure you want to revoke enterprise access for ${currentMember.name}?",
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(ctx),
                        child: const Text("Cancel"),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: theme.colorScheme.error,
                          foregroundColor: theme.colorScheme.onError,
                        ),
                        onPressed: () {
                          provider.deleteTeamMember(currentMember.id);
                          Navigator.pop(ctx); // Close dialog
                          Navigator.pop(context); // Back to list
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                "${currentMember.name} removed from team.",
                              ),
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        },
                        child: const Text("Remove"),
                      ),
                    ],
                  ),
                );
              },
            ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 900),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Member Profile Header
                AppCard(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: theme.colorScheme.primaryContainer,
                        child: Text(
                          currentMember.name.isNotEmpty
                              ? currentMember.name
                                  .substring(0, 1)
                                  .toUpperCase()
                              : "?",
                          style: TextStyle(
                            color: theme.colorScheme.primary,
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              currentMember.name,
                              style: theme.textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              currentMember.email,
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: theme.colorScheme.onSurfaceVariant,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Wrap(
                              spacing: 8,
                              runSpacing: 4,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: theme
                                        .colorScheme.surfaceContainerHighest,
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Text(
                                    "Status: ${currentMember.status}",
                                    style: theme.textTheme.labelSmall
                                        ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                if (currentMember.hasCustomPermissions)
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color:
                                          theme.colorScheme.tertiaryContainer,
                                      borderRadius:
                                          BorderRadius.circular(6),
                                    ),
                                    child: Text(
                                      "Custom Permissions Active",
                                      style: theme.textTheme.labelSmall
                                          ?.copyWith(
                                        color: theme
                                            .colorScheme.onTertiaryContainer,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // Role Selector Card
                AppCard(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Assigned Role",
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        "Select an enterprise role tier. Changing roles will reset custom module permissions to default specifications.",
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(height: 16),
                      DropdownButtonFormField<String>(
                        key: ValueKey(currentMember.role),
                        initialValue: currentMember.role,
                        decoration: InputDecoration(
                          labelText: "Enterprise Permission Tier",
                          prefixIcon:
                              const Icon(Icons.admin_panel_settings_outlined),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        items: [
                          "Admin",
                          "HR Manager",
                          "Recruiter",
                          "Hiring Manager",
                          "Viewer",
                        ].map((role) {
                          return DropdownMenuItem(
                            value: role,
                            child: Text(
                              role,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w600),
                            ),
                          );
                        }).toList(),
                        onChanged: (newVal) {
                          if (newVal != null && newVal != currentMember.role) {
                            _showRoleConfirmDialog(context, newVal);
                          }
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Permission Categories Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Granular Module Permissions",
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (currentMember.hasCustomPermissions)
                      TextButton.icon(
                        onPressed: () {
                          provider.assignRoleToMember(
                            currentMember.id,
                            currentMember.role,
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                "Reset to default ${currentMember.role} permissions.",
                              ),
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        },
                        icon: const Icon(Icons.restore_rounded, size: 16),
                        label: const Text("Reset to Default"),
                      ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  "Override default role capabilities by toggling individual access switches below.",
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 12),

                // Permissions Table / List
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: currentMember.permissions.length,
                  separatorBuilder: (ctx, index) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final perm = currentMember.permissions[index];
                    return _buildPermissionCategoryCard(
                      context,
                      provider,
                      currentMember.id,
                      perm,
                    );
                  },
                ),
                const SizedBox(height: 24),

                // Save CTA (Dummy)
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            "Permissions and access saved for ${currentMember.name}.",
                          ),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    },
                    icon: const Icon(Icons.check_circle_outline_rounded),
                    label: const Text(
                      "Save Access & Permissions",
                      style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPermissionCategoryCard(
    BuildContext context,
    ProfileDataProvider provider,
    String memberId,
    PermissionItem perm,
  ) {
    final theme = Theme.of(context);
    IconData icon;
    switch (perm.category) {
      case "Dashboard":
        icon = Icons.dashboard_outlined;
        break;
      case "Jobs":
        icon = Icons.work_outline_rounded;
        break;
      case "Candidates":
        icon = Icons.people_outline_rounded;
        break;
      case "Interviews":
        icon = Icons.calendar_today_outlined;
        break;
      case "Reports":
        icon = Icons.analytics_outlined;
        break;
      case "Notifications":
        icon = Icons.notifications_none_rounded;
        break;
      case "Company Settings":
        icon = Icons.business_outlined;
        break;
      case "Team Management":
        icon = Icons.manage_accounts_outlined;
        break;
      case "Billing":
        icon = Icons.credit_card_outlined;
        break;
      case "Security":
        icon = Icons.security_outlined;
        break;
      default:
        icon = Icons.folder_outlined;
    }

    return AppCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(8),
                ),
                child:
                    Icon(icon, size: 20, color: theme.colorScheme.primary),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  perm.category,
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Divider(
            height: 1,
            color: theme.colorScheme.outline.withValues(alpha: 0.15),
          ),
          const SizedBox(height: 12),
          // Responsive Checkbox Switches using Wrap to prevent overflow on small phones (320px)
          Wrap(
            spacing: 16,
            runSpacing: 8,
            children: [
              _buildPermissionSwitch(
                context,
                label: "View",
                value: perm.canView,
                onChanged: (val) {
                  provider.updateMemberPermission(
                    memberId,
                    perm.category,
                    'view',
                    val,
                  );
                },
              ),
              _buildPermissionSwitch(
                context,
                label: "Create",
                value: perm.canCreate,
                onChanged: (val) {
                  provider.updateMemberPermission(
                    memberId,
                    perm.category,
                    'create',
                    val,
                  );
                },
              ),
              _buildPermissionSwitch(
                context,
                label: "Edit",
                value: perm.canEdit,
                onChanged: (val) {
                  provider.updateMemberPermission(
                    memberId,
                    perm.category,
                    'edit',
                    val,
                  );
                },
              ),
              _buildPermissionSwitch(
                context,
                label: "Delete",
                value: perm.canDelete,
                onChanged: (val) {
                  provider.updateMemberPermission(
                    memberId,
                    perm.category,
                    'delete',
                    val,
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPermissionSwitch(
    BuildContext context, {
    required String label,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: () => onChanged(!value),
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 24,
              height: 24,
              child: Checkbox(
                value: value,
                onChanged: (val) {
                  if (val != null) onChanged(val);
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: value ? FontWeight.bold : FontWeight.normal,
                color: value
                    ? theme.colorScheme.primary
                    : theme.colorScheme.onSurface,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
