
import 'package:reaaia/model/data/loginResponse/errors_model.dart';
import 'package:reaaia/model/data/loginResponse/response_model.dart';

class LoginResponse {
  int status;
  String message;
  ResponseData response;
  Errors errors;

  LoginResponse({this.status, this.message, this.response, this.errors});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    response = json['response'] != null ? new ResponseData.fromJson(json['response']) : null;
    errors = json['errors'] != null ? new Errors.fromJson(json['errors']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.response != null) {
      data['response'] = this.response.toJson();
    }
    if (this.errors != null) {
      data['errors'] = this.errors.toJson();
    }
    return data;
  }
}