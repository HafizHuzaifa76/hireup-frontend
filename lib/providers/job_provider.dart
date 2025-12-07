import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../models/job.dart';
import '../services/job_service.dart';
import 'auth_provider.dart';

final jobControllerProvider =
StateNotifierProvider<JobController, bool>((ref) => JobController(ref));

final jobListProvider = StateProvider<List<JobModel>>((ref) => []);

class JobController extends StateNotifier<bool> {
  final Ref ref;
  final _service = JobService();

  JobController(this.ref) : super(false);

  // --------------------------
  // Load jobs
  // --------------------------
  Future<void> loadJobs({String search = ""}) async {
    final jobs = await _service.getJobs(search: search);
    print(jobs.length);
    ref.read(jobListProvider.notifier).state = jobs;
  }

  Future<void> searchJobs(String text) async {
    await loadJobs(search: text);
  }

  // --------------------------
  // Add Job
  // --------------------------
  Future<void> addJob(Map data, BuildContext context) async {
    state = true;

    final token = ref.read(authControllerProvider.notifier).token!;
    final res = await _service.addJob(token, data);

    state = false;

    _snack(context, res["message"]);
    if (res["success"]) Navigator.pop(context);

    await loadJobs();
  }

  // --------------------------
  // Update Job
  // --------------------------
  Future<void> updateJob(String id, Map data, BuildContext context) async {
    state = true;

    final token = ref.read(authControllerProvider.notifier).token!;
    final res = await _service.updateJob(token, id, data);

    state = false;

    _snack(context, res["message"]);
    if (res["success"]) Navigator.pop(context);

    await loadJobs();
  }

  // --------------------------
  // Delete Job
  // --------------------------
  Future<void> deleteJob(String id, BuildContext context) async {
    final token = ref.read(authControllerProvider.notifier).token!;

    final res = await _service.deleteJob(token, id);
    _snack(context, res["message"]);

    await loadJobs();
  }

  void _snack(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
  }
}
