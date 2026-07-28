import 'dart:async';
import 'package:jobnest/core/models/recruitment_models.dart';

class CandidateRepository {
  static const List<CandidateModel> _defaultCandidates = [
    CandidateModel(
      id: 'cand_1',
      name: 'Rahul Sharma',
      role: 'Senior Flutter Developer',
      location: 'Delhi, India',
      experience: '5 Years',
      skills: ['Flutter', 'Dart', 'Firebase', 'BLoC'],
      matchPercentage: 94,
      score: 8.5,
      isNew: true,
      stage: 'Interview',
      expectedSalary: '₹ 25 - 30 LPA',
      rating: 4.9,
      company: 'Google India',
      appliedDate: '2 days ago',
    ),
    CandidateModel(
      id: 'cand_2',
      name: 'Priya Singh',
      role: 'Python Backend Engineer',
      location: 'Bangalore, India',
      experience: '4 Years',
      skills: ['Python', 'Django', 'PostgreSQL', 'AWS'],
      matchPercentage: 88,
      score: 7.9,
      isNew: true,
      stage: 'Screening',
      expectedSalary: '₹ 18 - 22 LPA',
      rating: 4.5,
      company: 'Infosys',
      appliedDate: '3 days ago',
    ),
    CandidateModel(
      id: 'cand_3',
      name: 'Amit Patel',
      role: 'UI/UX Designer',
      location: 'Mumbai, India',
      experience: '3 Years',
      skills: ['Figma', 'Prototyping', 'Wireframing'],
      matchPercentage: 82,
      score: 7.2,
      isNew: true,
      stage: 'Applied',
      expectedSalary: '₹ 12 - 15 LPA',
      rating: 4.2,
      company: 'Wipro',
      appliedDate: '1 day ago',
    ),
    CandidateModel(
      id: 'cand_4',
      name: 'Sneha Reddy',
      role: 'Frontend Developer',
      location: 'Remote',
      experience: '2 Years',
      skills: ['React', 'JavaScript', 'HTML/CSS'],
      matchPercentage: 76,
      score: 6.8,
      isNew: true,
      stage: 'Offer',
      expectedSalary: '₹ 15 - 18 LPA',
      rating: 4.7,
      company: 'TCS',
      appliedDate: '5 days ago',
    ),
    CandidateModel(
      id: 'cand_5',
      name: 'Vikram Malhotra',
      role: 'DevOps Engineer',
      location: 'Pune, India',
      experience: '6 Years',
      skills: ['Docker', 'Kubernetes', 'AWS', 'CI/CD'],
      matchPercentage: 91,
      score: 8.8,
      isNew: true,
      stage: 'Hired',
      expectedSalary: '₹ 28 - 35 LPA',
      rating: 4.8,
      company: 'Amazon India',
      appliedDate: '1 week ago',
    ),
    CandidateModel(
      id: 'cand_6',
      name: 'Ananya Iyer',
      role: 'Product Designer',
      location: 'Bangalore, India',
      experience: '4 Years',
      skills: ['Figma', 'Design Systems', 'User Research'],
      matchPercentage: 89,
      score: 8.3,
      isNew: true,
      stage: 'Interview',
      expectedSalary: '₹ 20 - 25 LPA',
      rating: 4.6,
      company: 'TechCorp India',
      appliedDate: '2 days ago',
    ),
    CandidateModel(
      id: 'cand_7',
      name: 'Karan Mehta',
      role: 'NodeJS Backend Developer',
      location: 'Hyderabad, India',
      experience: '3 Years',
      skills: ['Node.js', 'Express', 'MongoDB', 'Microservices'],
      matchPercentage: 85,
      score: 7.7,
      isNew: true,
      stage: 'Screening',
      expectedSalary: '₹ 14 - 18 LPA',
      rating: 4.3,
      company: 'Flipkart',
      appliedDate: '3 days ago',
    ),
    CandidateModel(
      id: 'cand_8',
      name: 'Divya Nair',
      role: 'Data Scientist',
      location: 'Chennai, India',
      experience: '5 Years',
      skills: ['Python', 'Machine Learning', 'PyTorch', 'SQL'],
      matchPercentage: 92,
      score: 8.6,
      isNew: true,
      stage: 'Applied',
      expectedSalary: '₹ 22 - 28 LPA',
      rating: 4.9,
      company: 'Swiggy',
      appliedDate: 'Just now',
    ),
    CandidateModel(
      id: 'cand_9',
      name: 'Rohan Verma',
      role: 'Android Engineer',
      location: 'Delhi, India',
      experience: '4 Years',
      skills: ['Kotlin', 'Android Jetpack', 'Coroutines'],
      matchPercentage: 87,
      score: 7.8,
      isNew: true,
      stage: 'Interview',
      expectedSalary: '₹ 16 - 20 LPA',
      rating: 4.4,
      company: 'Paytm',
      appliedDate: '4 days ago',
    ),
    CandidateModel(
      id: 'cand_10',
      name: 'Meera Joshi',
      role: 'QA Automation Lead',
      location: 'Pune, India',
      experience: '6 Years',
      skills: ['Selenium', 'Appium', 'Java', 'CI/CD'],
      matchPercentage: 84,
      score: 7.5,
      isNew: true,
      stage: 'Offer',
      expectedSalary: '₹ 24 - 30 LPA',
      rating: 4.6,
      company: 'Zomato',
      appliedDate: '6 days ago',
    ),
    CandidateModel(
      id: 'cand_11',
      name: 'Siddharth Rao',
      role: 'Full Stack Engineer',
      location: 'Bangalore, India',
      experience: '4 Years',
      skills: ['React', 'Node.js', 'GraphQL', 'PostgreSQL'],
      matchPercentage: 90,
      score: 8.4,
      isNew: true,
      stage: 'Screening',
      expectedSalary: '₹ 18 - 22 LPA',
      rating: 4.5,
      company: 'Razorpay',
      appliedDate: '2 days ago',
    ),
    CandidateModel(
      id: 'cand_12',
      name: 'Pooja Desai',
      role: 'Cloud Architect',
      location: 'Mumbai, India',
      experience: '7 Years',
      skills: ['AWS', 'Azure', 'Terraform', 'Kubernetes'],
      matchPercentage: 95,
      score: 9.0,
      isNew: true,
      stage: 'Applied',
      expectedSalary: '₹ 30 - 40 LPA',
      rating: 5.0,
      company: 'Microsoft India',
      appliedDate: '1 day ago',
    ),
  ];

