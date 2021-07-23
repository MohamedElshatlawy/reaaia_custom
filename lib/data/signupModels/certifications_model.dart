class Certifications {
  String name;
  String year;
  List<String>  image;

  Certifications({this.name, this.year, this.image});

  Certifications.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    year = json['year'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['year'] = this.year;
    data['image'] = this.image;
    return data;
  }
}