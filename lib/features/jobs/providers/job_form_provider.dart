import 'package:flutter/material.dart';
import 'package:jobnest/core/models/recruitment_models.dart';

class JobFormProvider extends ChangeNotifier {
  // Step management
  int _currentStep = 0;
  final int totalSteps = 6;

  int get currentStep => _currentStep;

  // Mode management
  bool _isEditMode = false;
  String? _editingJobId;
  JobModel? _editingJob;
  bool _isInitialized = false;

  bool get isEditMode => _isEditMode;
  String? get editingJobId => _editingJobId;
  JobModel? get editingJob => _editingJob;
  bool get isInitialized => _isInitialized;

  // Form Controllers & State
  // Step 1: Basic Details
  final TextEditingController jobTitleController = TextEditingController();
  final TextEditingController companyController = TextEditingController(text: "JobNest Inc.");
  final TextEditingController locationController = TextEditingController();
  
  // NOTE: departmentController, hiringManagerController, and recruiterController are currently 
  // unused in the UI and models. They are preserved here for future UI bindings/integrations.
  final TextEditingController departmentController = TextEditingController(text: "Engineering");
  final TextEditingController hiringManagerController = TextEditingController(text: "Sarah Jenkins");
  final TextEditingController recruiterController = TextEditingController(text: "Alex Morgan");

  String _employmentType = "Full Time";
  String _workMode = "Office";
  String _workingDays = "5 Days";
  String _workingHours = "Standard (9-5)";
  List<String> _benefits = ["Health Insurance", "Paid Time Off", "Learning Budget"];

  String get employmentType => _employmentType;
  String get workMode => _workMode;
  String get workingDays => _workingDays;
  String get workingHours => _workingHours;
  List<String> get benefits => _benefits;

  // Step 2: AI Generator & Descriptions
  final TextEditingController promptController = TextEditingController(text: "Sales Executive Fresher");
  // NOTE: descriptionController is connected to the JobModel.description field but is not bound to a UI field.
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController responsibilitiesController = TextEditingController(
    text: "• Identify and prospect new sales leads.\n• Maintain relationships with existing clients.\n• Achieve monthly sales targets.",
  );
  final TextEditingController skillsTextController = TextEditingController(
    text: "• Excellent communication skills.\n• Negotiation and persuasion.\n• Basic understanding of CRM software.",
  );
  final TextEditingController requirementsController = TextEditingController(
    text: "• Bachelor's Degree in Business or related field.\n• Willingness to travel if required.",
  );
  final TextEditingController experienceDetailController = TextEditingController(
    text: "• 0-1 years of experience in sales or marketing.\n• Fresher with strong aptitude can apply.",
  );

  List<String> _skills = ["Flutter", "Dart", "REST APIs", "Git"];
  List<String> get skills => _skills;

  List<String> get responsibilitiesList => _parseListFromText(responsibilitiesController.text);
  List<String> get requirementsList => _parseListFromText(requirementsController.text);

  // Step 3: Salary & Compensation
  final TextEditingController minSalaryController = TextEditingController(text: "400000");
  final TextEditingController maxSalaryController = TextEditingController(text: "600000");
  String _currency = "INR (₹)";
  String _salaryType = "Yearly";

  String get currency => _currency;
  String get salaryType => _salaryType;

  String get formattedSalary {
    final min = minSalaryController.text.trim();
    final max = maxSalaryController.text.trim();
    final curr = _currency.startsWith("INR") ? "₹" : _currency.startsWith("USD") ? "\$" : "€";
    final period = _salaryType == "Yearly" ? "/ Yr" : _salaryType == "Monthly" ? "/ Mo" : "/ Hr";

    if (min.isEmpty && max.isEmpty) return "$curr Negotiable $period";
    if (min.isEmpty) return "$curr$max $period";
    if (max.isEmpty) return "$curr$min $period";

    if (curr == "₹" && _salaryType == "Yearly") {
      final minNum = double.tryParse(min);
      final maxNum = double.tryParse(max);
      if (minNum != null && maxNum != null && minNum >= 100000 && maxNum >= 100000) {
        final minL = (minNum / 100000).toStringAsFixed(minNum % 100000 == 0 ? 0 : 1);
        final maxL = (maxNum / 100000).toStringAsFixed(maxNum % 100000 == 0 ? 0 : 1);
        return "₹${minL}L - ₹${maxL}L / Yr";
      }
    }
    return "$curr$min - $curr$max $period";
  }

