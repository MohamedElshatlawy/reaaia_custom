import 'package:reaaia/data/dataApi/data_api_model.dart';
import 'package:reaaia/data/dataApi/response_data_api.dart';
import 'package:reaaia/network/networkCallback/NetworkCallback.dart';
import 'package:reaaia/utils/Enums.dart';

class DataRepository{
  static Future<AppDataModel> getAppData() async {

    final response = await NetworkCall.makeCall(
      endPoint: "api/app-data",
      method: HttpMethod.GET,
    );
    print("my Response: ${response.toString()}");
    return AppDataModel.fromJson(response);
  }

}