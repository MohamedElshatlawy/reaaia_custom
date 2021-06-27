import 'dart:io';

import 'package:flutter/material.dart';
import 'package:reaaia/data/signupModels/complete_reg1_model.dart';
import 'package:reaaia/data/signupModels/complete_reg2_model.dart';
import 'package:reaaia/data/signupModels/complete_reg3_model.dart';
import 'package:reaaia/data/signupModels/profile_store_model.dart';

import 'package:reaaia/data/signupModels/serving_health_care_model.dart';
import 'package:reaaia/data/signupModels/verification_response_model.dart';
import 'package:reaaia/repos/sign_up_repo.dart';

class SignUpProvider extends ChangeNotifier {

String messageResponseSignUp;

String messageResponseResendCode;

VerificationResponseModel verificationResponseModel;

int statusResponseProfile;

String tokenPicture;

ProfileStore profileStore=ProfileStore();

List<ServingInHealthcare> serves=[];

CompleteReg1Model _completeReg1Model;
CompleteReg2Model _completeReg2Model;
CompleteReg3Model _completeReg3Model;

void setCompleteReg1Model(CompleteReg1Model completeReg1Model) {
  _completeReg1Model = completeReg1Model;
  print(_completeReg1Model.gender.toString());
  notifyListeners();
}

void setCompleteReg2Model(CompleteReg2Model completeReg2Model) {
  _completeReg2Model = completeReg2Model;
  print(_completeReg2Model.languages[0].languageId);
  print(_completeReg2Model.specialityId);
  notifyListeners();
}
void setCompleteReg3Model(CompleteReg3Model completeReg3Model) {
  _completeReg3Model = completeReg3Model;
  print(_completeReg3Model.ownedClinic.clinicName.toString());
  notifyListeners();
}

void setProfileStore() {
  profileStore = ProfileStore(
    avatarImage: _completeReg1Model.avatarImage, /// hint for back to it again
    doctorUserId: _completeReg1Model.doctorUserId,
    name: _completeReg1Model.name,
    email: _completeReg1Model.email,
    password: _completeReg1Model.password,
    passwordConfirmation: _completeReg1Model.passwordConfirmation,
    nationalId: _completeReg1Model.nationalId,
    gender: _completeReg1Model.gender,
    dateOfBirth: _completeReg1Model.dateOfBirth,
    address: _completeReg1Model.address,
    scientificDegree: _completeReg2Model.scientificDegree,
    specialityId: _completeReg2Model.specialityId,
    existingSubspecialities: _completeReg2Model.existingSubspecialities,
    newSubspecialities: _completeReg2Model.newSubspecialities,
    practiceLicenceImage: _completeReg2Model.practiceLicenceImage,
    university: _completeReg2Model.university,
    languages: _completeReg2Model.languages,
    certifications: _completeReg2Model.certifications,
    awards: _completeReg2Model.awards,
    ownedClinic: _completeReg3Model.ownedClinic,
    servingInHealthcare: _completeReg3Model.servingInHealthcare,
  );

  print(profileStore.ownedClinic.clinicName.toString());
  notifyListeners();
}




void addServe(ServingInHealthcare serveModel){
  serves.add(serveModel);
  notifyListeners();
}

void updateTask(ServingInHealthcare serveModel,int index){
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
    verificationResponseModel = value;
    notifyListeners();
  });
}

Future<void> resendCode(String number) async{
  await SignUpRepository.resendVerificationCode(number).then((value) {
    messageResponseResendCode = value;
    notifyListeners();
  });
}

///
Future<void> addProfileStore() async{
  await SignUpRepository.addProfileStore(profileStore).then((value) {
    statusResponseProfile = value;
    notifyListeners();
  });
}

Future<void> uploadPicture({String collection,File file}) async{
  await SignUpRepository.uploadPicture(collection,file).then((value) {
    tokenPicture = value;
    notifyListeners();
  });
}


}