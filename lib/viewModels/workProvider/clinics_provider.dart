import 'package:flutter/foundation.dart';
import 'package:reaaia/data/clinicsModel/branch_model.dart';
import 'package:reaaia/data/clinicsModel/service_model.dart';
import 'package:reaaia/data/signupModels/serving_health_care_model.dart';

class ClinicsProvider extends ChangeNotifier{

  List<ServingInHealthcare> serves=[];
  List<BranchModel> branches=[];
  List<ServiceModel> services=[];


  void addServeClinic(ServingInHealthcare serveModel){
    serves.add(serveModel);
    notifyListeners();
  }

  void updateServeClinic(ServingInHealthcare serveModel,int index){
    serves.insert(index,serveModel);
    notifyListeners();
  }

  void addBranchClinic(BranchModel branchModel){
    branches.add(branchModel);
    notifyListeners();
  }

  void addServiceClinic(ServiceModel serviceModel){
    services.add(serviceModel);
    notifyListeners();
  }
  void editServiceClinic(int index,ServiceModel serviceModel){
    services[index]=serviceModel;
    notifyListeners();
  }

  void deleteServiceClinic(int index){
    services.removeAt(index);
    notifyListeners();
  }



}