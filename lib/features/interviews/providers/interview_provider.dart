import 'package:flutter/material.dart';
import 'package:jobnest/core/models/recruitment_models.dart';

class InterviewProvider extends ChangeNotifier {
  final List<InterviewModel> _interviews = [];

  static const List<InterviewModel> _defaultInterviews = [
    InterviewModel(
      id: 'int_1',
      candidateName: 'Rahul Sharma',
      role: 'Senior Flutter Developer',
      time: '10:00 AM',
      company: 'Tech Innovators',
      isToday: true,
    ),
    InterviewModel(
      id: 'int_2',
      candidateName: 'Priya Singh',
      role: 'Python Backend Engineer',
      time: '2:30 PM',
      company: 'Innovate AI',
      isToday: true,
    ),
    InterviewModel(
      id: 'int_3',
      candidateName: 'Amit Patel',
      role: 'UI/UX Designer',
      time: '4:00 PM',
      company: 'Creative Studio',
      isToday: true,
    ),
  ];

  InterviewProvider() {
    restoreDefault(notify: false);
  }

  List<InterviewModel> get interviews => List.unmodifiable(_interviews);

  int get todayInterviewsCount => _interviews.where((i) => i.isToday).length;

  void simulateEmpty() {
    _interviews.clear();
    notifyListeners();
  }

  void restoreDefault({bool notify = true}) {
    _interviews.clear();
    _interviews.addAll(_defaultInterviews);
    if (notify) notifyListeners();
  }

  void addInterview(InterviewModel interview) {
    _interviews.insert(0, interview);
    notifyListeners();
  }

  void deleteInterview(String id) {
    _interviews.removeWhere((i) => i.id == id);
    notifyListeners();
  }
}
