import 'package:flutter/material.dart';
import 'package:reaaia/data/loginResponse/foreget_pass_response.dart';
import 'package:reaaia/data/loginResponse/login_response.dart';
import 'package:reaaia/repos/login_repo.dart';

class LoginProvider extends ChangeNotifier {
  LoginResponse loginResponse;
  ForgetPassResponse forgetPassResponse;
  int status;

  Future<void> login(Map<String, dynamic> bodyRequest) async {
    await LoginRepository.login(bodyRequest).then((value) {
      loginResponse = value;
      notifyListeners();
    });
  }
  Future<void> forgetPasswordSendOtp(Map<String, dynamic> bodyRequest) async {
    await LoginRepository.forgetPasswordSendOtp(bodyRequest).then((value) {
      forgetPassResponse = value;
      notifyListeners();
    });
  }
  Future<void> forgetPasswordVerifyOtp(Map<String, dynamic> bodyRequest) async {
    await LoginRepository.forgetPasswordVerifyOtp(bodyRequest).then((value) {
      loginResponse = value;
      notifyListeners();
    });
  }

  Future<void> resetPassword(Map<String, dynamic> bodyRequest) async {
    await LoginRepository.resetPassword(bodyRequest).then((value) {
      status = value['status'];
      notifyListeners();
    });
  }
}
