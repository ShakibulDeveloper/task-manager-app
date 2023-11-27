import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart';
import 'package:task_manager_app/data/network_caller/network_response.dart';
import 'package:task_manager_app/ui/controller/auth_controller.dart';

class NetworkCaller {
  static Future<NetworkResponse> postRequest(String url,
      {Map<String, dynamic>? body, bool isLogin = false}) async {
    try {
      final Response response =
          await post(Uri.parse(url), body: jsonEncode(body), headers: {
        'Content-type': 'application/json',
        'token': Auth.token.toString(),
      });
      log(response.statusCode.toString());
      log(response.body);
      if (response.statusCode == 200) {
        return NetworkResponse(
          isSuccess: true,
          statusCode: 200,
          jsonResponse: jsonDecode(response.body),
        );
      } else if (response.statusCode == 401) {
        if (isLogin == false) {
          Auth.backToLogin();
        }
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          jsonResponse: jsonDecode(response.body),
        );
      } else {
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          jsonResponse: jsonDecode(response.body),
        );
      }
    } catch (e) {
      log(e.toString());
      return NetworkResponse(isSuccess: false, errorMessage: e.toString());
    }
  }

  static Future<NetworkResponse> getRequest(String url) async {
    try {
      final Response response = await get(Uri.parse(url), headers: {
        'Content-type': 'application/json',
        'token': Auth.token.toString(),
      });
      log(response.statusCode.toString());
      log(response.body);
      if (response.statusCode == 200) {
        return NetworkResponse(
          isSuccess: true,
          statusCode: 200,
          jsonResponse: jsonDecode(response.body),
        );
      } else if (response.statusCode == 401) {
        Auth.backToLogin();
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          jsonResponse: jsonDecode(response.body),
        );
      } else {
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          jsonResponse: jsonDecode(response.body),
        );
      }
    } catch (e) {
      log(e.toString());
      return NetworkResponse(isSuccess: false, errorMessage: e.toString());
    }
  }
}
