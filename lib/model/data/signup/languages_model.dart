class Languages {
  int languageId;
  int languageLevelId;

  Languages({this.languageId, this.languageLevelId});

  Languages.fromJson(Map<String, dynamic> json) {
    languageId = json['language_id'];
    languageLevelId = json['language_level_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['language_id'] = this.languageId;
    data['language_level_id'] = this.languageLevelId;
    return data;
  }
}