import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hire_up_web/screens/applications/apply_page.dart';

import '../../models/job.dart';
import '../../providers/auth_provider.dart';
import '../../widgets/glass_card.dart';
import '../../widgets/neumorphic_button.dart';

class JobDetailPage extends ConsumerWidget {
  final JobModel job;
  const JobDetailPage({super.key, required this.job});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authControllerProvider.notifier).user;

    return Scaffold(
      appBar: AppBar(title: Text(job.title)),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: GlassCard(
          padding: EdgeInsets.all(26),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(job.title, style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),

              Text(job.company, style: TextStyle(fontSize: 20, color: Colors.black54)),
              SizedBox(height: 20),

              Text("Location: ${job.location}", style: TextStyle(fontSize: 18)),
              SizedBox(height: 20),

              Wrap(
                spacing: 10,
                children: job.tags.map((t) => Chip(label: Text(t))).toList(),
              ),

              SizedBox(height: 20),

              Text("Salary Range",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
              Text("${job.startingSalary} - ${job.endingSalary} PKR",
                  style: TextStyle(fontSize: 18, color: Colors.green)),

              SizedBox(height: 30),

              Text("Job Description",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),

              Text(job.description,
                  style: TextStyle(fontSize: 16, color: Colors.black87)),

              SizedBox(height: 40),

              if (user?.role == "job_seeker")
                Center(
                  child: NeuButton(
                    text: "Apply Now",
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ApplyPage(jobId: job.id))),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
