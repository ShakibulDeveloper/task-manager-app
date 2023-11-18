import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart';
import 'package:task_manager_app/data/network_caller/network_response.dart';

class NetworkCaller {
  static Future<NetworkResponse> postRequest(String url,
      {Map<String, dynamic>? body}) async {
    try {
      final Response response =
          await post(Uri.parse(url), body: jsonEncode(body), headers: {
        'Content-type': 'application/json',
      });
      log(response.statusCode.toString());
      log(response.body);
      if (response.statusCode == 200) {
        return NetworkResponse(
          isSuccess: true,
          statusCode: 200,
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
