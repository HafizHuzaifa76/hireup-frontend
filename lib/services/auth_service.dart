import 'dart:convert';
import '../../../core/api_client.dart';
import '../../../config/api.dart';

class AuthService {
  Future<Map<String, dynamic>> signup(Map body) async {
    final res = await ApiClient.post(ApiConfig.signup, body: body);
    var data = jsonDecode(res.body);
    if(res.statusCode == 200){
      data['success'] = true;
    }
    return data;
  }

  Future<Map<String, dynamic>> login(Map body) async {
    final res = await ApiClient.postWithoutToken(ApiConfig.signin, body: body);
    var data = jsonDecode(res.body);
    if(res.statusCode == 200){
      data['success'] = true;
    }
    return data;
  }

  Future<Map<String, dynamic>> verifyToken(String token) async {
    final res = await ApiClient.get(ApiConfig.verify);
    var data = jsonDecode(res.body);
    if(res.statusCode == 200){
      data['success'] = true;
    }
    return data;
  }
}