  // Step 4: Requirements & Profile
  String _experience = "1-3 Years";
  List<String> _education = ["Bachelor's", "Master's"];
  List<String> _noticePeriod = ["Immediate", "15 Days"];
  List<String> _languages = ["English", "Hindi"];
  final TextEditingController maxApplicantsController = TextEditingController();

  String get experience => _experience;
  List<String> get education => _education;
  List<String> get noticePeriod => _noticePeriod;
  List<String> get languages => _languages;

  // Step 5: Settings & Status
  final TextEditingController openingsController = TextEditingController(text: "1");
  final TextEditingController deadlineController = TextEditingController(text: "30 Aug 2026");
  String _status = "Open";
  bool _isUrgent = true;
  bool _autoShortlist = false;
  bool _fastHiring = true;

  String get status => _status;
  bool get isUrgent => _isUrgent;
  bool get autoShortlist => _autoShortlist;
  bool get fastHiring => _fastHiring;

  // Step Navigation Methods
  void nextStep() {
    if (_currentStep < totalSteps - 1) {
      _currentStep++;
      notifyListeners();
    }
  }

  void previousStep() {
    if (_currentStep > 0) {
      _currentStep--;
      notifyListeners();
    }
  }

  void jumpToStep(int step) {
    if (step >= 0 && step < totalSteps && step != _currentStep) {
      _currentStep = step;
      notifyListeners();
    }
  }

  // Mode Initializers
  void initializeCreate() {
    _isEditMode = false;
    _editingJobId = null;
    _editingJob = null;
    _currentStep = 0;

    jobTitleController.clear();
    companyController.text = "JobNest Inc.";
    locationController.clear();
    departmentController.text = "Engineering";
    hiringManagerController.text = "Sarah Jenkins";
    recruiterController.text = "Alex Morgan";

    _employmentType = "Full Time";
    _workMode = "Office";
    _workingDays = "5 Days";
    _workingHours = "Standard (9-5)";
    _benefits = ["Health Insurance", "Paid Time Off", "Learning Budget"];

    promptController.text = "Sales Executive Fresher";
    descriptionController.clear();
    experienceDetailController.text =
        "• 0-1 years of experience in sales or marketing.\n• Fresher with strong aptitude can apply.";
    responsibilitiesController.text =
        "• Identify and prospect new sales leads.\n• Maintain relationships with existing clients.\n• Achieve monthly sales targets.";
    skillsTextController.text =
        "• Excellent communication skills.\n• Negotiation and persuasion.\n• Basic understanding of CRM software.";
    requirementsController.text =
        "• Bachelor's Degree in Business or related field.\n• Willingness to travel if required.";
    _skills = ["Flutter", "Dart", "REST APIs", "Git"];

    minSalaryController.text = "400000";
    maxSalaryController.text = "600000";
    _currency = "INR (₹)";
    _salaryType = "Yearly";

    _experience = "1-3 Years";
    _education = ["Bachelor's", "Master's"];
    _noticePeriod = ["Immediate", "15 Days"];
    _languages = ["English", "Hindi"];
    maxApplicantsController.clear();

    openingsController.text = "1";
    deadlineController.text = "30 Aug 2026";
    _status = "Open";
    _isUrgent = true;
    _autoShortlist = false;
    _fastHiring = true;

    _isInitialized = true;
    notifyListeners();
  }

  void initializeEdit(JobModel job) {
    _isEditMode = true;
    _editingJobId = job.id;
    _editingJob = job;
    _currentStep = 0;

    jobTitleController.text = job.title;
    companyController.text = job.company;
    locationController.text = job.location;
    _employmentType = job.jobType;
    _status = job.status;
    _isUrgent = job.isUrgent;
    descriptionController.text = job.description;

    responsibilitiesController.text = job.responsibilities
        .map((r) => r.startsWith('• ') ? r : '• $r')
        .join('\n');
    requirementsController.text = job.requirements
        .map((r) => r.startsWith('• ') ? r : '• $r')
        .join('\n');
    experienceDetailController.text =
        "• 0-1 years of experience in sales or marketing.\n• Fresher with strong aptitude can apply.";
    _skills = List.from(job.skills);
    _benefits = List.from(job.benefits);

    _isInitialized = true;
    notifyListeners();
  }

