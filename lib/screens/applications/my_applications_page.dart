import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/application_provider.dart';
import '../../widgets/glass_card.dart';
import '../../widgets/neumorphic_button.dart';

class MyApplicationsPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final apps = ref.watch(applicationListProvider);

    return Scaffold(
      appBar: AppBar(title: Text("My Applications")),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: apps.map((a) => GlassCard(
          child: ListTile(
            title: Text(a.job.title),
            subtitle: Text("Status: ${a.status}"),
            trailing: NeuButton(
              text: "View Job",
              onTap: () => Navigator.pushNamed(context, "/job/${a.job.id}"),
            ),
          ),
        )).toList(),
      ),
    );
  }
}
