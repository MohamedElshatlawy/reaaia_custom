class ServingInHealthcare {
  String hospitalName;
  String hospitalStartedFrom;
  String hospitalJobTitle;
  String hospitalPhoneNumber;

  ServingInHealthcare(
      {this.hospitalName,
        this.hospitalStartedFrom,
        this.hospitalJobTitle,
        this.hospitalPhoneNumber});

  ServingInHealthcare.fromJson(Map<String, dynamic> json) {
    hospitalName = json['hospital_name'];
    hospitalStartedFrom = json['hospital_started_from'];
    hospitalJobTitle = json['hospital_job_title'];
    hospitalPhoneNumber = json['hospital_phone_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['hospital_name'] = this.hospitalName;
    data['hospital_started_from'] = this.hospitalStartedFrom;
    data['hospital_job_title'] = this.hospitalJobTitle;
    data['hospital_phone_number'] = this.hospitalPhoneNumber;
    return data;
  }
}