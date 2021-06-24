
import 'package:flutter/material.dart';
import 'package:reaaia/data/signupModels/serve_model.dart';
import 'package:reaaia/repos/sign_up_repo.dart';

class SignUpProvider extends ChangeNotifier {

String messageResponseSignUp;
String messageResponseVerify;
String messageResponseResendCode;

List<ServeModel> serves=[];



void addServe(ServeModel serveModel){
  serves.add(serveModel);
  notifyListeners();
}

void updateTask(ServeModel serveModel,int index){
  serves.insert(index,serveModel);
  notifyListeners();
}


 Future<void> signUpWithMobileNumber(String number) async{
   await SignUpRepository.signUpWithMobileNumber(number).then((value) {
    messageResponseSignUp = value;
    notifyListeners();
  });
}

Future<void> verifyWithMobileNumber(Map<String,dynamic> body) async{
  await SignUpRepository.verifyWithMobileNumber(body).then((value) {
    messageResponseVerify = value;
    notifyListeners();
  });
}

Future<void> resendCode(String number) async{
  await SignUpRepository.resendVerificationCode(number).then((value) {
    messageResponseResendCode = value;
    notifyListeners();
  });
}


}