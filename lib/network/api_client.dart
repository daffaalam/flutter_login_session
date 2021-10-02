import 'package:http/http.dart';

import '../common/constant.dart';
import '../model/req_res_login.dart';

class ApiClient {
  static Future<ReqResLogin> getToken({
    required String email,
    required String password,
  }) async {
    Response _response = await post(
      Uri.https(Constant.baseDomain, '/api/login'),
      body: <String, dynamic>{
        'email': email,
        'password': password,
      },
    );
    return ReqResLogin.fromJson(_response.body);
  }
}
