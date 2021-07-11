class ClinicsModel {
  int status;
  String message;
  Response response;
  Meta errors;

  ClinicsModel({this.status, this.message, this.response, this.errors});

  ClinicsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    response = json['response'] != null
        ? new Response.fromJson(json['response'])
        : null;
    errors = json['errors'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.response != null) {
      data['response'] = this.response.toJson();
    }
    data['errors'] = this.errors;
    return data;
  }
}

  class Response {
  List<ClinicData> data;
  Meta meta;

  Response({this.data, this.meta});

  Response.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<ClinicData>();
      json['data'].forEach((v) {
        data.add(new ClinicData.fromJson(v));
      });
    }
    meta = json['meta'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    data['meta'] = this.meta;
    return data;
  }
}

class ClinicData {
  int id;
  String name;

  ClinicData({this.id, this.name});

  ClinicData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

class Meta {


  Meta();

  Meta.fromJson(Map<String, dynamic> json) {}

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    return data;
  }
}