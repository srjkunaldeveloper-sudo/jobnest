import 'package:flutter/material.dart';
import 'package:jobnest/features/jobs/create_job/validation/create_job_validator.dart';

class CreateJobProvider extends ChangeNotifier {
  int _currentStep = 0;
  final int totalSteps = 7;

  int get currentStep => _currentStep;

  // STEP 1 Fields
  String _postingType = "External";
  final TextEditingController jobTitleController = TextEditingController();
  final TextEditingController companyController = TextEditingController(text: "JobNest Inc.");
  final TextEditingController departmentController = TextEditingController(text: "Engineering");
  String _employmentType = "Full Time";
  final TextEditingController seniorityController = TextEditingController(text: "Mid-Level");
  String _experience = "1-3 Years";
  final TextEditingController positionsController = TextEditingController(text: "1");

  String get postingType => _postingType;
  String get employmentType => _employmentType;
  String get experience => _experience;

  void setPostingType(String value) {
    if (_postingType != value) {
      _postingType = value;
      clearError("postingType");
      notifyListeners();
    }
  }

  void setEmploymentType(String value) {
    if (_employmentType != value) {
      _employmentType = value;
      clearError("employmentType");
      notifyListeners();
    }
  }

  void setExperience(String value) {
    if (_experience != value) {
      _experience = value;
      clearError("experience");
      notifyListeners();
    }
  }

  // STEP 2 Fields
  String _workMode = "In Office";
  final List<String> _locations = ["Delhi NCR", "Bangalore"];
  final TextEditingController officeAddressController = TextEditingController();

  String get workMode => _workMode;
  List<String> get locations => _locations;

  void setWorkMode(String value) {
    if (_workMode != value) {
      _workMode = value;
      clearError("workMode");
      if (value == "Remote") {
        clearError("officeAddress");
      }
      notifyListeners();
    }
  }

  void addLocation(String location) {
    final clean = location.trim();
    if (clean.isNotEmpty && !_locations.contains(clean) && _locations.length < 3) {
      _locations.add(clean);
      clearError("locations");
      notifyListeners();
    }
  }

  void removeLocation(String location) {
    if (_locations.contains(location)) {
      _locations.remove(location);
      notifyListeners();
    }
  }

  // STEP 3 Fields
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController responsibilitiesController = TextEditingController();
  final TextEditingController requirementsController = TextEditingController();
  final List<String> _skills = [];

  List<String> get skills => _skills;

  void appendResponsibilitySuggestion(String suggestion) {
    final currentText = responsibilitiesController.text.trim();
    if (!currentText.contains(suggestion)) {
      if (currentText.isEmpty) {
        responsibilitiesController.text = "• $suggestion";
      } else {
        responsibilitiesController.text = "$currentText\n• $suggestion";
      }
      notifyListeners();
    }
  }

  void appendRequirementSuggestion(String suggestion) {
    final currentText = requirementsController.text.trim();
    if (!currentText.contains(suggestion)) {
      if (currentText.isEmpty) {
        requirementsController.text = "• $suggestion";
      } else {
        requirementsController.text = "$currentText\n• $suggestion";
      }
      clearError("requirements");
      notifyListeners();
    }
  }

  void addSkill(String skill) {
    final clean = skill.trim();
    if (clean.isNotEmpty && !_skills.contains(clean) && _skills.length < 8) {
      _skills.add(clean);
      clearError("skills");
      notifyListeners();
    }
  }

  void removeSkill(String skill) {
    if (_skills.contains(skill)) {
      _skills.remove(skill);
      notifyListeners();
    }
  }

  // STEP 4 Fields
  final TextEditingController minimumSalaryController = TextEditingController();
  final TextEditingController maximumSalaryController = TextEditingController();
  String _currency = "INR (₹)";
  String _salaryPeriod = "Per Annum";
  bool _showSalary = true;
  final List<String> _selectedBenefits = [];

  String get currency => _currency;
  String get salaryPeriod => _salaryPeriod;
  bool get showSalary => _showSalary;
  List<String> get selectedBenefits => _selectedBenefits;

  void setCurrency(String value) {
    if (_currency != value) {
      _currency = value;
      notifyListeners();
    }
  }

