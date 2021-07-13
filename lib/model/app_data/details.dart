class Cities {
  int id;
  String name;
  List<Areas> areas;

  Cities({this.id, this.name, this.areas});

  Cities.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    if (json['areas'] != null) {
      areas = new List<Areas>();
      json['areas'].forEach((v) { areas.add(new Areas.fromJson(v)); });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    if (this.areas != null) {
      data['areas'] = this.areas.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Areas {
  int id;
  String name;

  Areas({this.id, this.name});

  Areas.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

class Specialities {
  int id;
  String name;
  List<MainModel> subspecialities;

  Specialities({this.id, this.name, this.subspecialities});

  Specialities.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    if (json['subspecialities'] != null) {
      subspecialities = new List<MainModel>();
      json['subspecialities'].forEach((v) { subspecialities.add(new MainModel.fromJson(v)); });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    if (this.subspecialities != null) {
      data['subspecialities'] = this.subspecialities.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MainModel {
  int id;
  String name;


  MainModel({this.id, this.name,});

  MainModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;

    return data;
  }
}



