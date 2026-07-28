import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:jobnest/features/jobs/providers/job_provider.dart';
import 'package:jobnest/features/jobs/providers/job_form_provider.dart';
import 'package:jobnest/features/jobs/jobs_screen.dart';
import 'package:jobnest/features/jobs/job_details_screen.dart';
import 'package:jobnest/features/jobs/widgets/wizard_steps/create_job_wizard.dart';

void main() {
  testWidgets('Full Create Job Wizard audit across all 6 steps (Create Mode)', (WidgetTester tester) async {
    final provider = JobProvider();

    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<JobProvider>.value(value: provider),
          ChangeNotifierProvider(create: (_) => JobFormProvider()),
        ],
        child: const MaterialApp(
          home: CreateJobWizard(),
        ),
      ),
    );

    await tester.pumpAndSettle();

    // Step 0: Basic Job Details
    expect(find.text("Create New Job"), findsOneWidget);
    expect(find.text("Basic Job Details"), findsOneWidget);
    expect(find.text("Job Title *"), findsOneWidget);
    expect(find.text("Company Name *"), findsOneWidget);
    expect(find.text("Location *"), findsOneWidget);

    // Enter required fields for validation
    await tester.enterText(find.byType(TextFormField).at(0), "Senior Flutter Engineer");
    await tester.enterText(find.byType(TextFormField).at(2), "Bangalore, India");
    await tester.pumpAndSettle();

    // Go to Step 1
    await tester.tap(find.text("Next"));
    await tester.pumpAndSettle();

    // Step 1: AI Job Description
    expect(find.text("AI Job Description"), findsOneWidget);
    expect(find.text("Generated Description (Editable)"), findsOneWidget);

    // Go to Step 2
    await tester.tap(find.text("Next"));
    await tester.pumpAndSettle();

    // Step 2: Compensation
    expect(find.text("Compensation"), findsOneWidget);
    expect(find.text("AI Salary Insights"), findsOneWidget);

    // Go to Step 3
    await tester.tap(find.text("Next"));
    await tester.pumpAndSettle();

    // Step 3: Requirements
    expect(find.text("Requirements"), findsOneWidget);
    expect(find.text("Top Skills"), findsOneWidget);

    // Go to Step 4
    await tester.tap(find.text("Next"));
    await tester.pumpAndSettle();

    // Step 4: Hiring Settings
    expect(find.text("Hiring Settings"), findsOneWidget);
    expect(find.text("Advanced Toggles"), findsOneWidget);

    // Go to Step 5
    await tester.tap(find.text("Next"));
    await tester.pumpAndSettle();

    // Step 5: Review & Publish
    expect(find.text("Review & Publish"), findsOneWidget);
    expect(find.text("Publish Job"), findsOneWidget);

    // Test Back button
    await tester.tap(find.text("Back"));
    await tester.pumpAndSettle();
    expect(find.text("Hiring Settings"), findsOneWidget);

    // Go forward to Publish again
    await tester.tap(find.text("Next"));
    await tester.pumpAndSettle();

    // Publish Job
    final initialJobsCount = provider.jobs.length;
    await tester.tap(find.text("Publish Job"));
    await tester.pumpAndSettle();

    expect(provider.jobs.length, initialJobsCount + 1);
  });

  testWidgets('Audit JobsScreen FAB opening CreateJobWizard', (WidgetTester tester) async {
    final provider = JobProvider();

    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<JobProvider>.value(value: provider),
          ChangeNotifierProvider(create: (_) => JobFormProvider()),
        ],
        child: const MaterialApp(
          home: JobsScreen(),
        ),
      ),
    );

    await tester.pumpAndSettle();

    final fab = find.byType(FloatingActionButton);
    expect(fab, findsOneWidget);
    await tester.tap(fab);
    await tester.pumpAndSettle();

    expect(find.text("Create New Job"), findsOneWidget);
    expect(find.text("Basic Job Details"), findsOneWidget);
  });

  testWidgets('Audit JobDetailsScreen FAB opening CreateJobWizard (Edit Requisition)', (WidgetTester tester) async {
    final provider = JobProvider();

    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<JobProvider>.value(value: provider),
          ChangeNotifierProvider(create: (_) => JobFormProvider()),
        ],
        child: const MaterialApp(
          home: JobDetailsScreen(
            title: "Senior Developer",
            company: "TechCorp",
            location: "Remote",
            salary: "15 LPA",
            jobType: "Full Time",
            status: "Open",
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    final fab = find.byType(FloatingActionButton);
    expect(fab, findsOneWidget);
    await tester.tap(fab);
    await tester.pumpAndSettle();

    expect(find.text("Edit Job Requisition"), findsOneWidget);
    expect(find.text("Basic Job Details"), findsOneWidget);
  });

  testWidgets('Verify Edit flow, edited job updates correctly, and no duplicate records', (WidgetTester tester) async {
    final provider = JobProvider();
    final jobToEdit = provider.jobs.first;
    final initialJobsCount = provider.jobs.length;

    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<JobProvider>.value(value: provider),
          ChangeNotifierProvider(create: (_) => JobFormProvider()),
        ],
        child: MaterialApp(
          home: CreateJobWizard(initialJob: jobToEdit),
        ),
      ),
    );

    await tester.pumpAndSettle();

    // Verify Edit Mode title
    expect(find.text("Edit Job Requisition"), findsOneWidget);
    expect(find.text(jobToEdit.title), findsOneWidget);

    // Change Title on Step 0
    await tester.enterText(find.byType(TextFormField).at(0), "Lead Flutter Architect");
    await tester.pumpAndSettle();

    // Navigate to Step 5 (Preview)
    for (int i = 0; i < 5; i++) {
      await tester.tap(find.text("Next"));
      await tester.pumpAndSettle();
    }

    // Verify preview reflects edited values live
    expect(find.text("Lead Flutter Architect"), findsOneWidget);
    expect(find.text("Save Changes"), findsOneWidget);

    // Save changes
    await tester.tap(find.text("Save Changes"));
    await tester.pumpAndSettle();

    // Verify job count is identical (no duplicate records)
    expect(provider.jobs.length, initialJobsCount);

    // Verify edited job updated in provider
    final updatedJob = provider.jobs.firstWhere((j) => j.id == jobToEdit.id);
    expect(updatedJob.title, "Lead Flutter Architect");
  });
}
