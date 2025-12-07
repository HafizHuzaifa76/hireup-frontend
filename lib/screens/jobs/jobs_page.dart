import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../widgets/glass_card.dart';
import '../../../widgets/neumorphic_button.dart';
import '../../models/job.dart';
import '../../providers/auth_provider.dart';
import '../../providers/job_provider.dart';
import '../../widgets/app_text_field.dart';
import '../applications/apply_page.dart';
import 'job_detail_page.dart';

class JobsPage extends ConsumerStatefulWidget {
  const JobsPage({super.key});

  @override
  ConsumerState createState() => _JobsPageState();
}

class _JobsPageState extends ConsumerState<JobsPage> {
  final searchCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(jobControllerProvider.notifier).loadJobs();
    });
  }

  @override
  Widget build(BuildContext context) {
    final jobs = ref.watch(jobListProvider);
    final user = ref.watch(authControllerProvider.notifier).user;

    return Scaffold(
      appBar: AppBar(
        title: Text("Job Marketplace", style: TextStyle(fontSize: 26)),
        actions: [
          IconButton(
            icon: Icon(Icons.person_outline),
            onPressed: () => Navigator.pushNamed(context, "/profile"),
          ),
        ],
      ),

      floatingActionButton: user?.role == "employer"
          ? FloatingActionButton.extended(
        onPressed: () => Navigator.pushNamed(context, "/add-job"),
        label: Text("Post Job"),
        icon: Icon(Icons.add),
      )
          : null,

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            GlassCard(
              child: Row(
                children: [
                  Expanded(
                    child: AppTextField(
                      controller: searchCtrl,
                      label: "Search jobs...",
                    ),
                  ),
                  const SizedBox(width: 20),
                  NeuButton(
                    text: "Search",
                    onTap: () {
                      ref.read(jobControllerProvider.notifier)
                          .searchJobs(searchCtrl.text);
                    },
                  )
                ],
              ),
            ),

            const SizedBox(height: 30),

            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  int columns = constraints.maxWidth > 1200
                      ? 4
                      : constraints.maxWidth > 900
                      ? 3
                      : constraints.maxWidth > 600
                      ? 2
                      : 1;

                  return GridView.count(
                    crossAxisCount: columns,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 20,
                    children: jobs.map((j) => jobCard(context, j)).toList(),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget jobCard(BuildContext context, JobModel job) {
    final user = ref.watch(authControllerProvider.notifier).user;

    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => JobDetailPage(job: job))),
      // onTap: () => Navigator.pushNamed(context, "/job/${job.id}"),
      child: GlassCard(
        padding: EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(job.title,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 6),
            Text(job.company, style: TextStyle(color: Colors.black54)),
            SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: job.tags
                  .map((t) => Chip(
                label: Text(t),
                backgroundColor: Colors.blue.shade50,
              ))
                  .toList(),
            ),
            Spacer(),
            Text(
              "${job.startingSalary} - ${job.endingSalary} PKR",
              style: TextStyle(color: Colors.green.shade700),
            ),
            SizedBox(height: 14),
            if (user?.role == "job_seeker")
              NeuButton(
                text: "Apply",
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ApplyPage(jobId: job.id))),
              )
          ],
        ),
      ),
    );
  }
}
