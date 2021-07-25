import 'dart:io';

class ServiceModel{

  String serviceName;
  String serviceDesc;
  String serviceRequirements;
  String serviceCost;
  String serviceDiscount;
  List<File> images;

  ServiceModel({this.serviceName,this.serviceDesc,this.serviceRequirements,this.serviceCost,this.serviceDiscount,this.images});

}