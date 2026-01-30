import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hire_up_web/core/theme.dart';
import 'package:hire_up_web/screens/applications/my_applications_page.dart';
import 'package:hire_up_web/screens/applications/apply_page.dart';
import 'package:hire_up_web/screens/applications/job_applications_page.dart';
import 'package:hire_up_web/screens/auth/login_page.dart';
import 'package:hire_up_web/screens/auth/signup_page.dart';
import 'package:hire_up_web/screens/jobs/add_job_page.dart';
import 'package:hire_up_web/screens/jobs/jobs_page.dart';
import 'package:hire_up_web/screens/jobs/job_detail_page.dart';
import 'package:hire_up_web/screens/jobs/update_job_page.dart';
import 'package:hire_up_web/screens/splash_screen.dart';
import 'package:hire_up_web/screens/profile/profile_page.dart';

import 'core/api_client.dart';
import 'models/job.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HireUp',
      theme: appTheme,
      debugShowCheckedModeBanner: false,
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => const SplashPage(),
        '/login': (context) => const LoginPage(),
        '/signup': (context) => const SignupPage(),
        '/jobs': (context) => const JobsPage(),
        '/add-job': (context) => AddJobPage(),
        '/my-applications': (context) => const MyApplicationsPage(),
        '/profile': (context) => const ProfilePage(),
      },
      builder: (context, child) {
        // Set context for ApiClient
        WidgetsBinding.instance.addPostFrameCallback((_) {
          ApiClient.setContext(context);
        });
        return child!;
      },
      onGenerateRoute: (settings) {
        // Handle dynamic routes with parameters
        if (settings.name == '/job-detail') {
          final job = settings.arguments as JobModel;
          return MaterialPageRoute(
            builder: (context) => JobDetailPage(job: job),
          );
        } else if (settings.name == '/apply') {
          final jobId = settings.arguments as String;
          return MaterialPageRoute(
            builder: (context) => ApplyPage(jobId: jobId),
          );
        } else if (settings.name == '/job-applications') {
          final jobId = settings.arguments as String;
          return MaterialPageRoute(
            builder: (context) => JobApplicationsPage(jobId: jobId),
          );
        } else if (settings.name == '/update-job') {
          final job = settings.arguments as JobModel;
          return MaterialPageRoute(
            builder: (context) => UpdateJobPage(job: job),
          );
        }
        return null;
      },
    );
  }
}