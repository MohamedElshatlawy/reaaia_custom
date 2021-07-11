import 'dart:convert';


import 'package:reaaia/model/data/loginResponse/foreget_pass_response.dart';
import 'package:reaaia/model/data/loginResponse/login_response.dart';
import 'package:reaaia/network/ServicesURLs.dart';
import 'package:reaaia/network/networkCallback/NetworkCallback.dart';
import 'package:reaaia/utils/Enums.dart';

class LoginRepository {

  static Future<LoginResponse> login(Map<String,dynamic> body) async {

    final response = await NetworkCall.makeCall(
      endPoint: ServicesURLs.LOGIN_URL,
      method: HttpMethod.POST,
      requestBody: jsonEncode(body),
    );
    print("my Response: ${response.toString()}");
    return LoginResponse.fromJson(response);
  }

  static Future<ForgetPassResponse> forgetPasswordSendOtp(Map<String,dynamic> body) async {

    final response = await NetworkCall.makeCall(
      endPoint: ServicesURLs.SEND_OTP_URL,
      method: HttpMethod.POST,
      requestBody: jsonEncode(body),
    );
    print("my Response: ${response.toString()}");
    return ForgetPassResponse.fromJson(response);
  }


  static Future<LoginResponse> forgetPasswordVerifyOtp(Map<String,dynamic> body) async {

    final response = await NetworkCall.makeCall(
      endPoint: ServicesURLs.VERIFY_OTP_URL,
      method: HttpMethod.POST,
      requestBody: jsonEncode(body),
    );
    print("my Response: ${response.toString()}");
    return LoginResponse.fromJson(response);
  }

  static Future<Map<String, dynamic>> resetPassword(Map<String,dynamic> body) async {

    final response = await NetworkCall.makeCall(
      endPoint: ServicesURLs.RESET_PASSWORD_URL,
      method: HttpMethod.POST,
      requestBody: jsonEncode(body),
    );
    print("my Response: ${response.toString()}");
    return response;
  }

}