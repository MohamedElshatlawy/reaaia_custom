import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:reaaia/data/signupModels/profile_store_model.dart';
import 'package:reaaia/data/signupModels/verification_response_model.dart';
import 'package:reaaia/network/networkCallback/NetworkCallback.dart';
import 'package:reaaia/utils/Enums.dart';

class SignUpRepository {

  static Future<String> signUpWithMobileNumber(String mobileNumber) async {
    final response = await NetworkCall.makeCall(
      endPoint: "doctors/register-doctor-with-mobile-number",
      method: HttpMethod.POST,
      requestBody: jsonEncode({"mobile_number": mobileNumber}),
    );
    print("my Response: ${response.toString()}");
    return response['error']['message'];
  }

  static Future<VerificationResponseModel> verifyWithMobileNumber(Map<String,dynamic> body) async {

    final response = await NetworkCall.makeCall(
      endPoint: "doctors/verify-doctor-with-mobile-number",
      method: HttpMethod.POST,
      requestBody: jsonEncode(body),
    );
    print("my Response: ${response['message']}");
    return VerificationResponseModel.fromJson(response);
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


  static Future<int> addProfileStore(ProfileStore profileStore) async {
    final response = await NetworkCall.makeCall(
      endPoint: "doctor/profile/store",
      method: HttpMethod.POST,
      requestBody: jsonEncode(profileStore.toJson()),

    );
    print("my Response: ${response}");
    return response['error']['code'];
  }

  static Future<String> uploadPicture(String collection,File file) async {
    final response = await NetworkCall.makeCall(
      endPoint: "uploader/media/upload",
      method: HttpMethod.POST,
      requestBody: jsonEncode({"collection":collection}),
      isMultipart: true,
      multiPartValues: [
        await MultipartFile.fromPath(
            "files[]", file.path),
      ],

    );
    print("my Response: ${response.toString()}");
    return response['token'];
  }

}
