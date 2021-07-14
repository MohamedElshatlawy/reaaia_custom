
import 'package:reaaia/model/app_data/response_data.dart';


class AppDataModel {
  int status;
  String message;
  ResponseDataApi response;
  //Meta errors;

  AppDataModel({this.status, this.message, this.response,});

  AppDataModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    response = json['response'] != null ? new ResponseDataApi.fromJson(json['response']) : null;
    //errors = json['errors'] != null ? new Meta.fromJson(json['errors']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.response != null) {
      data['response'] = this.response.toJson();
    }
    // if (this.errors != null) {
    //   data['errors'] = this.errors.toJson();
    // }
    return data;
  }
}