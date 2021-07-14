class AppointmentsModel {
  int status;
  String message;
  Response response;
  Meta errors;

  AppointmentsModel({this.status, this.message, this.response, this.errors});

  AppointmentsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    response = json['response'] != null
        ? new Response.fromJson(json['response'])
        : null;
    errors = json['errors'] != null ? new Meta.fromJson(json['errors']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.response != null) {
      data['response'] = this.response.toJson();
    }
    if (this.errors != null) {
      data['errors'] = this.errors.toJson();
    }
    return data;
  }
}

class Response {
  List<AppointmentsData> data;
  Meta meta;

  Response({this.data, this.meta});

  Response.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<AppointmentsData>();
      json['data'].forEach((v) {
        data.add(new AppointmentsData.fromJson(v));
      });
    }
    meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    if (this.meta != null) {
      data['meta'] = this.meta.toJson();
    }
    return data;
  }
}

class AppointmentsData {
  String day;
  List<Appointments> appointments;

  AppointmentsData({this.day, this.appointments});

  AppointmentsData.fromJson(Map<String, dynamic> json) {
    day = json['day'];
    if (json['appointments'] != null) {
      appointments = new List<Appointments>();
      json['appointments'].forEach((v) {
        appointments.add(new Appointments.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['day'] = this.day;
    if (this.appointments != null) {
      data['appointments'] = this.appointments.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Appointments {
  int id;
  String day;
  String from;
  String to;
  int timeSlot;
  int branchId;

  Appointments(
      {this.id, this.day, this.from, this.to, this.timeSlot, this.branchId});

  Appointments.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    day = json['day'];
    from = json['from'];
    to = json['to'];
    timeSlot = json['time_slot'];
    branchId = json['branch_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['day'] = this.day;
    data['from'] = this.from;
    data['to'] = this.to;
    data['time_slot'] = this.timeSlot;
    data['branch_id'] = this.branchId;
    return data;
  }
}

class Meta {
  Meta();

  Meta.fromJson(Map<String, dynamic> json) {}

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    return data;
  }
}
