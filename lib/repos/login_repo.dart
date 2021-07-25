import 'dart:convert';

import 'package:reaaia/data/loginResponse/login_response.dart';
import 'package:reaaia/model/data/loginResponse/foreget_pass_response.dart';
import 'package:reaaia/network/networkCallback/NetworkCallback.dart';
import 'package:reaaia/utils/Enums.dart';

class LoginRepository {
  static Future<LoginResponse> login(Map<String, dynamic> body) async {
    final response = await NetworkCall.makeCall(
      endPoint: "login",
      method: HttpMethod.POST,
      requestBody: jsonEncode(body),
    );
    print("my Response: ${response.toString()}");
    return LoginResponse.fromJson(response);
  }

  static Future<ForgetPassResponse> forgetPasswordSendOtp(
      Map<String, dynamic> body) async {
    final response = await NetworkCall.makeCall(
      endPoint: "forgot-password/send-otp",
      method: HttpMethod.POST,
      requestBody: jsonEncode(body),
    );
    print("my Response: ${response.toString()}");
    return ForgetPassResponse.fromJson(response);
  }

  static Future<LoginResponse> forgetPasswordVerifyOtp(
      Map<String, dynamic> body) async {
    final response = await NetworkCall.makeCall(
      endPoint: "forgot-password/verify-otp",
      method: HttpMethod.POST,
      requestBody: jsonEncode(body),
    );
    print("my Response: ${response.toString()}");
    return LoginResponse.fromJson(response);
  }

  static Future<Map<String, dynamic>> resetPassword(
      Map<String, dynamic> body) async {
    final response = await NetworkCall.makeCall(
      endPoint: "reset-password",
      method: HttpMethod.POST,
      requestBody: jsonEncode(body),
    );
    print("my Response: ${response.toString()}");
    return response;
  }
}
