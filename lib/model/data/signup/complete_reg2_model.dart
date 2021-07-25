import 'package:reaaia/data/signupModels/awards_model.dart';
import 'package:reaaia/data/signupModels/certifications_model.dart';
import 'package:reaaia/data/signupModels/languages_model.dart';

class CompleteReg2Model {
  int scientificDegree;
  int specialityId;
  List<int> existingSubspecialities;
  List<String> newSubspecialities;
  List<String> practiceLicenceImage;
  String university;
  List<Languages> languages;
  List<Certifications> certifications;
  List<Awards> awards;
}
