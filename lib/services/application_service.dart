import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../core/api_client.dart';
import '../../../config/api.dart';
import '../models/application.dart';

class ApplicationService {
  Future<Map<String, dynamic>> applyForJob(String token, Map payload) async {
    final res = await ApiClient.post(
      ApiConfig.apply,
      body: payload,
    );

    var data = jsonDecode(res.body);
    if(res.statusCode == 200) {
      data['success'] = true;
    }
    return data;
  }

  Future<Map<String, dynamic>> uploadPdf(String token, dynamic file, String fileName) async {
    var request =
    http.MultipartRequest("POST", Uri.parse(ApiConfig.uploadPdf));
    request.headers["Authorization"] = "Bearer $token";

    print('requesting');
    request.files.add(await http.MultipartFile.fromBytes(
      "file",
      file,
      filename: fileName,
    ));

    print('sending');

    try {
      var response = await request.send();
      print('statusCode');
      print(response.statusCode);
      return jsonDecode(await response.stream.bytesToString());
    } on Exception catch (e) {
      print('exception: $e');
      return {};
    }
  }

  Future<List<ApplicationModel>> jobApplications(String token, String jobId) async {
    final res = await ApiClient.get(
      ApiConfig.jobApplications(jobId),
    );

    List data = jsonDecode(res.body);
    return data.map((e) => ApplicationModel.fromJson(e)).toList();
  }

  Future<List<ApplicationModel>> myApplications(String token) async {
    final res = await ApiClient.get(
      ApiConfig.myApplications,
    );

    List data = jsonDecode(res.body);
    return data.map((e) => ApplicationModel.fromJson(e)).toList();
  }

  Future<Map<String, dynamic>> updateStatus(String token, String id, Map payload) async {
    final res = await ApiClient.patch(
      ApiConfig.updateApplication(id),
      body: payload,
    );

    var data = jsonDecode(res.body);
    if(res.statusCode == 200){
      data['success'] = true;
    }
    return data;
  }
}
