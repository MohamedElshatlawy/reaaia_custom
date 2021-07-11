class ResponseData {
  Data data;
  Map<String,dynamic> meta;

  ResponseData({this.data, this.meta});

  ResponseData.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    //meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    // if (this.meta != null) {
    //   data['meta'] = this.meta.toJson();
    // }
    return data;
  }
}


class Data {
  String tokenType;
  int expiresIn;
  String accessToken;
  String refreshToken;

  Data({this.tokenType, this.expiresIn, this.accessToken, this.refreshToken});

  Data.fromJson(Map<String, dynamic> json) {
    tokenType = json['token_type'];
    expiresIn = json['expires_in'];
    accessToken = json['access_token'];
    refreshToken = json['refresh_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token_type'] = this.tokenType;
    data['expires_in'] = this.expiresIn;
    data['access_token'] = this.accessToken;
    data['refresh_token'] = this.refreshToken;
    return data;
  }
}

// class Response {
//   String tokenType;
//   int expiresIn;
//   String accessToken;
//   String refreshToken;
//
//   Response({this.tokenType, this.expiresIn, this.accessToken, this.refreshToken});
//
//   Response.fromJson(Map<String, dynamic> json) {
//     tokenType = json['token_type'];
//     expiresIn = json['expires_in'];
//     accessToken = json['access_token'];
//     refreshToken = json['refresh_token'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['token_type'] = this.tokenType;
//     data['expires_in'] = this.expiresIn;
//     data['access_token'] = this.accessToken;
//     data['refresh_token'] = this.refreshToken;
//     return data;
//   }
// }