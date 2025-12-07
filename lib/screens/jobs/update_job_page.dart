import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/job.dart';
import '../../providers/job_provider.dart';
import '../../widgets/app_text_field.dart';
import '../../widgets/glass_card.dart';
import '../../widgets/neumorphic_button.dart';

class UpdateJobPage extends ConsumerWidget {
  final JobModel job;

  UpdateJobPage({required this.job});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final title = TextEditingController(text: job.title);
    final company = TextEditingController(text: job.company);
    final location = TextEditingController(text: job.location);
    final description = TextEditingController(text: job.description);
    final startSalary = TextEditingController(text: job.startingSalary.toString());
    final endSalary = TextEditingController(text: job.endingSalary.toString());
    final tags = TextEditingController(text: job.tags.join(", "));

    final loading = ref.watch(jobControllerProvider);

    return Scaffold(
      appBar: AppBar(title: Text("Update Job")),

      body: Center(
        child: SizedBox(
          width: 600,
          child: GlassCard(
            padding: EdgeInsets.all(30),
            child: Column(
              children: [
                Text("Update Job", style: TextStyle(fontSize: 28)),
                SizedBox(height: 20),

                AppTextField(label: "Title", controller: title),
                SizedBox(height: 15),

                AppTextField(label: "Company", controller: company),
                SizedBox(height: 15),

                AppTextField(label: "Location", controller: location),
                SizedBox(height: 15),

                AppTextField(label: "Starting Salary", controller: startSalary),
                SizedBox(height: 15),

                AppTextField(label: "Ending Salary", controller: endSalary),
                SizedBox(height: 15),

                AppTextField(label: "Tags", controller: tags),
                SizedBox(height: 20),

                AppTextField(
                  label: "Description",
                  controller: description,
                  minLines: 4,
                ),

                SizedBox(height: 30),

                NeuButton(
                  text: loading ? "Updating..." : "Update Job",
                  onTap: () {
                    ref.read(jobControllerProvider.notifier).updateJob(
                      job.id,
                      {
                        "title": title.text,
                        "company": company.text,
                        "location": location.text,
                        "description": description.text,
                        "starting_salary_range": int.parse(startSalary.text),
                        "ending_salary_range": int.parse(endSalary.text),
                        "tags": tags.text.split(",").map((e) => e.trim()).toList(),
                      },
                      context,
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