  // Setters & Mutators
  void setEmploymentType(String value) {
    if (_employmentType != value) {
      _employmentType = value;
      notifyListeners();
    }
  }

  void setWorkMode(String value) {
    if (_workMode != value) {
      _workMode = value;
      notifyListeners();
    }
  }

  void setWorkingDays(String value) {
    if (_workingDays != value) {
      _workingDays = value;
      notifyListeners();
    }
  }

  void setWorkingHours(String value) {
    if (_workingHours != value) {
      _workingHours = value;
      notifyListeners();
    }
  }

  void setCurrency(String value) {
    if (_currency != value) {
      _currency = value;
      notifyListeners();
    }
  }

  void setSalaryType(String value) {
    if (_salaryType != value) {
      _salaryType = value;
      notifyListeners();
    }
  }

  void setExperience(String value) {
    if (_experience != value) {
      _experience = value;
      notifyListeners();
    }
  }

  void setStatus(String value) {
    if (_status != value) {
      _status = value;
      notifyListeners();
    }
  }

  void setUrgent(bool value) {
    if (_isUrgent != value) {
      _isUrgent = value;
      notifyListeners();
    }
  }

  void setAutoShortlist(bool value) {
    if (_autoShortlist != value) {
      _autoShortlist = value;
      notifyListeners();
    }
  }

  void setFastHiring(bool value) {
    if (_fastHiring != value) {
      _fastHiring = value;
      notifyListeners();
    }
  }

  void toggleBenefit(String item) {
    if (_benefits.contains(item)) {
      _benefits.remove(item);
    } else {
      _benefits.add(item);
    }
    notifyListeners();
  }

  void toggleSkill(String item) {
    if (_skills.contains(item)) {
      _skills.remove(item);
    } else {
      _skills.add(item);
    }
    notifyListeners();
  }

  void toggleEducation(String item) {
    if (_education.contains(item)) {
      _education.remove(item);
    } else {
      _education.add(item);
    }
    notifyListeners();
  }

  void toggleNoticePeriod(String item) {
    if (_noticePeriod.contains(item)) {
      _noticePeriod.remove(item);
    } else {
      _noticePeriod.add(item);
    }
    notifyListeners();
  }

  void toggleLanguage(String item) {
    if (_languages.contains(item)) {
      _languages.remove(item);
    } else {
      _languages.add(item);
    }
    notifyListeners();
  }

  // Validation
  bool validateStep(int step) {
    switch (step) {
      case 0:
        return jobTitleController.text.trim().isNotEmpty &&
            companyController.text.trim().isNotEmpty &&
            locationController.text.trim().isNotEmpty;
      case 1:
        return true; // AI generator / descriptions
      case 2:
        return minSalaryController.text.trim().isNotEmpty &&
            maxSalaryController.text.trim().isNotEmpty;
      case 3:
        return true; // Requirements
      case 4:
        return openingsController.text.trim().isNotEmpty;
      case 5:
        return true; // Preview
      default:
        return true;
    }
  }

  bool validateCurrentStep() => validateStep(_currentStep);

  bool validateEntireForm() {
    for (int i = 0; i < totalSteps; i++) {
      if (!validateStep(i)) return false;
    }
    return true;
  }

