import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../core/secure_storage.dart';
import '../models/application.dart';
import '../services/application_service.dart';
import 'auth_provider.dart';

final applicationControllerProvider =
StateNotifierProvider<ApplicationController, bool>(
        (ref) => ApplicationController(ref));

final applicationListProvider =
StateProvider<List<ApplicationModel>>((ref) => []);

class ApplicationController extends StateNotifier<bool> {
  final Ref ref;
  final _service = ApplicationService();

  ApplicationController(this.ref) : super(false);

  Future<void> apply(String jobId, String resumeUrl, BuildContext context) async {
    final token = ref.read(authControllerProvider.notifier).token;

    state = true;

    final res = await _service.applyForJob(token!, {
      "job_id": jobId,
      "resume_url": resumeUrl,
      "status": "pending",
    });

    state = false;

    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(res["message"] ?? "Applied")));
  }

  Future<void> loadJobApplications(String jobId, BuildContext context) async {
    final token = ref.read(authControllerProvider.notifier).token;

    final apps = await _service.jobApplications(token!, jobId);
    ref.read(applicationListProvider.notifier).state = apps;
  }

  Future<void> loadMyApplications(BuildContext context) async {
    final token = ref.read(authControllerProvider.notifier).token;

    final apps = await _service.myApplications(token!);
    ref.read(applicationListProvider.notifier).state = apps;
  }

  Future<void> updateStatus(String id, String status, BuildContext context) async {
    final token = ref.read(authControllerProvider.notifier).token;

    final res = await _service.updateStatus(token!, id, {"status": status});

    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(res["message"] ?? "Updated")));

    Navigator.pop(context);
  }

  Future<String> uploadPdfAndGetUrl(Uint8List file, String filename, BuildContext context) async {
    final token = await SecureStorage.getToken();
    print('token');
    print(token);
    final res = await _service.uploadPdf(token!, file, filename);
    print('res1122');
    print(res);

    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(res["message"] ?? "Updated")));
    return res["data"]["url"];
  }
}
