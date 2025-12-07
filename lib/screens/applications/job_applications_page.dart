import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../providers/application_provider.dart';
import '../../widgets/glass_card.dart';
import '../../widgets/neumorphic_button.dart';

class JobApplicationsPage extends ConsumerWidget {
  final String jobId;

  const JobApplicationsPage({super.key, required this.jobId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final apps = ref.watch(applicationListProvider);

    return Scaffold(
      appBar: AppBar(title: Text("Applications")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: GlassCard(
          child: Column(
            children: [
              Text("Applicants", style: Theme.of(context).textTheme.headlineLarge),
              const SizedBox(height: 20),

              DataTable(
                columns: const [
                  DataColumn(label: Text("Name")),
                  DataColumn(label: Text("Resume")),
                  DataColumn(label: Text("Status")),
                  DataColumn(label: Text("Action")),
                ],
                rows: apps.map((a) {
                  return DataRow(cells: [
                    DataCell(Text(a.applicant.name)),
                    DataCell(
                      InkWell(
                        onTap: () => launchUrl(Uri.parse(a.resumeUrl)),
                        child: Text("Open PDF", style: TextStyle(color: Colors.blue)),
                      ),
                    ),
                    DataCell(Text(a.status.toUpperCase())),
                    DataCell(
                      NeuButton(
                        text: "Update",
                        onTap: () => showStatusModal(context, ref, a.id),
                      ),
                    ),
                  ]);
                }).toList(),
              )
            ],
          ),
        ),
      ),
    );
  }

  void showStatusModal(BuildContext context, WidgetRef ref, String id) {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => Container(
        height: 200,
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Text("Update Status", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            NeuButton(
              text: "Accept",
              onTap: () => ref.read(applicationControllerProvider.notifier)
                  .updateStatus(id, "accepted", context),
            ),
            const SizedBox(height: 10),
            NeuButton(
              text: "Reject",
              onTap: () => ref.read(applicationControllerProvider.notifier)
                  .updateStatus(id, "rejected", context),
            ),
          ],
        ),
      ),
    );
  }
}