  void setSalaryPeriod(String value) {
    if (_salaryPeriod != value) {
      _salaryPeriod = value;
      notifyListeners();
    }
  }

  void setShowSalary(bool value) {
    if (_showSalary != value) {
      _showSalary = value;
      notifyListeners();
    }
  }

  void toggleBenefit(String benefit) {
    if (_selectedBenefits.contains(benefit)) {
      _selectedBenefits.remove(benefit);
    } else {
      _selectedBenefits.add(benefit);
    }
    notifyListeners();
  }

  // STEP 5 Fields
  String _applicationMethod = "Apply on JobNest";
  final TextEditingController externalUrlController = TextEditingController();
  final TextEditingController applicationEmailController = TextEditingController();
  DateTime? _applicationDeadline;

  String get applicationMethod => _applicationMethod;
  DateTime? get applicationDeadline => _applicationDeadline;

  void setApplicationMethod(String value) {
    if (_applicationMethod != value) {
      _applicationMethod = value;
      clearError("applicationMethod");
      clearError("externalUrl");
      clearError("applicationEmail");
      notifyListeners();
    }
  }

  void setApplicationDeadline(DateTime date) {
    _applicationDeadline = date;
    notifyListeners();
  }

  void clearApplicationDeadline() {
    _applicationDeadline = null;
    notifyListeners();
  }

  // STEP 6 Fields
  bool _relocationRequired = false;
  String _travelRequirement = "None";
  String _hiringTimeline = "Flexible";
  String _priority = "Medium";
  String _shiftType = "Day Shift";
  TimeOfDay? _startTime = const TimeOfDay(hour: 9, minute: 0);
  TimeOfDay? _endTime = const TimeOfDay(hour: 17, minute: 0);
  final TextEditingController recruiterNameController = TextEditingController();
  final TextEditingController recruiterEmailController = TextEditingController();
  final TextEditingController recruiterPhoneController = TextEditingController();
  final List<String> _screeningQuestions = [];

  bool get relocationRequired => _relocationRequired;
  String get travelRequirement => _travelRequirement;
  String get hiringTimeline => _hiringTimeline;
  String get priority => _priority;
  String get shiftType => _shiftType;
  TimeOfDay? get startTime => _startTime;
  TimeOfDay? get endTime => _endTime;
  List<String> get screeningQuestions => _screeningQuestions;

  void setRelocationRequired(bool value) {
    if (_relocationRequired != value) {
      _relocationRequired = value;
      notifyListeners();
    }
  }

  void setTravelRequirement(String value) {
    if (_travelRequirement != value) {
      _travelRequirement = value;
      notifyListeners();
    }
  }

  void setHiringTimeline(String value) {
    if (_hiringTimeline != value) {
      _hiringTimeline = value;
      notifyListeners();
    }
  }

  void setPriority(String value) {
    if (_priority != value) {
      _priority = value;
      notifyListeners();
    }
  }

  void setShiftType(String value) {
    if (_shiftType != value) {
      _shiftType = value;
      notifyListeners();
    }
  }

  void setStartTime(TimeOfDay time) {
    _startTime = time;
    notifyListeners();
  }

  void setEndTime(TimeOfDay time) {
    _endTime = time;
    notifyListeners();
  }

  void addQuestion(String question) {
    final clean = question.trim();
    if (clean.isNotEmpty && !_screeningQuestions.contains(clean) && _screeningQuestions.length < 10) {
      _screeningQuestions.add(clean);
      notifyListeners();
    }
  }

  void removeQuestion(String question) {
    if (_screeningQuestions.contains(question)) {
      _screeningQuestions.remove(question);
      notifyListeners();
    }
  }

  // VALIDATION & BUSINESS RULES STATE
  final Map<String, String> _errors = {};
  String? _bannerMessage;

  Map<String, String> get errors => _errors;
  String? get bannerMessage => _bannerMessage;

  void clearError(String field) {
    if (_errors.containsKey(field)) {
      _errors.remove(field);
      notifyListeners();
    }
  }

  void clearBannerMessage() {
    _bannerMessage = null;
    notifyListeners();
  }

