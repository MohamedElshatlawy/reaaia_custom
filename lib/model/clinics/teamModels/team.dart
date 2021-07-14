class TeamModel {
  int status;
  String message;
  Response response;
  Meta errors;

  TeamModel({this.status, this.message, this.response, this.errors});

  TeamModel.fromJson(Map<String, dynamic> json) {
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
  List<TeamDataModel> data;
  Meta meta;

  Response({this.data, this.meta});

  Response.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<TeamDataModel>();
      json['data'].forEach((v) { data.add(new TeamDataModel.fromJson(v)); });
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

class TeamDataModel {
  int id;
  String name;
  String mobileNumber;
  List<JobNature> jobNature;
  List<Branches> branches;

  TeamDataModel({this.id, this.name, this.mobileNumber, this.jobNature, this.branches});

  TeamDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    mobileNumber = json['mobile_number'];
    if (json['job_nature'] != null) {
      jobNature = new List<JobNature>();
      json['job_nature'].forEach((v) { jobNature.add(new JobNature.fromJson(v)); });
    }
    if (json['branches'] != null) {
      branches = new List<Branches>();
      json['branches'].forEach((v) { branches.add(new Branches.fromJson(v)); });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['mobile_number'] = this.mobileNumber;
    if (this.jobNature != null) {
      data['job_nature'] = this.jobNature.map((v) => v.toJson()).toList();
    }
    if (this.branches != null) {
      data['branches'] = this.branches.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class JobNature {
  String jobNature;
  String jobNatureName;

  JobNature({this.jobNature, this.jobNatureName});

  JobNature.fromJson(Map<String, dynamic> json) {
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

class Branches {
  int id;
  String area;
  String city;
  String latitude;
  String longitude;
  String detailedAddress;
  bool status;

  Branches({this.id, this.area, this.city, this.latitude, this.longitude, this.detailedAddress, this.status});

  Branches.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    area = json['area'];
    city = json['city'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    detailedAddress = json['detailed_address'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['area'] = this.area;
    data['city'] = this.city;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['detailed_address'] = this.detailedAddress;
    data['status'] = this.status;
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