import 'dart:convert';
import '../../../core/api_client.dart';
import '../../../config/api.dart';
import '../models/job.dart';

class JobService {
  Future<List<JobModel>> getJobs({String search = ""}) async {
    final res = await ApiClient.get(ApiConfig.getJobs);
    // final res = await ApiClient.get(ApiConfig.getJobs(search: search));

    print(res);
    final data = jsonDecode(res.body);
    List jobs = data['data']['jobs'];
    return jobs.map((e) => JobModel.fromJson(e)).toList();
  }

  Future<Map<String, dynamic>> addJob(String token, Map body) async {
    final res = await ApiClient.post(ApiConfig.addJob, body: body);
    var data = jsonDecode(res.body);
    if(res.statusCode == 200){
      data['success'] = true;
    }
    return data;
  }

  Future<Map<String, dynamic>> updateJob(String token, String id, Map body) async {
    final res = await ApiClient.patch(ApiConfig.updateJob(id), body: body);
    var data = jsonDecode(res.body);
    if(res.statusCode == 200){
      data['success'] = true;
    }
    return data;
  }

  Future<Map<String, dynamic>> deleteJob(String token, String id) async {
    final res = await ApiClient.delete(ApiConfig.deleteJob(id));
    var data = jsonDecode(res.body);
    if(res.statusCode == 200){
      data['success'] = true;
    }
    return data;
  }

  // Future<JobModel> getJobDetail(String id) async {
  //   final res = await ApiClient.get(ApiConfig.getJobs(id));
  //   return JobModel.fromJson(jsonDecode(res.body));
  // }
}
