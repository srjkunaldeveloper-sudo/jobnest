import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileDataProvider extends ChangeNotifier {
  static final ProfileDataProvider _instance = ProfileDataProvider._internal();
  factory ProfileDataProvider() => _instance;

  ProfileDataProvider._internal() {
    _loadNotificationPreferences();
  }

  // ===== BACKEND TODO COMMENTS =====
  // TODO:
  // Fetch recruiter profile.

  // TODO:
  // Update profile API.

  // TODO:
  // Upload profile photo.

  // TODO:
  // Notification preferences API.

  // TODO:
  // Company profile sync.

  // Recruiter Profile State
  String fullName = "Sonu Surya";
  String designation = "Senior Tech Recruiter";
  String companyName = "TechNova Solutions";
  String email = "sonusurya@technova.com";
  String phone = "+91 98765 43210";
  String employeeId = "EMP-2024-8901";
  String department = "Human Resources";
  String role = "Senior Recruiter";
  String experience = "8+ Years";
  String location = "Bangalore, India";
  String joiningDate = "October 12, 2021";
  String bio = "";
  
  // Company Details State
  String industry = "Software & Technology";
  String companySize = "500 - 1000 Employees";
  String website = "https://technova.dev";
  String headquarters = "Koramangala, Bangalore";

  // Profile Completeness
  int completenessPercentage = 85;
  List<String> missingItems = [
    "Company Logo",
    "Phone Number Verification",
    "Recruiter Bio",
  ];

  // Notification Switches State
  bool pushNotifications = true;
  bool emailNotifications = true;
  bool interviewReminders = true;
  bool marketingUpdates = false;

  // QA Simulation States
  bool isLoading = false;
  bool isError = false;
  bool isEmpty = false;

  Future<void> _loadNotificationPreferences() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      pushNotifications = prefs.getBool('notif_push') ?? true;
      emailNotifications = prefs.getBool('notif_email') ?? true;
      interviewReminders = prefs.getBool('notif_interviews') ?? true;
      marketingUpdates = prefs.getBool('notif_marketing') ?? false;
      notifyListeners();
    } catch (_) {
      // Fallback to default if prefs fail
    }
  }

  Future<void> setPushNotifications(bool value) async {
    pushNotifications = value;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('notif_push', value);
  }

  Future<void> setEmailNotifications(bool value) async {
    emailNotifications = value;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('notif_email', value);
  }

  Future<void> setInterviewReminders(bool value) async {
    interviewReminders = value;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('notif_interviews', value);
  }

  Future<void> setMarketingUpdates(bool value) async {
    marketingUpdates = value;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('notif_marketing', value);
  }

  void updatePersonalInfo({
    String? name,
    String? newEmail,
    String? newPhone,
    String? newDesignation,
    String? newLocation,
  }) {
    if (name != null && name.isNotEmpty) fullName = name;
    if (newEmail != null && newEmail.isNotEmpty) email = newEmail;
    if (newPhone != null && newPhone.isNotEmpty) phone = newPhone;
    if (newDesignation != null && newDesignation.isNotEmpty) designation = newDesignation;
    if (newLocation != null && newLocation.isNotEmpty) location = newLocation;
    notifyListeners();
  }

  void updateCompanyInfo({
    String? name,
    String? newIndustry,
    String? size,
    String? web,
    String? hq,
  }) {
    if (name != null && name.isNotEmpty) companyName = name;
    if (newIndustry != null && newIndustry.isNotEmpty) industry = newIndustry;
    if (size != null && size.isNotEmpty) companySize = size;
    if (web != null && web.isNotEmpty) website = web;
    if (hq != null && hq.isNotEmpty) headquarters = hq;
    notifyListeners();
  }

  Future<void> refreshProfile() async {
    isLoading = true;
    isError = false;
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 600));

    isLoading = false;
    notifyListeners();
  }

  void simulateLoading() {
    isLoading = true;
    isError = false;
    notifyListeners();
  }

  void simulateError() {
    isLoading = false;
    isError = true;
    notifyListeners();
  }

  void simulateEmpty() {
    isLoading = false;
    isError = false;
    isEmpty = true;
    notifyListeners();
  }

  void restoreDefaults() {
    isLoading = false;
    isError = false;
    isEmpty = false;
    fullName = "Sonu Surya";
    designation = "Senior Tech Recruiter";
    companyName = "TechNova Solutions";
    email = "sonusurya@technova.com";
    phone = "+91 98765 43210";
    completenessPercentage = 85;
    missingItems = [
      "Company Logo",
      "Phone Number Verification",
      "Recruiter Bio",
    ];
    notifyListeners();
  }
}
