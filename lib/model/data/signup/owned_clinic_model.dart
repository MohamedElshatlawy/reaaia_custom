import 'clinic_address_model.dart';

class OwnedClinic {
  String clinicName;
  int clinicSpeclialityId;
  List<int> existingSubspecialities;
  List<String> newSubspecialities;
  ClinicAddress clinicAddress;
  List<String> clinicPhoneNumbers;
  List<int> existingInsurancePlans;
  List<String> newInsurancePlans;

  OwnedClinic(
      {this.clinicName,
      this.clinicSpeclialityId,
      this.existingSubspecialities,
      this.newSubspecialities,
      this.clinicAddress,
      this.clinicPhoneNumbers,
      this.existingInsurancePlans,
      this.newInsurancePlans});

  OwnedClinic.fromJson(Map<String, dynamic> json) {
    clinicName = json['clinic_name'];
    clinicSpeclialityId = json['clinic_specliality_id'];
    existingSubspecialities = json['existing_subspecialities'].cast<int>();
    newSubspecialities = json['new_subspecialities'].cast<String>();
    clinicAddress = json['clinic_address'] != null
        ? new ClinicAddress.fromJson(json['clinic_address'])
        : null;
    clinicPhoneNumbers = json['clinic_phone_numbers'].cast<String>();
    existingInsurancePlans = json['existing_insurance_plans'].cast<int>();
    newInsurancePlans = json['new_insurance_plans'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['clinic_name'] = this.clinicName;
    data['clinic_speciality_id'] = this.clinicSpeclialityId;
    data['existing_subspecialities'] = this.existingSubspecialities;
    data['new_subspecialities'] = this.newSubspecialities;
    if (this.clinicAddress != null) {
      data['clinic_address'] = this.clinicAddress.toJson();
    }
    data['clinic_phone_numbers'] = this.clinicPhoneNumbers;
    data['existing_insurance_plans'] = this.existingInsurancePlans;
    data['new_insurance_plans'] = this.newInsurancePlans;
    return data;
  }
}
