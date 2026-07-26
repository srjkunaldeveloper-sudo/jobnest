import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jobnest/core/widgets/app_card.dart';
import 'package:jobnest/core/providers/theme_provider.dart';

class ProfilePreferencesScreen extends StatefulWidget {
  const ProfilePreferencesScreen({super.key});

  @override
  State<ProfilePreferencesScreen> createState() => _ProfilePreferencesScreenState();
}

class _ProfilePreferencesScreenState extends State<ProfilePreferencesScreen> {
  String _language = "English (US)";
  String _dateFormat = "MM/DD/YYYY";
  String _timeZone = "(UTC+05:30) Chennai, Kolkata, Mumbai, New Delhi";
  String _defaultDashboard = "Home Dashboard";

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _language = prefs.getString('pref_language') ?? "English (US)";
      _dateFormat = prefs.getString('pref_date_format') ?? "MM/DD/YYYY";
      _timeZone = prefs.getString('pref_time_zone') ?? "(UTC+05:30) Chennai, Kolkata, Mumbai, New Delhi";
      _defaultDashboard = prefs.getString('pref_default_dashboard') ?? "Home Dashboard";
    });
  }

  Future<void> _savePreference(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  void _showSelectionSheet(String title, List<String> options, String currentValue, Function(String) onSelected) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              Flexible(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: options.length,
                  itemBuilder: (context, index) {
                    final option = options[index];
                    final isSelected = option == currentValue;
                    return ConstrainedBox(
                      constraints: const BoxConstraints(minHeight: 48),
                      child: ListTile(
                        title: Text(option),
                        trailing: isSelected ? Icon(Icons.check, color: Theme.of(context).colorScheme.primary) : null,
                        onTap: () {
                          onSelected(option);
                          Navigator.pop(context);
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showSearchableTimeZoneSheet() {
    final options = [
      "UTC",
      "UTC+5:30 India",
      "UTC+1 London",
      "UTC-5 New York",
      "UTC+9 Tokyo",
      "(UTC+05:30) Chennai, Kolkata, Mumbai, New Delhi",
    ];
    String searchQuery = "";

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateSheet) {
            final filteredOptions = options.where((opt) => opt.toLowerCase().contains(searchQuery.toLowerCase())).toList();
            return SafeArea(
              child: Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text("Time Zone", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: TextField(
                        decoration: const InputDecoration(
                          hintText: "Search Time Zone",
                          prefixIcon: Icon(Icons.search),
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (value) {
                          setStateSheet(() {
                            searchQuery = value;
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: 8),
                    Flexible(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: filteredOptions.length,
                        itemBuilder: (context, index) {
                          final option = filteredOptions[index];
                          final isSelected = option == _timeZone;
                          return ConstrainedBox(
                            constraints: const BoxConstraints(minHeight: 48),
                            child: ListTile(
                              title: Text(option),
                              trailing: isSelected ? Icon(Icons.check, color: Theme.of(context).colorScheme.primary) : null,
                              onTap: () {
                                setState(() {
                                  _timeZone = option;
                                });
                                _savePreference('pref_time_zone', option);
                                Navigator.pop(context);
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  String _getThemeName(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.light:
        return "Light";
      case ThemeMode.dark:
        return "Dark";
      case ThemeMode.system:
        return "System Default";
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final themeProvider = Provider.of<ThemeProvider>(context);

    // ===== BACKEND TODO =====
    // TODO: Fetch recruiter profile.
    // TODO: Update profile API.
    // TODO: Future me preferences backend user profile ke saath sync hongi.
    // TODO: Theme backend profile se restore hogi.
    // TODO: Language localization backend support future me add hoga.

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        backgroundColor: theme.colorScheme.surface,
        elevation: 0,
        title: const Text("App Preferences & Theme"),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: ListView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
            children: [
              AppCard(
                padding: EdgeInsets.zero,
                child: Column(
                  children: [
                    _buildDropdownTile(
                      context, 
                      Icons.language_rounded, 
                      "Language", 
                      _language,
                      () {
                        _showSelectionSheet(
                          "Language",
                          ["English (US)", "English (UK)", "Hindi", "French", "German"],
                          _language,
                          (selected) {
                            setState(() {
                              _language = selected;
                            });
                            _savePreference('pref_language', selected);
                          }
                        );
                      }
                    ),
                    Divider(height: 1, color: theme.dividerColor),
                    _buildDropdownTile(
                      context, 
                      Icons.palette_outlined, 
                      "Theme Mode", 
                      _getThemeName(themeProvider.themeMode),
                      () {
                         _showSelectionSheet(
                           "Theme Mode",
                           ["System Default", "Light", "Dark"],
                           _getThemeName(themeProvider.themeMode),
                           (selected) {
                              ThemeMode mode = ThemeMode.system;
                              if (selected == "Light") {
                                mode = ThemeMode.light;
                              } else if (selected == "Dark") {
                                mode = ThemeMode.dark;
                              }
                              themeProvider.setTheme(mode);
                           }
                         );
                      }
                    ),
                    Divider(height: 1, color: theme.dividerColor),
                    _buildDropdownTile(
                      context, 
                      Icons.calendar_today_rounded, 
                      "Date Format", 
                      _dateFormat,
                      () {
                        _showSelectionSheet(
                          "Date Format",
                          ["MM/DD/YYYY", "DD/MM/YYYY", "YYYY-MM-DD", "MMM DD, YYYY"],
                          _dateFormat,
                          (selected) {
                            setState(() {
                              _dateFormat = selected;
                            });
                            _savePreference('pref_date_format', selected);
                          }
                        );
                      }
                    ),
                    Divider(height: 1, color: theme.dividerColor),
                    _buildDropdownTile(
                      context, 
                      Icons.schedule_rounded, 
                      "Time Zone", 
                      _timeZone,
                      () {
                        _showSearchableTimeZoneSheet();
                      }
                    ),
                    Divider(height: 1, color: theme.dividerColor),
                    _buildDropdownTile(
                      context, 
                      Icons.home_rounded, 
                      "Default Dashboard", 
                      _defaultDashboard,
                      () {
                         _showSelectionSheet(
                          "Default Dashboard",
                          ["Home Dashboard", "Jobs", "Candidates", "Services", "Profile"],
                          _defaultDashboard,
                          (selected) {
                            setState(() {
                              _defaultDashboard = selected;
                            });
                            _savePreference('pref_default_dashboard', selected);
                          }
                        );
                      }
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 48),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDropdownTile(BuildContext context, IconData icon, String title, String currentValue, VoidCallback onTap) {
    final theme = Theme.of(context);
    return Semantics(
      label: "$title. Current value: $currentValue",
      button: true,
      child: ConstrainedBox(
        constraints: const BoxConstraints(minHeight: 64),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
          leading: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: theme.colorScheme.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: theme.colorScheme.primary, size: 22),
          ),
          title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Text(
              currentValue,
              style: theme.textTheme.labelMedium?.copyWith(color: theme.colorScheme.primary, fontWeight: FontWeight.w600),
            ),
          ),
          trailing: Icon(Icons.arrow_drop_down_rounded, size: 24, color: theme.colorScheme.onSurfaceVariant),
          onTap: onTap,
        ),
      ),
    );
  }
}
