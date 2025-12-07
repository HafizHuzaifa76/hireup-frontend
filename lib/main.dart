import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hire_up_web/core/theme.dart';
import 'package:hire_up_web/screens/applications/my_applications_page.dart';
import 'package:hire_up_web/screens/auth/login_page.dart';
import 'package:hire_up_web/screens/auth/signup_page.dart';
import 'package:hire_up_web/screens/jobs/add_job_page.dart';
import 'package:hire_up_web/screens/jobs/jobs_page.dart';
import 'package:hire_up_web/screens/splash_screen.dart';

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
      // START HERE
      initialRoute: '/splash',

      routes: {
        '/splash': (context) => const SplashPage(),
        '/login': (context) => LoginPage(),
        '/signup': (context) => SignupPage(),
        '/jobs': (context) => const JobsPage(),
        '/add-job': (context) => AddJobPage(),
        '/my-applications': (context) => MyApplicationsPage(),
        // Note: Routes that require an ID like '/job/:id' or '/apply/:id'
        // cannot be handled by the basic 'routes' map. You would need
        // to use the 'onGenerateRoute' property for more advanced routing.
        // For now, I have included all routes that do not require an ID.
      },
      // You can set a default home if initialRoute is not used,
      // but it's better to use initialRoute when using a routes table.
      // home: LoginPage(),
    );
  }
}