  bool validateStep(int step) {
    bool isValid = true;
    _bannerMessage = null;

    if (step == 0) {
      // Step 1 Basics
      if (jobTitleController.text.trim().isEmpty) {
        _errors['jobTitle'] = "This field is required.";
        isValid = false;
      }
      if (companyController.text.trim().isEmpty) {
        _errors['company'] = "This field is required.";
        isValid = false;
      }
      if (departmentController.text.trim().isEmpty) {
        _errors['department'] = "This field is required.";
        isValid = false;
      }
      if (_employmentType.trim().isEmpty) {
        _errors['employmentType'] = "This field is required.";
        isValid = false;
      }
      if (_experience.trim().isEmpty) {
        _errors['experience'] = "This field is required.";
        isValid = false;
      }
      if (positionsController.text.trim().isEmpty) {
        _errors['positions'] = "This field is required.";
        isValid = false;
      }
    } else if (step == 1) {
      // Step 2 Location
      if (_workMode.trim().isEmpty) {
        _errors['workMode'] = "This field is required.";
        isValid = false;
      }
      if (_locations.isEmpty) {
        _errors['locations'] = "At least one Location is required.";
        isValid = false;
      }
      if (_workMode != "Remote" && officeAddressController.text.trim().isEmpty) {
        _errors['officeAddress'] = "This field is required.";
        isValid = false;
      }
    } else if (step == 2) {
      // Step 3 Details
      if (descriptionController.text.trim().isEmpty) {
        _errors['description'] = "This field is required.";
        isValid = false;
      }
      if (requirementsController.text.trim().isEmpty) {
        _errors['requirements'] = "This field is required.";
        isValid = false;
      }
      if (_skills.isEmpty) {
        _errors['skills'] = "At least one Skill is required.";
        isValid = false;
      }
    } else if (step == 3) {
      // Step 4 Compensation
      bool hasMin = minimumSalaryController.text.trim().isNotEmpty;
      bool hasMax = maximumSalaryController.text.trim().isNotEmpty;

      if (!hasMin) {
        _errors['minimumSalary'] = "This field is required.";
        isValid = false;
      }
      if (!hasMax) {
        _errors['maximumSalary'] = "This field is required.";
        isValid = false;
      }

      if (hasMin && hasMax) {
        final minVal = double.tryParse(minimumSalaryController.text.replaceAll(RegExp(r'[^0-9.]'), ''));
        final maxVal = double.tryParse(maximumSalaryController.text.replaceAll(RegExp(r'[^0-9.]'), ''));
        if (minVal != null && maxVal != null && minVal > maxVal) {
          _errors['minimumSalary'] = "Minimum salary cannot exceed maximum salary.";
          isValid = false;
        }
      }
    } else if (step == 4) {
      // Step 5 Application
      if (_applicationMethod.trim().isEmpty) {
        _errors['applicationMethod'] = "This field is required.";
        isValid = false;
      }
      if (_applicationMethod == "External Website") {
        final url = externalUrlController.text.trim();
        if (url.isEmpty) {
          _errors['externalUrl'] = "This field is required.";
          isValid = false;
        } else if (!CreateJobValidator.isValidUrl(url)) {
          _errors['externalUrl'] = "Enter a valid URL.";
          isValid = false;
        }
      } else if (_applicationMethod == "Email Application") {
        final email = applicationEmailController.text.trim();
        if (email.isEmpty) {
          _errors['applicationEmail'] = "This field is required.";
          isValid = false;
        } else if (!CreateJobValidator.isValidEmail(email)) {
          _errors['applicationEmail'] = "Enter a valid email address.";
          isValid = false;
        }
      }
    } else if (step == 5) {
      // Step 6 Settings
      if (recruiterNameController.text.trim().isEmpty) {
        _errors['recruiterName'] = "This field is required.";
        isValid = false;
      }
      final email = recruiterEmailController.text.trim();
      if (email.isEmpty) {
        _errors['recruiterEmail'] = "This field is required.";
        isValid = false;
      } else if (!CreateJobValidator.isValidEmail(email)) {
        _errors['recruiterEmail'] = "Enter a valid email address.";
        isValid = false;
      }
      if (recruiterPhoneController.text.trim().isEmpty) {
        _errors['recruiterPhone'] = "This field is required.";
        isValid = false;
      }
      if (_priority.trim().isEmpty) {
        _errors['priority'] = "This field is required.";
        isValid = false;
      }
      if (_hiringTimeline.trim().isEmpty) {
        _errors['hiringTimeline'] = "This field is required.";
        isValid = false;
      }
    }

    notifyListeners();
    return isValid;
  }

