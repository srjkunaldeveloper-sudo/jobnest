class JobModel {
  final String id;
  final String title;
  final String company;
  final String location;
  final String salary;
  final String jobType;
  final String applicationsCount;
  final String status;
  final int aiMatchScore;
  final bool isUrgent;
  final bool isBookmarked;
  final String postedDate;
  final String description;
  final List<String> requirements;
  final List<String> responsibilities;
  final List<String> skills;
  final List<String> benefits;
  final String hiringTimeline;

  const JobModel({
    required this.id,
    required this.title,
    required this.company,
    required this.location,
    required this.salary,
    required this.jobType,
    required this.applicationsCount,
    required this.status,
    required this.aiMatchScore,
    this.isUrgent = false,
    this.isBookmarked = false,
    this.postedDate = "2 days ago",
    this.description = "We are seeking a talented and experienced professional to join our dynamic recruitment and tech engineering team. You will collaborate closely with cross-functional stakeholders to deliver high-impact solutions and drive strategic enterprise growth.",
    this.requirements = const [
      "Bachelor's degree in Computer Science, Business Administration, or related technical field.",
      "3+ years of proven professional experience in a fast-paced ATS or SaaS environment.",
      "Strong analytical, problem-solving, and architectural design capabilities.",
      "Excellent communication and cross-team collaboration skills with executive visibility.",
    ],
    this.responsibilities = const [
      "Lead day-to-day project execution, sprint planning, and engineering team coordination.",
      "Collaborate closely with product managers, design leadership, and HR hiring managers.",
      "Mentor junior engineers/team members and foster a culture of continuous technical excellence.",
      "Analyze recruitment funnel metrics and optimize workflows for maximum efficiency.",
    ],
    this.skills = const ["Communication", "Leadership", "Analytics", "Project Management", "Agile Methodology", "Problem Solving"],
    this.benefits = const [
      "Comprehensive Health, Vision & Dental Insurance",
      "Flexible Remote / Hybrid Work Arrangements",
      "401(k) / Retirement Savings Matching up to 6%",
      "Annual Learning & Professional Development Stipend (₹ 50,000)",
    ],
    this.hiringTimeline = "Expected time to hire: 2–3 weeks (Screening → Technical Round → Leadership Fit)",
  });

  JobModel copyWith({
    String? id,
    String? title,
    String? company,
    String? location,
    String? salary,
    String? jobType,
    String? applicationsCount,
    String? status,
    int? aiMatchScore,
    bool? isUrgent,
    bool? isBookmarked,
    String? postedDate,
    String? description,
    List<String>? requirements,
    List<String>? responsibilities,
    List<String>? skills,
    List<String>? benefits,
    String? hiringTimeline,
  }) {
    return JobModel(
      id: id ?? this.id,
      title: title ?? this.title,
      company: company ?? this.company,
      location: location ?? this.location,
      salary: salary ?? this.salary,
      jobType: jobType ?? this.jobType,
      applicationsCount: applicationsCount ?? this.applicationsCount,
      status: status ?? this.status,
      aiMatchScore: aiMatchScore ?? this.aiMatchScore,
      isUrgent: isUrgent ?? this.isUrgent,
      isBookmarked: isBookmarked ?? this.isBookmarked,
      postedDate: postedDate ?? this.postedDate,
      description: description ?? this.description,
      requirements: requirements ?? this.requirements,
      responsibilities: responsibilities ?? this.responsibilities,
      skills: skills ?? this.skills,
      benefits: benefits ?? this.benefits,
      hiringTimeline: hiringTimeline ?? this.hiringTimeline,
    );
  }
}

class CandidateModel {
  final String id;
  final String name;
  final String role;
  final String location;
  final String experience;
  final List<String> skills;
  final int matchPercentage;
  final double score;
  final bool isNew;
  final String expectedSalary;
  final String appliedDate;
  final String stage; // "Applied", "Screening", "Interview", "Offer", "Hired", "Rejected"
  final double rating;
  final String company;
  final String about;
  final String resumeSummary;
  final List<String> education;
  final List<String> notes;
  final List<String> interviewTimeline;
  final List<String> activityHistory;
  final bool isBookmarked;
  final String avatarUrl;

