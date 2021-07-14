import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';
import 'package:reaaia/model/data/signup/profile_store_model.dart';
import 'package:reaaia/model/data/signup/verification_response_model.dart';
import 'package:reaaia/network/ServicesURLs.dart';
import 'package:reaaia/network/networkCallback/NetworkCallback.dart';
import 'package:reaaia/utils/Enums.dart';

class SignUpRepository {

  static Future<String> signUpWithMobileNumber(String mobileNumber) async {
    final response = await NetworkCall.makeCall(
      endPoint: ServicesURLs.SIGN_UP_MOBILE_URL,
      method: HttpMethod.POST,
      requestBody: jsonEncode({"mobile_number": mobileNumber}),
    );
    print("my Response: ${response.toString()}");
    return response['error']['message'];
  }

  static Future<VerificationResponseModel> verifyWithMobileNumber(Map<String,dynamic> body) async {

    final response = await NetworkCall.makeCall(
      endPoint: ServicesURLs.VERIFY_MOBILE_URL,
      method: HttpMethod.POST,
      requestBody: jsonEncode(body),
    );
    print("my Response: ${response['message']}");
    return VerificationResponseModel.fromJson(response);
  }

  static Future<String> resendVerificationCode(String mobileNumber) async {
    final response = await NetworkCall.makeCall(
      endPoint: ServicesURLs.RESEND_CODE_URL,
      method: HttpMethod.POST,
      requestBody: jsonEncode({"mobile_number": mobileNumber}),
    );
    print("my Response: ${response['error']['message']}");
    return response['error']['message'];
  }


  static Future<int> addProfileStore(ProfileStore profileStore) async {
    final response = await NetworkCall.makeCall(
      endPoint: ServicesURLs.PROFILE_STORE_URL,
      method: HttpMethod.POST,
      requestBody: jsonEncode(profileStore.toJson()),

    );
    print("my Response: ${response}");
    return response['error']['code'];
  }

  static Future<String> uploadPicture(String collection,File file) async {
    final response = await NetworkCall.makeCall(
      endPoint: ServicesURLs.UPLOAD_MEDIA_URL,
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