  bool validateDraft() {
    _errors.clear();
    _bannerMessage = null;
    bool isValid = true;

    if (jobTitleController.text.trim().isEmpty) {
      _errors['jobTitle'] = "This field is required.";
      isValid = false;
    }
    if (companyController.text.trim().isEmpty) {
      _errors['company'] = "This field is required.";
      isValid = false;
    }
    if (_employmentType.trim().isEmpty) {
      _errors['employmentType'] = "This field is required.";
      isValid = false;
    }
    if (_workMode.trim().isEmpty) {
      _errors['workMode'] = "This field is required.";
      isValid = false;
    }
    if (_locations.isEmpty) {
      _errors['locations'] = "At least one Location is required.";
      isValid = false;
    }

    if (!isValid) {
      _bannerMessage = "Cannot save draft. Required basics are missing.";
      notifyListeners();
    }
    return isValid;
  }

  bool validatePublish() {
    _errors.clear();
    _bannerMessage = null;

    bool allValid = true;
    int? firstInvalidStep;

    for (int step = 0; step < 6; step++) {
      if (!validateStep(step)) {
        allValid = false;
        firstInvalidStep ??= step;
      }
    }

    if (!allValid) {
      _bannerMessage = "Please complete all required information before publishing.";
      if (firstInvalidStep != null) {
        _currentStep = firstInvalidStep;
      }
      notifyListeners();
    }
    return allValid;
  }

  void nextStep() {
    if (validateStep(_currentStep)) {
      if (_currentStep < totalSteps - 1) {
        _currentStep++;
        notifyListeners();
      }
    }
  }

  void previousStep() {
    if (_currentStep > 0) {
      _currentStep--;
      _bannerMessage = null;
      notifyListeners();
    }
  }

  void goToStep(int step) {
    if (step >= 0 && step < totalSteps && step != _currentStep) {
      // Allow moving backward freely or validate forward jumps
      if (step < _currentStep || validateStep(_currentStep)) {
        _currentStep = step;
        _bannerMessage = null;
        notifyListeners();
      }
    }
  }

  void reset() {
    _currentStep = 0;
    _postingType = "External";
    jobTitleController.clear();
    companyController.text = "JobNest Inc.";
    departmentController.text = "Engineering";
    _employmentType = "Full Time";
    seniorityController.text = "Mid-Level";
    _experience = "1-3 Years";
    positionsController.text = "1";

    _workMode = "In Office";
    _locations.clear();
    _locations.addAll(["Delhi NCR", "Bangalore"]);
    officeAddressController.clear();

    descriptionController.clear();
    responsibilitiesController.clear();
    requirementsController.clear();
    _skills.clear();

    minimumSalaryController.clear();
    maximumSalaryController.clear();
    _currency = "INR (₹)";
    _salaryPeriod = "Per Annum";
    _showSalary = true;
    _selectedBenefits.clear();

    _applicationMethod = "Apply on JobNest";
    externalUrlController.clear();
    applicationEmailController.clear();
    _applicationDeadline = null;

    _relocationRequired = false;
    _travelRequirement = "None";
    _hiringTimeline = "Flexible";
    _priority = "Medium";
    _shiftType = "Day Shift";
    _startTime = const TimeOfDay(hour: 9, minute: 0);
    _endTime = const TimeOfDay(hour: 17, minute: 0);
    recruiterNameController.clear();
    recruiterEmailController.clear();
    recruiterPhoneController.clear();
    _screeningQuestions.clear();

    _errors.clear();
    _bannerMessage = null;
    notifyListeners();
  }

  @override
  void dispose() {
    jobTitleController.dispose();
    companyController.dispose();
    departmentController.dispose();
    seniorityController.dispose();
    positionsController.dispose();
    officeAddressController.dispose();
    descriptionController.dispose();
    responsibilitiesController.dispose();
    requirementsController.dispose();
    minimumSalaryController.dispose();
    maximumSalaryController.dispose();
    externalUrlController.dispose();
    applicationEmailController.dispose();
    recruiterNameController.dispose();
    recruiterEmailController.dispose();
    recruiterPhoneController.dispose();
    super.dispose();
  }
}
