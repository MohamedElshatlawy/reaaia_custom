
import 'dart:io';

import 'package:flutter/foundation.dart';
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
import 'package:reaaia/model/data/signup/serving_health_care_model.dart';
import 'package:reaaia/repository/clinics_repo.dart';


class ClinicsProvider extends ChangeNotifier {

  String tokenImages;
  ClinicsModel clinicsModel;
  List<ClinicData> clinics=[];

  BranchModel branchModel;
  List<BranchData> branches = [];
  AppointmentsModel appointmentsModel;
  List<AppointmentsData> appointments=[];
  ServiceModel serviceModel;
  List<ServiceData> serviceClinic = [];

  TeamModel teamModel;
  SortBranchModel sortBranchModel;
  SortJobNatureModel sortJobNatureModel;
  List<TeamDataModel> teams = [];
  bool _isSortedByBranch;

  JobNaturesModel jobNaturesModel;
  List<JobNaturesData> jobNatures=[];

  int addBranchStatus;
  int deleteBranchStatus;


  List<ServingInHealthcare> serves = [];




  bool loadingClinicsData = true;

  bool get isSortedByBranch => _isSortedByBranch;

  set isSortedByBranch(bool isSorted) {
    _isSortedByBranch = isSorted;
    notifyListeners();
  }




  void addServeClinic(ServingInHealthcare serveModel) {
    serves.add(serveModel);
    notifyListeners();
  }

  void updateServeClinic(ServingInHealthcare serveModel, int index) {
    serves.insert(index, serveModel);
    notifyListeners();
  }







  /// get Clinics Data

  Future<void> getClinicsData() async {
    // await ClinicsRepository.getClinicsData().then((value) {
    //   clinicsModel=value;
    //   notifyListeners();
    // });

    try {
      loadingClinicsData = true;
      clinicsModel = await ClinicsRepository.getClinicsData();
      clinics = clinicsModel.response.data;
      notifyListeners();
    } catch (e) {
      loadingClinicsData = false;
      rethrow;
    } finally {
      loadingClinicsData = false;
    }
  }

  /// Branches Data

  Future<void> getBranchesData(int id) async {
    try {
      branchModel = await ClinicsRepository.getBranchesData(id);
      branches = branchModel.response.data;
      notifyListeners();
    } catch (e) {
      //loadingClinicsData = false;
      rethrow;
    } finally {
      //loadingClinicsData = false;
    }
  }

  Future<void> addBranchClinic(int id, Map<String, dynamic> body) async {
    try {
      addBranchStatus = await ClinicsRepository.addBranch(id, body);
      notifyListeners();
    } catch (e) {
      //loadingClinicsData = false;
      rethrow;
    } finally {
      //loadingClinicsData = false;
    }
  }

  Future<void> getBranchesDetail(int id) async {
    try {
      final response = await ClinicsRepository.getBranchDetail(id);
      notifyListeners();
    } catch (e) {
      //loadingClinicsData = false;
      rethrow;
    } finally {
      //loadingClinicsData = false;
    }
  }

  Future<int> editBranchClinic(int id, Map<String, dynamic> body) async {
    try {
      final response = await ClinicsRepository.editBranch(id, body);
      notifyListeners();
      return response;
    } catch (e) {
      return null;
      rethrow;
    } finally {
      //loadingClinicsData = false;
    }
  }

  Future<int> deleteBranches(int id, int index) async {
    try {
      final response = await ClinicsRepository.deleteBranch(id);
      branches.removeAt(index);
      deleteBranchStatus = response;
      notifyListeners();
      return response;
    } catch (e) {
      //loadingClinicsData = false;
      rethrow;
    }
  }


  Future<int> toggleStatusBranchClinic(int id) async {
    try {
      final response = await ClinicsRepository.toggleStatusBranch(id);
      notifyListeners();
      return response;
    } catch (e) {
      return null;
      rethrow;
    }
  }

  /// Appointments

  Future<void> getAppointmentsData(int id) async {
    try {
      appointmentsModel = await ClinicsRepository.getAppointmentsData(id);
      appointments=appointmentsModel.response.data;
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }


  Future<int> addAppointment(int id,Map<String,dynamic> body) async {
    try {
      final response = await ClinicsRepository.addAppointment(id,body);
      notifyListeners();
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<int> editAppointment(int id,Map<String,dynamic> body) async {
    try {
      final response = await ClinicsRepository.editAppointment(id,body);
      notifyListeners();
      return response;
    } catch (e) {
      rethrow;
    }
  }


  /// Services


  Future<void> uploadServiceImages({String collection,List<File> files}) async{
    await ClinicsRepository.uploadServiceImage(collection,files).then((value) {
      tokenImages = value;
      notifyListeners();
    });
  }

  Future<void> getServiceData(int id) async {
    try {
      serviceModel = await ClinicsRepository.getServicesData(id);
      serviceClinic = serviceModel.response.data;
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<int> addService( AddServiceModel body, List<MultipartFile> files) async {
    try {
      final response = await ClinicsRepository.addService( body, files);
      notifyListeners();
      return response;
    } catch (e) {
      print('error $e');
      rethrow;
    }
  }

  Future<int> editService(int id, AddServiceModel body,List<MultipartFile> files) async {
    try {
      final response = await ClinicsRepository.editService(id, body);
      notifyListeners();
      return response;
    } catch (e) {
      return null;
      rethrow;
    }
  }

  Future<int> deleteService(int id, int index) async {
    try {
      final response = await ClinicsRepository.deleteService(id);
      serviceClinic.removeAt(index);
      notifyListeners();
      return response;
    } catch (e) {
      rethrow;
    }
  }


  /// Teams

  Future<void> getTeamData(int id) async {
    try {
      teamModel = await ClinicsRepository.getTeamData(id);
      teams = teamModel.response.data;
      notifyListeners();
    } catch (e) {
      //loadingClinicsData = false;
      rethrow;
    }
  }

  Future<int> addTeamMember(int id, Map<String, dynamic> body) async {
    try {
      final responseStatus = await ClinicsRepository.addTeamMember(id, body);
      notifyListeners();
      return responseStatus;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> getTeamMemberDetail(int id) async {
    try {
      final response = await ClinicsRepository.getTeamMemberDetail(id);
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<int> editTeamMember(int id, Map<String, dynamic> body) async {
    try {
      final response = await ClinicsRepository.editTeamMember(id, body);
      notifyListeners();
      return response;
    } catch (e) {
      return null;
      rethrow;
    }
  }

  Future<int> deleteTeamMember(int id, int index) async {
    try {
      final response = await ClinicsRepository.deleteTeamMember(id);
      teams.removeAt(index);
      notifyListeners();
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> getJobNaturesData() async {
    try {
      jobNaturesModel = await ClinicsRepository.getJobNaturesData();
      jobNatures=jobNaturesModel.response.data;
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }


  Future<void> getTeamDataByBranch(int id) async {
    try {
      sortBranchModel = await ClinicsRepository.getSortDataByBranch(id);
      notifyListeners();
    } catch (e) {

      rethrow;
    }
  }


  Future<void> getTeamDataByJonNature(int id) async {
    try {
      sortJobNatureModel = await ClinicsRepository.getSortDataByJobNature(id);
      notifyListeners();
    } catch (e) {

      rethrow;
    }
  }
}