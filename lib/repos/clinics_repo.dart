
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:reaaia/data/clinicsModel/add_service_model.dart';
import 'package:reaaia/data/clinicsModel/branch_model.dart';
import 'package:reaaia/data/clinicsModel/clinics_model.dart';
import 'package:reaaia/data/clinicsModel/service_model.dart';
import 'package:reaaia/data/clinicsModel/teamModels/job_natures_model.dart';
import 'package:reaaia/data/clinicsModel/teamModels/team_model.dart';
import 'package:reaaia/network/networkCallback/NetworkCallback.dart';
import 'package:reaaia/utils/Enums.dart';

class ClinicsRepository{

  static Future<ClinicsModel> getClinicsData() async {

    final response = await NetworkCall.makeCall(
      endPoint: "api/doctor/clinics",
      method: HttpMethod.GET,
    );
  return  ClinicsModel.fromJson(response);
  }

/// branches

  static Future<BranchModel> getBranchesData(int clinicId) async {

    final response = await NetworkCall.makeCall(
      endPoint: "api/doctor/clinics/$clinicId/branches",
      method: HttpMethod.GET,
    );
    return  BranchModel.fromJson(response);
  }

  static Future<int> addBranch(int clinicId,Map<String,dynamic> body) async {

    final response = await NetworkCall.makeCall(
      endPoint: "doctor/clinics/$clinicId/branches",
      method: HttpMethod.POST,
      requestBody: jsonEncode(body),
    );
    return response['error']['code'];
  }

  static Future<void> getBranchDetail(int branchId) async {

    final response = await NetworkCall.makeCall(
      endPoint: "/api/doctor/branches/$branchId",
      method: HttpMethod.GET,
    );



  }

  static Future<int> editBranch(int branchId,Map<String,dynamic> body) async {

    final response = await NetworkCall.makeCall(
      endPoint: "doctor/branches/$branchId",
      method: HttpMethod.PUT,
      requestBody: jsonEncode(body),
    );
    return response['status'];
  }

  static Future<int> deleteBranch(int branchId) async {

    final response = await NetworkCall.makeCall(
      endPoint: "/api/doctor/branches/$branchId",
      method: HttpMethod.DELETE,
    );

    return response['error']['code'];

  }

  static Future<int> toggleStatusBranch(int branchId) async {

    final response = await NetworkCall.makeCall(
      endPoint: "doctor/branches/$branchId/toggle-status",
      method: HttpMethod.POST,
    );
    return response['status'];
  }

  /// service repo

  static Future<String> uploadServiceImage(String collection,List<File> files) async {
    final response = await NetworkCall.makeCall(
      endPoint: "uploader/media/upload",
      method: HttpMethod.POST,
      requestBody: jsonEncode({"collection":collection}),
      isMultipart: true,
      multiPartValues:[
        await MultipartFile.fromPath(
            "files[]", files[0].path),
        await MultipartFile.fromPath(
            "files[]", files[1].path)
      ],

    );
    print("my Response: ${response.toString()}");
    return response['token'];
  }

  static Future<ServiceModel> getServicesData(int clinicId) async {

    final response = await NetworkCall.makeCall(
      endPoint: "api/doctor/clinics/$clinicId/clinic-services",
      method: HttpMethod.GET,
    );
    return  ServiceModel.fromJson(response);
  }

  static Future<int> addService(AddServiceModel body,List<MultipartFile> files) async {
    final response = await NetworkCall.makeCall(
      endPoint: "doctor/clinic-services",
      method: HttpMethod.POST,
      requestBody: json.encode(body),
       // isMultipart: true,
       // multiPartValues: files,
    );
    return response['error']['code'];
  }

  static Future<int> editService(int clinicServiceId,AddServiceModel body) async {

    final response = await NetworkCall.makeCall(
      endPoint: "doctor/clinic-services/$clinicServiceId",
      method: HttpMethod.POST,
      requestBody: jsonEncode(body),
    );
    return response['status'];
  }

  static Future<int> deleteService(int clinicServiceId) async {

    final response = await NetworkCall.makeCall(
      endPoint: "/api/doctor/clinic-services/$clinicServiceId",
      method: HttpMethod.DELETE,
    );

    return response['status'];

  }





  /// team

  static Future<TeamModel> getTeamData(int clinicId) async {

    final response = await NetworkCall.makeCall(
      endPoint: "api/doctor/clinics/$clinicId/team",
      method: HttpMethod.GET,
    );
    return  TeamModel.fromJson(response);
  }

  static Future<int> addTeamMember(int clinicId,Map<String,dynamic> body) async {

    final response = await NetworkCall.makeCall(
      endPoint: "doctor/clinics/$clinicId/team",
      method: HttpMethod.POST,
      requestBody: jsonEncode(body),
    );
    return response['error']['code'];
  }

  static Future<void> getTeamMemberDetail(int assistantUserId) async {

    final response = await NetworkCall.makeCall(
      endPoint: "api/doctor/clinic-teams/$assistantUserId",
      method: HttpMethod.GET,
    );



  }

  static Future<int> editTeamMember(int assistantUserId,Map<String,dynamic> body) async {

    final response = await NetworkCall.makeCall(
      endPoint: "doctor/clinic-teams/$assistantUserId",
      method: HttpMethod.PUT,
      requestBody: jsonEncode(body),
    );
    return response['status'];
  }

  static Future<int> deleteTeamMember(int assistantUserId) async {

    final response = await NetworkCall.makeCall(
      endPoint: "/api/doctor/clinic-teams/$assistantUserId",
      method: HttpMethod.DELETE,
    );

    return response['error']['code'];

  }


  static Future<JobNaturesModel> getJobNaturesData() async {

    final response = await NetworkCall.makeCall(
      endPoint: "api/doctor/job-natures",
      method: HttpMethod.GET,
    );
    return  JobNaturesModel.fromJson(response);
  }

}