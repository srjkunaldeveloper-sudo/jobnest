import 'package:flutter/material.dart';
import 'package:jobnest/core/models/recruitment_models.dart';

class CompanyProvider extends ChangeNotifier {
  final List<CompanyModel> _companies = [];

  static const List<CompanyModel> _defaultCompanies = [
    CompanyModel(
      id: 'comp_1',
      name: 'TechCorp India',
      industry: 'Information Technology',
      location: 'Delhi, India',
      openPositions: 14,
      description: 'Leading enterprise software solutions provider specializing in cloud infrastructure and scalable backend services.',
    ),
    CompanyModel(
      id: 'comp_2',
      name: 'Innovate AI',
      industry: 'Artificial Intelligence',
      location: 'Bangalore, India',
      openPositions: 8,
      description: 'Pioneering AI research lab building next-generation deep learning models and predictive analytics platforms.',
    ),
    CompanyModel(
      id: 'comp_3',
      name: 'Creative Studio',
      industry: 'Design & Media',
      location: 'Mumbai, India',
      openPositions: 5,
      description: 'Award-winning digital design agency crafting exceptional user experiences and brand identities globally.',
    ),
    CompanyModel(
      id: 'comp_4',
      name: 'NextGen Solutions',
      industry: 'Fintech',
      location: 'Pune, India',
      openPositions: 11,
      description: 'Fast-growing financial technology company empowering modern digital banking and payment workflows.',
    ),
    CompanyModel(
      id: 'comp_5',
      name: 'Tech Innovators Pvt Ltd',
      industry: 'Software Engineering',
      location: 'Delhi, India',
      openPositions: 18,
      description: 'Innovative product studio focused on mobile apps, web platforms, and enterprise recruitment suites.',
    ),
  ];

  CompanyProvider() {
    restoreDefault(notify: false);
  }

  List<CompanyModel> get companies => List.unmodifiable(_companies);

  void simulateEmpty() {
    _companies.clear();
    notifyListeners();
  }

  void restoreDefault({bool notify = true}) {
    _companies.clear();
    _companies.addAll(_defaultCompanies);
    if (notify) notifyListeners();
  }
}