  static final List<CandidateModel> _candidatesStore = List.from(_defaultCandidates);
  static bool _isLoadingState = false;
  static bool _isErrorState = false;

  static List<CandidateModel> getDummyCandidates() => _candidatesStore;
  static bool get dummyLoading => _isLoadingState;
  static bool get dummyError => _isErrorState;

  Future<List<CandidateModel>> loadCandidates({bool forceRefresh = false}) async {
    return List.from(_candidatesStore);
  }

  Future<void> createCandidate(CandidateModel candidate) async {
    _candidatesStore.insert(0, candidate);
  }

  Future<void> updateCandidate(CandidateModel candidate) async {
    final idx = _candidatesStore.indexWhere((c) => c.id == candidate.id);
    if (idx != -1) {
      _candidatesStore[idx] = candidate;
    }
  }

  Future<void> deleteCandidate(String id) async {
    _candidatesStore.removeWhere((c) => c.id == id);
  }

  Future<void> toggleBookmark(String id) async {
    final idx = _candidatesStore.indexWhere((c) => c.id == id);
    if (idx != -1) {
      _candidatesStore[idx] = _candidatesStore[idx].copyWith(isBookmarked: !_candidatesStore[idx].isBookmarked);
    }
  }
  
  Future<void> updateCandidateStage(String id, String newStage) async {
    final idx = _candidatesStore.indexWhere((c) => c.id == id);
    if (idx != -1) {
      _candidatesStore[idx] = _candidatesStore[idx].copyWith(stage: newStage);
    }
  }
  
  Future<void> bulkUpdateCandidateStage(List<String> ids, String newStage) async {
    for (final id in ids) {
      final idx = _candidatesStore.indexWhere((c) => c.id == id);
      if (idx != -1) {
        _candidatesStore[idx] = _candidatesStore[idx].copyWith(stage: newStage);
      }
    }
  }
  
  Future<void> bulkDeleteCandidates(List<String> ids) async {
    _candidatesStore.removeWhere((c) => ids.contains(c.id));
  }

  Future<void> refresh() async {
    _isLoadingState = true;
    _isErrorState = false;
    await Future.delayed(const Duration(milliseconds: 600));
    if (_candidatesStore.isEmpty) {
      _candidatesStore.addAll(_defaultCandidates);
    }
    _isLoadingState = false;
  }

  Future<void> restoreDefault() async {
    _isLoadingState = false;
    _isErrorState = false;
    _candidatesStore.clear();
    _candidatesStore.addAll(_defaultCandidates);
  }

  Future<void> simulateLoading() async {
    _isLoadingState = true;
    _isErrorState = false;
    Future.delayed(const Duration(seconds: 3), () {
      _isLoadingState = false;
    });
  }

  Future<void> simulateError() async {
    _isLoadingState = false;
    _isErrorState = true;
  }

  Future<void> simulateEmpty() async {
    _isLoadingState = false;
    _isErrorState = false;
    _candidatesStore.clear();
  }
}
