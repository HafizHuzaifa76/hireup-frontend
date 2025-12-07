import 'package:hire_up_web/models/user.dart';

import 'job.dart';

class ApplicationModel {
  final String id;
  final String status;
  final String resumeUrl;
  final JobModel job;
  final UserModel applicant;

  ApplicationModel({
    required this.id,
    required this.status,
    required this.resumeUrl,
    required this.job,
    required this.applicant,
  });

  factory ApplicationModel.fromJson(Map<String, dynamic> json) =>
      ApplicationModel(
        id: json["_id"],
        status: json["status"],
        resumeUrl: json["resume_url"],
        job: JobModel.fromJson(json["job_id"]),
        applicant: UserModel.fromJson(json["applicant_id"]),
      );
}
