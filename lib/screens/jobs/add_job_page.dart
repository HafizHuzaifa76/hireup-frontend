import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/job_provider.dart';
import '../../widgets/app_text_field.dart';
import '../../widgets/glass_card.dart';
import '../../widgets/neumorphic_button.dart';

class AddJobPage extends ConsumerWidget {
  final title = TextEditingController();
  final company = TextEditingController();
  final description = TextEditingController();
  final location = TextEditingController();
  final startSalary = TextEditingController();
  final endSalary = TextEditingController();
  final tags = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loading = ref.watch(jobControllerProvider);

    return Scaffold(
      appBar: AppBar(title: Text("Post a New Job")),

      body: Center(
        child: SizedBox(
          width: 600,
          child: GlassCard(
            padding: EdgeInsets.all(30),
            child: Column(
              children: [
                Text("Add Job", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                SizedBox(height: 20),

                AppTextField(label: "Job Title", controller: title),
                SizedBox(height: 15),

                AppTextField(label: "Company", controller: company),
                SizedBox(height: 15),

                AppTextField(label: "Location", controller: location),
                SizedBox(height: 15),

                AppTextField(label: "Starting Salary", controller: startSalary),
                SizedBox(height: 15),

                AppTextField(label: "Ending Salary", controller: endSalary),
                SizedBox(height: 15),

                AppTextField(label: "Tags (comma separated)", controller: tags),
                SizedBox(height: 20),

                AppTextField(
                  label: "Description",
                  controller: description,
                  minLines: 4,
                  maxLines: 6,
                ),

                SizedBox(height: 30),

                NeuButton(
                  text: loading ? "Posting..." : "Post Job",
                  onTap: () {
                    ref.read(jobControllerProvider.notifier).addJob({
                      "title": title.text,
                      "company": company.text,
                      "location": location.text,
                      "description": description.text,
                      "starting_salary_range": int.parse(startSalary.text),
                      "ending_salary_range": int.parse(endSalary.text),
                      "tags": tags.text.split(",").map((e) => e.trim()).toList(),
                    }, context);
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
