import 'data_response.dart';

class ResponseDataApi {
  Data data;
  List<Map<String,dynamic>> meta;

  ResponseDataApi({this.data, this.meta});

  ResponseDataApi.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    meta = json['meta'] ;
        //!= null ? new Meta.fromJson(json['meta']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
      data['meta'] = this.meta;

    return data;
  }
}
