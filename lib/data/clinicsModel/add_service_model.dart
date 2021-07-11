import 'dart:io';

import 'package:http/http.dart';

class AddServiceModel {
  int clinicId;
  Name name;
  Name description;
  Name requirements;
  int price;
  int discountPercentage;
  List<String> files;

  AddServiceModel(
      {this.clinicId,
        this.name,
        this.description,
        this.requirements,
        this.price,
        this.discountPercentage,
        this.files,
      });

  AddServiceModel.fromJson(Map<String, dynamic> json) {
    clinicId = json['clinic_id'];
    name = json['name'] != null ? new Name.fromJson(json['name']) : null;
    description = json['description'] != null
        ? new Name.fromJson(json['description'])
        : null;
    requirements = json['requirements'] != null
        ? new Name.fromJson(json['requirements'])
        : null;
    price = json['price'];
    discountPercentage = json['discount_percentage'];
    files = json['files'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['clinic_id'] = this.clinicId;
    if (this.name != null) {
      data['name'] = this.name.toJson();
    }
    if (this.description != null) {
      data['description'] = this.description.toJson();
    }
    if (this.requirements != null) {
      data['requirements'] = this.requirements.toJson();
    }
    data['price'] = this.price;
    data['discount_percentage'] = this.discountPercentage;
    data['files'] = this.files;
    return data;
  }
}

class Name {
  String en;
  String ar;

  Name({this.en, this.ar});

  Name.fromJson(Map<String, dynamic> json) {
    en = json['en'];
    ar = json['ar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['en'] = this.en;
    data['ar'] = this.ar;
    return data;
  }
}