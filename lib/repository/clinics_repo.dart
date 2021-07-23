import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:reaaia/model/clinics/add_service.dart';
import 'package:reaaia/model/clinics/branchModels/appointments_model.dart';
import 'package:reaaia/model/clinics/branchModels/branch_model.dart';
import 'package:reaaia/model/clinics/clinics_model.dart';
import 'package:reaaia/model/clinics/service_model.dart';
import 'package:reaaia/model/clinics/teamModels/job_natures.dart';
import 'package:reaaia/model/clinics/teamModels/sort_branch_model.dart';
import 'package:reaaia/model/clinics/teamModels/sort_job_nature_model.dart';
import 'package:reaaia/model/clinics/teamModels/team.dart';

import 'package:reaaia/network/ServicesURLs.dart';
import 'package:reaaia/network/networkCallback/NetworkCallback.dart';
import 'package:reaaia/utils/Enums.dart';

class ClinicsRepository {
  static Future<ClinicsModel> getClinicsData() async {
    final response = await NetworkCall.makeCall(
      endPoint: ServicesURLs.clinics_url,
      method: HttpMethod.GET,
    );
    return ClinicsModel.fromJson(response);
  }

  /// branches

  static Future<BranchModel> getBranchesData(int clinicId) async {
    final response = await NetworkCall.makeCall(
      endPoint: ServicesURLs.clinics_url + "$clinicId/branches",
      method: HttpMethod.GET,
    );
    return BranchModel.fromJson(response);
  }

  static Future<int> addBranch(int clinicId, Map<String, dynamic> body) async {
    final response = await NetworkCall.makeCall(
      endPoint: ServicesURLs.clinics_url + "$clinicId/branches",
      method: HttpMethod.POST,
      requestBody: jsonEncode(body),
    );
    return response['error']['code'];
  }

  static Future<void> getBranchDetail(int branchId) async {
    final response = await NetworkCall.makeCall(
      endPoint: "${ServicesURLs.branches_url}$branchId",
      method: HttpMethod.GET,
    );
  }

  static Future<int> editBranch(int branchId, Map<String, dynamic> body) async {
    final response = await NetworkCall.makeCall(
      endPoint: "${ServicesURLs.branches_url}$branchId",
      method: HttpMethod.PUT,
      requestBody: jsonEncode(body),
    );
    return response['status'];
  }

  static Future<int> deleteBranch(int branchId) async {
    final response = await NetworkCall.makeCall(
      endPoint: "${ServicesURLs.branches_url}$branchId",
      method: HttpMethod.DELETE,
    );

    return response['error']['code'];
  }

  static Future<int> toggleStatusBranch(int branchId) async {
    final response = await NetworkCall.makeCall(
      endPoint: ServicesURLs.branches_url + "$branchId/toggle-status",
      method: HttpMethod.POST,
    );
    return response['status'];
  }

  /// appointments repo

  static Future<AppointmentsModel> getAppointmentsData(int branchId) async {
    final response = await NetworkCall.makeCall(
      endPoint: ServicesURLs.branches_url + "$branchId/appointments",
      method: HttpMethod.GET,
    );
    return AppointmentsModel.fromJson(response);
  }

  static Future<int> addAppointment(
      int branchId, Map<String, dynamic> body) async {
    final response = await NetworkCall.makeCall(
      endPoint: ServicesURLs.branches_url + "$branchId/appointments",
      method: HttpMethod.POST,
      requestBody: json.encode(body),
    );
    return response['error']['code'];
  }

  static Future<int> editAppointment(
      int branchId, Map<String, dynamic> body) async {
    final response = await NetworkCall.makeCall(
      endPoint: ServicesURLs.branches_url + "$branchId/appointments",
      method: HttpMethod.PUT,
      requestBody: json.encode(body),
    );
    return response['status'];
  }

  /// service repo

