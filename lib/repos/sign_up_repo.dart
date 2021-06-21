import 'dart:convert';

import 'package:reaaia/network/networkCallback/NetworkCallback.dart';
import 'package:reaaia/utils/Enums.dart';

class SignUpRepository {

  static Future<String> signUpWithMobileNumber(String mobileNumber) async {
    final response = await NetworkCall.makeCall(
      endPoint: "doctors/register-doctor-with-mobile-number",
      method: HttpMethod.POST,
      requestBody: jsonEncode({"mobile_number": mobileNumber}),
    );
    print("my Response: ${response['error']['message']}");
    return response['error']['message'];
  }

  static Future<String> verifyWithMobileNumber(Map<String,dynamic> body) async {
    final response = await NetworkCall.makeCall(
      endPoint: "doctors/verify-doctor-with-mobile-number",
      method: HttpMethod.POST,
      requestBody: jsonEncode(body),
    );
    print("my Response: ${response['message']}");
    return response['message'];
  }

  static Future<String> resendVerificationCode(String mobileNumber) async {
    final response = await NetworkCall.makeCall(
      endPoint: "doctors/resend-doctor-verification-code",
      method: HttpMethod.POST,
      requestBody: jsonEncode({"mobile_number": mobileNumber}),
    );
    print("my Response: ${response['error']['message']}");
    return response['error']['message'];
  }

}
