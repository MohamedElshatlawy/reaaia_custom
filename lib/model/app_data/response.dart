import 'package:reaaia/model/app_data/details.dart';

class Data {
  List<Cities> cities;
  List<MainModel> scientificDegrees;
  List<MainModel> languages;
  List<MainModel> languageLevels;
  List<Specialities> specialities;
  List<MainModel> insurancePlans;

  Data(
      {this.cities,
      this.scientificDegrees,
      this.languages,
      this.languageLevels,
      this.specialities,
      this.insurancePlans});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['cities'] != null) {
      cities = new List<Cities>();
      json['cities'].forEach((v) {
        cities.add(new Cities.fromJson(v));
      });
    }
    if (json['scientific_degrees'] != null) {
      scientificDegrees = new List<MainModel>();
      json['scientific_degrees'].forEach((v) {
        scientificDegrees.add(new MainModel.fromJson(v));
      });
    }
    if (json['languages'] != null) {
      languages = new List<MainModel>();
      json['languages'].forEach((v) {
        languages.add(new MainModel.fromJson(v));
      });
    }
    if (json['language_levels'] != null) {
      languageLevels = new List<MainModel>();
      json['language_levels'].forEach((v) {
        languageLevels.add(new MainModel.fromJson(v));
      });
    }
    if (json['specialities'] != null) {
      specialities = new List<Specialities>();
      json['specialities'].forEach((v) {
        specialities.add(new Specialities.fromJson(v));
      });
    }
    if (json['insurance_plans'] != null) {
      insurancePlans = new List<MainModel>();
      json['insurance_plans'].forEach((v) {
        insurancePlans.add(new MainModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.cities != null) {
      data['cities'] = this.cities.map((v) => v.toJson()).toList();
    }
    if (this.scientificDegrees != null) {
      data['scientific_degrees'] =
          this.scientificDegrees.map((v) => v.toJson()).toList();
    }
    if (this.languages != null) {
      data['languages'] = this.languages.map((v) => v.toJson()).toList();
    }
    if (this.languageLevels != null) {
      data['language_levels'] =
          this.languageLevels.map((v) => v.toJson()).toList();
    }
    if (this.specialities != null) {
      data['specialities'] = this.specialities.map((v) => v.toJson()).toList();
    }
    if (this.insurancePlans != null) {
      data['insurance_plans'] =
          this.insurancePlans.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