  // Build JobModel
  JobModel buildJobModel() {
    final now = DateTime.now();
    final jobId = _isEditMode && _editingJobId != null
        ? _editingJobId!
        : 'job_custom_${now.millisecondsSinceEpoch}';

    return JobModel(
      id: jobId,
      title: jobTitleController.text.trim().isEmpty
          ? 'Untitled Requisition'
          : jobTitleController.text.trim(),
      company: companyController.text.trim().isEmpty
          ? 'JobNest Inc.'
          : companyController.text.trim(),
      location: locationController.text.trim().isEmpty
          ? 'Remote'
          : locationController.text.trim(),
      salary: formattedSalary,
      jobType: _employmentType,
      applicationsCount: _isEditMode && _editingJob != null ? _editingJob!.applicationsCount : '0',
      status: _status,
      aiMatchScore: _isEditMode && _editingJob != null ? _editingJob!.aiMatchScore : 90,
      isUrgent: _isUrgent,
      isBookmarked: _isEditMode && _editingJob != null ? _editingJob!.isBookmarked : false,
      postedDate: _isEditMode && _editingJob != null ? _editingJob!.postedDate : 'Posted Just Now',
      description: descriptionController.text.trim().isEmpty
          ? 'We are seeking a talented professional to join our team.'
          : descriptionController.text.trim(),
      requirements: requirementsList.isEmpty
          ? const ['Standard role qualifications.']
          : requirementsList,
      responsibilities: responsibilitiesList.isEmpty
          ? const ['General role responsibilities.']
          : responsibilitiesList,
      skills: _skills.isEmpty ? const ['Communication', 'Problem Solving'] : _skills,
      benefits: _benefits.isEmpty ? const ['Standard benefits package'] : _benefits,
      hiringTimeline: _isEditMode && _editingJob != null
          ? _editingJob!.hiringTimeline
          : "Expected time to hire: 2–3 weeks (Screening → Technical Round → Leadership Fit)",
    );
  }

  List<String> _parseListFromText(String text) {
    if (text.trim().isEmpty) return [];
    return text
        .split('\n')
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .map((e) => e.startsWith('• ') || e.startsWith('- ') || e.startsWith('* ')
            ? e.substring(2).trim()
            : e)
        .toList();
  }

  @override
  void dispose() {
    jobTitleController.dispose();
    companyController.dispose();
    locationController.dispose();
    departmentController.dispose();
    hiringManagerController.dispose();
    recruiterController.dispose();
    promptController.dispose();
    descriptionController.dispose();
    responsibilitiesController.dispose();
    skillsTextController.dispose();
    requirementsController.dispose();
    minSalaryController.dispose();
    maxSalaryController.dispose();
    maxApplicantsController.dispose();
    openingsController.dispose();
    deadlineController.dispose();
    experienceDetailController.dispose();
    super.dispose();
  }

  bool get hasUnsavedChanges {
    if (!_isInitialized) return false;
    if (_isEditMode) {
      final job = _editingJob;
      if (job == null) return false;
      return jobTitleController.text != job.title ||
          companyController.text != job.company ||
          locationController.text != job.location ||
          descriptionController.text != job.description ||
          _employmentType != job.jobType ||
          _status != job.status ||
          _isUrgent != job.isUrgent ||
          formattedSalary != job.salary ||
          !_listEquals(skills, job.skills) ||
          !_listEquals(benefits, job.benefits) ||
          responsibilitiesController.text != job.responsibilities.map((r) => r.startsWith('• ') ? r : '• $r').join('\n') ||
          requirementsController.text != job.requirements.map((r) => r.startsWith('• ') ? r : '• $r').join('\n');
    } else {
      return jobTitleController.text.isNotEmpty ||
          locationController.text.isNotEmpty ||
          companyController.text != "JobNest Inc." ||
          _employmentType != "Full Time" ||
          _workMode != "Office" ||
          _workingDays != "5 Days" ||
          _workingHours != "Standard (9-5)" ||
          !_listEquals(_benefits, ["Health Insurance", "Paid Time Off", "Learning Budget"]) ||
          promptController.text != "Sales Executive Fresher" ||
          !_listEquals(_skills, ["Flutter", "Dart", "REST APIs", "Git"]) ||
          minSalaryController.text != "400000" ||
          maxSalaryController.text != "600000" ||
          _currency != "INR (₹)" ||
          _salaryType != "Yearly" ||
          _experience != "1-3 Years" ||
          !_listEquals(_education, ["Bachelor's", "Master's"]) ||
          !_listEquals(_noticePeriod, ["Immediate", "15 Days"]) ||
          !_listEquals(_languages, ["English", "Hindi"]) ||
          maxApplicantsController.text.isNotEmpty ||
          openingsController.text != "1" ||
          deadlineController.text != "30 Aug 2026" ||
          _status != "Open" ||
          !_isUrgent ||
          _autoShortlist ||
          !_fastHiring;
    }
  }

  void clearInitialized() {
    _isInitialized = false;
    notifyListeners();
  }

  bool _listEquals(List<String> a, List<String> b) {
    if (a.length != b.length) return false;
    for (int i = 0; i < a.length; i++) {
      if (a[i] != b[i]) return false;
    }
    return true;
  }
}