  const CandidateModel({
    required this.id,
    required this.name,
    required this.role,
    required this.location,
    required this.experience,
    required this.skills,
    required this.matchPercentage,
    required this.score,
    this.isNew = false,
    this.expectedSalary = "₹ 18 - 22 LPA",
    this.appliedDate = "2 days ago",
    this.stage = "Screening",
    this.rating = 4.8,
    this.company = "TechCorp India",
    this.about = "Experienced software professional with a strong track record of designing scalable architecture, leading cross-functional teams, and deploying AI-driven solutions in fast-paced product environments.",
    this.resumeSummary = "Senior Architect & Lead Engineer with 5+ years building distributed cloud applications and high-throughput microservices. Proven expertise in system design, CI/CD automation, and mentoring junior engineers.",
    this.education = const [
      "B.Tech in Computer Science & Engineering - IIT Delhi (2015 - 2019)",
      "Executive Certification in AI & Machine Learning - IIIT Hyderabad (2021)",
    ],
    this.notes = const [
      "Initial screening completed on July 20. Candidate demonstrated exceptional problem-solving depth.",
      "Leadership fit verified during cultural alignment discussion. Ready for technical deep-dive.",
    ],
    this.interviewTimeline = const [
      "July 18: Application Received via LinkedIn Recruiter Referral",
      "July 20: AI Auto-Screening Cleared (94% Match)",
      "July 22: Technical Phone Screen with Engineering Manager (Passed)",
      "July 25: Scheduled for System Design & Leadership Round",
    ],
    this.activityHistory = const [
      "Candidate viewed company profile and benefits package (2 hours ago)",
      "Recruiter sent calendar invite for Final Leadership Interview (Yesterday)",
      "Candidate submitted updated portfolio and references (3 days ago)",
    ],
    this.isBookmarked = false,
    this.avatarUrl = "",
  });

  CandidateModel copyWith({
    String? id,
    String? name,
    String? role,
    String? location,
    String? experience,
    List<String>? skills,
    int? matchPercentage,
    double? score,
    bool? isNew,
    String? expectedSalary,
    String? appliedDate,
    String? stage,
    double? rating,
    String? company,
    String? about,
    String? resumeSummary,
    List<String>? education,
    List<String>? notes,
    List<String>? interviewTimeline,
    List<String>? activityHistory,
    bool? isBookmarked,
    String? avatarUrl,
  }) {
    return CandidateModel(
      id: id ?? this.id,
      name: name ?? this.name,
      role: role ?? this.role,
      location: location ?? this.location,
      experience: experience ?? this.experience,
      skills: skills ?? this.skills,
      matchPercentage: matchPercentage ?? this.matchPercentage,
      score: score ?? this.score,
      isNew: isNew ?? this.isNew,
      expectedSalary: expectedSalary ?? this.expectedSalary,
      appliedDate: appliedDate ?? this.appliedDate,
      stage: stage ?? this.stage,
      rating: rating ?? this.rating,
      company: company ?? this.company,
      about: about ?? this.about,
      resumeSummary: resumeSummary ?? this.resumeSummary,
      education: education ?? this.education,
      notes: notes ?? this.notes,
      interviewTimeline: interviewTimeline ?? this.interviewTimeline,
      activityHistory: activityHistory ?? this.activityHistory,
      isBookmarked: isBookmarked ?? this.isBookmarked,
      avatarUrl: avatarUrl ?? this.avatarUrl,
    );
  }
}

class CompanyModel {
  final String id;
  final String name;
  final String industry;
  final String location;
  final int openPositions;
  final String description;

  const CompanyModel({
    required this.id,
    required this.name,
    required this.industry,
    required this.location,
    required this.openPositions,
    required this.description,
  });
}

class InterviewModel {
  final String id;
  final String candidateName;
  final String role;
  final String time;
  final String company;
  final bool isToday;

  const InterviewModel({
    required this.id,
    required this.candidateName,
    required this.role,
    required this.time,
    required this.company,
    this.isToday = true,
  });
}
