
import 'package:reaaia/model/data/signup/awards_model.dart';
import 'package:reaaia/model/data/signup/certifications_model.dart';
import 'package:reaaia/model/data/signup/languages_model.dart';

class CompleteReg2Model{


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