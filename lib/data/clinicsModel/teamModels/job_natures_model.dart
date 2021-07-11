class JobNaturesModel {
  int status;
  String message;
  Response response;
  Meta errors;

  JobNaturesModel({this.status, this.message, this.response, this.errors});

  JobNaturesModel.fromJson(Map<String, dynamic> json) {
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
  List<JobNaturesData> data;
  Meta meta;

  Response({this.data, this.meta});

  Response.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<JobNaturesData>();
      json['data'].forEach((v) { data.add(new JobNaturesData.fromJson(v)); });
    }
    meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    if (this.meta != null) {
      data['meta'] = this.meta.toJson();
    }
    return data;
  }
}

class JobNaturesData {
  String jobNature;
  String jobNatureName;

  JobNaturesData({this.jobNature, this.jobNatureName});

  JobNaturesData.fromJson(Map<String, dynamic> json) {
    jobNature = json['job_nature'];
    jobNatureName = json['job_nature_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['job_nature'] = this.jobNature;
    data['job_nature_name'] = this.jobNatureName;
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