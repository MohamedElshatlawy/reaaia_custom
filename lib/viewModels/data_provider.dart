import 'package:flutter/foundation.dart';
import 'package:reaaia/model/data/data/data_model.dart';
import 'package:reaaia/repository/data_repo.dart';

class DataProvider extends ChangeNotifier {

  AppDataModel appDataModel;

  Future<void> getAppData() async {
    await DataRepository.getAppData().then((value) {
      appDataModel = value;
      notifyListeners();
    });
  }




}