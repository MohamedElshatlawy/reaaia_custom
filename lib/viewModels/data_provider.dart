import 'package:flutter/foundation.dart';
import 'package:reaaia/data/dataApi/data_api_model.dart';
import 'package:reaaia/repos/data_repo.dart';

class DataProvider extends ChangeNotifier {

  AppDataModel appDataModel;

  Future<void> getAppData() async {
    await DataRepository.getAppData().then((value) {
      appDataModel = value;
      notifyListeners();
    });
  }




}