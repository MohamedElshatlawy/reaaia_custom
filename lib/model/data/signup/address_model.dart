class Address {
double latitude;
double longitude;
String detailedAddress;

Address({this.latitude, this.longitude, this.detailedAddress});

Address.fromJson(Map<String, dynamic> json) {
latitude = json['latitude'];
longitude = json['longitude'];
detailedAddress = json['detailed_address'];
}

Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['latitude'] = this.latitude;
  data['longitude'] = this.longitude;
  data['detailed_address'] = this.detailedAddress;
  return data;
}
}