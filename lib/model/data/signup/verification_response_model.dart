class VerificationResponseModel {
  int status;
  String message;
  Response response;
  Meta errors;

  VerificationResponseModel({this.status, this.message, this.response, this.errors});

  VerificationResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    response = json['response'] != null ? new Response.fromJson(json['response']) : null;
    errors = json['errors'] != null ? new Meta.fromJson(json['errors']) : null;
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

class Response {
  Data data;
  Meta meta;

  Response({this.data, this.meta});

  Response.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    if (this.meta != null) {
      data['meta'] = this.meta.toJson();
    }
    return data;
  }
}

class Data {
  int id;
  String mobileNumber;
  bool mobileVerified;

  Data({this.id, this.mobileNumber, this.mobileVerified});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    mobileNumber = json['mobile_number'];
    mobileVerified = json['mobile_verified'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['mobile_number'] = this.mobileNumber;
    data['mobile_verified'] = this.mobileVerified;
    return data;
  }
}

class Meta {


  Meta();

Meta.fromJson(Map<String, dynamic> json) {
}

Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  return data;
}
}