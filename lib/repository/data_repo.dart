

import 'package:reaaia/model/app_data/data.dart';
import 'package:reaaia/network/ServicesURLs.dart';
import 'package:reaaia/network/networkCallback/NetworkCallback.dart';
import 'package:reaaia/utils/Enums.dart';

class DataRepository{
  static Future<AppDataModel> getAppData() async {

    final response = await NetworkCall.makeCall(
      endPoint: ServicesURLs.DATA_URL,
      method: HttpMethod.GET,
    );
    print("my Response: ${response.toString()}");
    return AppDataModel.fromJson(response);
  }

}