// class ClinicsBranchModel {
//   int status;
//   String message;
//   Response response;
//   Meta errors;

//   ClinicsBranchModel({this.status, this.message, this.response, this.errors});

//   ClinicsBranchModel.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     message = json['message'];
//     response = json['response'] != null ? new Response.fromJson(json['response']) : null;
//     errors = json['errors'] != null ? new Meta.fromJson(json['errors']) : null;
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['status'] = this.status;
//     data['message'] = this.message;
//     if (this.response != null) {
//       data['response'] = this.response.toJson();
//     }
//     if (this.errors != null) {
//       data['errors'] = this.errors.toJson();
//     }
//     return data;
//   }
// }

// class Response {
//   List<BranchData> data;
//   Meta meta;

//   Response({this.data, this.meta});

//   Response.fromJson(Map<String, dynamic> json) {
//     if (json['data'] != null) {
//       data = new List<BranchData>();
//       json['data'].forEach((v) { data.add(new BranchData.fromJson(v)); });
//     }
//     meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.data != null) {
//       data['data'] = this.data.map((v) => v.toJson()).toList();
//     }
//     if (this.meta != null) {
//       data['meta'] = this.meta.toJson();
//     }
//     return data;
//   }
// }

// class BranchData {
//   int id;
//   String area;
//   String city;
//   String latitude;
//   String longitude;
//   String detailedAddress;
//   bool status;

//   BranchData({this.id, this.area, this.city, this.latitude, this.longitude, this.detailedAddress, this.status});

//   BranchData.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     area = json['area'];
//     city = json['city'];
//     latitude = json['latitude'];
//     longitude = json['longitude'];
//     detailedAddress = json['detailed_address'];
//     status = json['status'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['area'] = this.area;
//     data['city'] = this.city;
//     data['latitude'] = this.latitude;
//     data['longitude'] = this.longitude;
//     data['detailed_address'] = this.detailedAddress;
//     data['status'] = this.status;
//     return data;
//   }
// }

// class Meta {


//   Meta();

// Meta.fromJson(Map<String, dynamic> json) {
// }

// Map<String, dynamic> toJson() {
//   final Map<String, dynamic> data = new Map<String, dynamic>();
//   return data;
// }
// }