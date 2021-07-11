
import 'package:reaaia/model/data/loginResponse/errors_model.dart';


class ForgetPassResponse {
  int status;
  String message;
  ForgetPassResponseData response;
  Errors errors;

  ForgetPassResponse({this.status, this.message, this.response, this.errors});

  ForgetPassResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    response = json['response'] != null ? new ForgetPassResponseData.fromJson(json['response']) : null;
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



class ForgetPassResponseData {
  Data data;
  Map<String,dynamic> meta;

  ForgetPassResponseData({this.data, this.meta});

  ForgetPassResponseData.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    //meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    // if (this.meta != null) {
    //   data['meta'] = this.meta.toJson();
    // }
    return data;
  }
}


class Data {
  String token;
  int expiryTime;


  Data({this.token, this.expiryTime, });

  Data.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    expiryTime = json['expiry_time'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    data['expiry_time'] = this.expiryTime;
    return data;
  }
}

// class Response {
//   String token;
//   int expiryTime;
//
//
//   Response({this.token, this.expiryTime, });
//
//   Response.fromJson(Map<String, dynamic> json) {
//     token = json['token'];
//     expiryTime = json['expiry_time'];
//
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['token'] = this.token;
//     data['expiry_time'] = this.expiryTime;
//     return data;
//   }
// }