  static Future<String> uploadServiceImage(
      String collection, List<File> files) async {
    final response = await NetworkCall.makeCall(
      endPoint: ServicesURLs.UPLOAD_MEDIA_URL,
      method: HttpMethod.POST,
      requestBody: jsonEncode({"collection": collection}),
      isMultipart: true,
      multiPartValues: await Future.wait<MultipartFile>(files
          .map((e) async => await MultipartFile.fromPath('files[]', e.path))
          .toList()),
      // multiPartValues: files.map((e) => MultipartFile.fromBytes("files[]", e.readAsBytesSync())).toList(),
    );
    print("my Response: ${response.toString()}");
    return response['token'];
  }

  static Future<ServiceModel> getServicesData(int clinicId) async {
    final response = await NetworkCall.makeCall(
      endPoint: ServicesURLs.clinics_url + "$clinicId/clinic-services",
      method: HttpMethod.GET,
    );
    return ServiceModel.fromJson(response);
  }

  static Future<int> addService(
      AddServiceModel body, List<MultipartFile> files) async {
    final response = await NetworkCall.makeCall(
      endPoint: ServicesURLs.services_url,
      method: HttpMethod.POST,
      requestBody: json.encode(body),
      // isMultipart: true,
      // multiPartValues: files,
    );
    return response['error']['code'];
  }

  static Future<int> editService(
      int clinicServiceId, AddServiceModel body) async {
    final response = await NetworkCall.makeCall(
      endPoint: "${ServicesURLs.services_url}$clinicServiceId",
      method: HttpMethod.POST,
      requestBody: jsonEncode(body),
    );
    return response['status'];
  }

  static Future<int> deleteService(int clinicServiceId) async {
    final response = await NetworkCall.makeCall(
      endPoint: "${ServicesURLs.services_url}$clinicServiceId",
      method: HttpMethod.DELETE,
    );

    return response['status'];
  }

  /// team

  static Future<TeamModel> getTeamData(int clinicId) async {
    final response = await NetworkCall.makeCall(
      endPoint: ServicesURLs.clinics_url + "$clinicId/team",
      method: HttpMethod.GET,
    );
    return TeamModel.fromJson(response);
  }

  static Future<int> addTeamMember(
      int clinicId, Map<String, dynamic> body) async {
    final response = await NetworkCall.makeCall(
      endPoint: ServicesURLs.clinics_url + "$clinicId/team",
      method: HttpMethod.POST,
      requestBody: jsonEncode(body),
    );
    return response['error']['code'];
  }

  static Future<void> getTeamMemberDetail(int assistantUserId) async {
    final response = await NetworkCall.makeCall(
      endPoint: "${ServicesURLs.teams_url}$assistantUserId",
      method: HttpMethod.GET,
    );
  }

  static Future<int> editTeamMember(
      int assistantUserId, Map<String, dynamic> body) async {
    final response = await NetworkCall.makeCall(
      endPoint: "${ServicesURLs.teams_url}$assistantUserId",
      method: HttpMethod.PUT,
      requestBody: jsonEncode(body),
    );
    return response['status'];
  }

  static Future<int> deleteTeamMember(int assistantUserId) async {
    final response = await NetworkCall.makeCall(
      endPoint: "${ServicesURLs.teams_url}$assistantUserId",
      method: HttpMethod.DELETE,
    );

    return response['error']['code'];
  }

  static Future<JobNaturesModel> getJobNaturesData() async {
    final response = await NetworkCall.makeCall(
      endPoint: ServicesURLs.job_nature_url,
      method: HttpMethod.GET,
    );
    return JobNaturesModel.fromJson(response);
  }

  static Future<SortBranchModel> getSortDataByBranch(int clinicId) async {
    final response = await NetworkCall.makeCall(
      endPoint: ServicesURLs.clinics_url + "$clinicId/team-by-branch",
      method: HttpMethod.GET,
    );
    return SortBranchModel.fromJson(response);
  }

  static Future<SortJobNatureModel> getSortDataByJobNature(int clinicId) async {
    final response = await NetworkCall.makeCall(
      endPoint: ServicesURLs.clinics_url + "$clinicId/team-by-job",
      method: HttpMethod.GET,
    );
    return SortJobNatureModel.fromJson(response);
  }
}
