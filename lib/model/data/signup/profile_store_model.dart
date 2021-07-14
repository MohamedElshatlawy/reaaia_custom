
import 'package:reaaia/model/data/signup/address_model.dart';
import 'package:reaaia/model/data/signup/awards_model.dart';
import 'package:reaaia/model/data/signup/certifications_model.dart';
import 'package:reaaia/model/data/signup/languages_model.dart';
import 'package:reaaia/model/data/signup/owned_clinic_model.dart';
import 'package:reaaia/model/data/signup/serving_health_care_model.dart';

class ProfileStore {
  List<String> avatarImage;
  int doctorUserId;
  String name;
  String email;
  String password;
  String passwordConfirmation;
  String nationalId;
  String gender;
  String dateOfBirth;
  Address address;
  int scientificDegree;
  int specialityId;
  List<int> existingSubspecialities;
  List<String> newSubspecialities;
  List<String> practiceLicenceImage;
  String university;
  List<Languages> languages;
  List<Certifications> certifications;
  List<Awards> awards;
  List<ServingInHealthcare> servingInHealthcare;
  OwnedClinic ownedClinic;

  ProfileStore(
      {this.avatarImage,
        this.doctorUserId,
        this.name,
        this.email,
        this.password,
        this.passwordConfirmation,
        this.nationalId,
        this.gender,
        this.dateOfBirth,
        this.address,
        this.scientificDegree,
        this.specialityId,
        this.existingSubspecialities,
        this.newSubspecialities,
        this.practiceLicenceImage,
        this.university,
        this.languages,
        this.certifications,
        this.awards,
        this.servingInHealthcare,
        this.ownedClinic});

  ProfileStore.fromJson(Map<String, dynamic> json) {
    avatarImage = json['avatar_image'];
    doctorUserId = json['doctor_user_id'];
    name = json['name'];
    email = json['email'];
    password = json['password'];
    passwordConfirmation = json['password_confirmation'];
    nationalId = json['national_id'];
    gender = json['gender'];
    dateOfBirth = json['date_of_birth'];
    address =
    json['address'] != null ? new Address.fromJson(json['address']) : null;
    scientificDegree = json['scientific_degree_id'];
    specialityId = json['speciality_id'];
    existingSubspecialities = json['existing_subspecialities'].cast<int>();
    newSubspecialities = json['new_subspecialities'].cast<String>();
    practiceLicenceImage = json['practice_licence_image'];
    university = json['university'];
    if (json['languages'] != null) {
      languages = new List<Languages>();
      json['languages'].forEach((v) {
        languages.add(new Languages.fromJson(v));
      });
    }
    if (json['certifications'] != null) {
      certifications = new List<Certifications>();
      json['certifications'].forEach((v) {
        certifications.add(new Certifications.fromJson(v));
      });
    }
    if (json['awards'] != null) {
      awards = new List<Awards>();
      json['awards'].forEach((v) {
        awards.add(new Awards.fromJson(v));
      });
    }
    if (json['serving_in_healthcare'] != null) {
      servingInHealthcare = new List<ServingInHealthcare>();
      json['serving_in_healthcare'].forEach((v) {
        servingInHealthcare.add(new ServingInHealthcare.fromJson(v));
      });
    }
    ownedClinic = json['owned_clinic'] != null
        ? new OwnedClinic.fromJson(json['owned_clinic'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['avatar_image'] = this.avatarImage;
    data['doctor_user_id'] = this.doctorUserId;
    data['name'] = this.name;
    data['email'] = this.email;
    data['password'] = this.password;
    data['password_confirmation'] = this.passwordConfirmation;
    data['national_id'] = this.nationalId;
    data['gender'] = this.gender;
    data['date_of_birth'] = this.dateOfBirth;
    if (this.address != null) {
      data['address'] = this.address.toJson();
    }
    data['scientific_degree_id'] = this.scientificDegree;
    data['speciality_id'] = this.specialityId;
    data['existing_subspecialities'] = this.existingSubspecialities;
    data['new_subspecialities'] = this.newSubspecialities;
    data['practice_licence_image'] = this.practiceLicenceImage;
    data['university'] = this.university;
    if (this.languages != null) {
      data['languages'] = this.languages.map((v) => v.toJson()).toList();
    }
    if (this.certifications != null) {
      data['certifications'] =
          this.certifications.map((v) => v.toJson()).toList();
    }
    if (this.awards != null) {
      data['awards'] = this.awards.map((v) => v.toJson()).toList();
    }
    if (this.servingInHealthcare != null) {
      data['serving_in_healthcare'] =
          this.servingInHealthcare.map((v) => v.toJson()).toList();
    }
    if (this.ownedClinic != null) {
      data['owned_clinic'] = this.ownedClinic.toJson();
    }
    return data;
  }
}