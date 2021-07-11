class Errors {
  List<String> input;

  Errors({this.input});

  Errors.fromJson(Map<String, dynamic> json) {
    input = json['input'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['input'] = this.input;
    return data;
  }
}