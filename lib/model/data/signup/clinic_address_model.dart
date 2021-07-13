class ClinicAddress {
  int areaId;
  int cityId;
  double latitude;
  double longitude;
  String detailedAddress;

  ClinicAddress(
      {this.areaId,
        this.cityId,
        this.latitude,
        this.longitude,
        this.detailedAddress});

  ClinicAddress.fromJson(Map<String, dynamic> json) {
    areaId = json['area_id'];
    cityId = json['city_id'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    detailedAddress = json['detailed_address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['area_id'] = this.areaId;
    data['city_id'] = this.cityId;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['detailed_address'] = this.detailedAddress;
    return data;
  }
}