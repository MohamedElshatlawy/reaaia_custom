import 'package:reaaia/model/clinics/teamModels/team.dart';

class SortBranchModel {
  int status;
  String message;
  Response response;
  Meta errors;

  SortBranchModel({this.status, this.message, this.response, this.errors});

  SortBranchModel.fromJson(Map<String, dynamic> json) {
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
  List<SortBranchData> data;
  Meta meta;

  Response({this.data, this.meta});

  Response.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<SortBranchData>();
      json['data'].forEach((v) { data.add(new SortBranchData.fromJson(v)); });
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

class SortBranchData {
  String branch;
  List<TeamDataModel> team;

  SortBranchData({this.branch, this.team});

  SortBranchData.fromJson(Map<String, dynamic> json) {
    branch = json['branch'];
    if (json['team'] != null) {
      team = new List<TeamDataModel>();
      json['team'].forEach((v) { team.add(new TeamDataModel.fromJson(v)); });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['branch'] = this.branch;
    if (this.team != null) {
      data['team'] = this.team.map((v) => v.toJson()).toList();
    }
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