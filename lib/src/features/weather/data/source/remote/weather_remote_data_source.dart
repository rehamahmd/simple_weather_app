import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_starter_kit/app/imports.dart';

import '../../../../../common/data/network/network_helper.dart';
import '../../../../../common/data/network/endpoints.dart';

@injectable
class WeatherRemoteDataSource {
  final NetworkHelper _networkHelper;
  WeatherRemoteDataSource(this._networkHelper);

  Future<NetworkResponse> getCityWeather(int cityId) async {
    final Response response = await _networkHelper.get(
      Endpoints.weather,
      queryParameters: cityQueryParameters(cityId),
    );

    return NetworkResponse(
      isSucceeded: response.statusCode == 200 && response.data['cod'] == "200",
      data: response.data['list'],
    );
  }

  Map<String, dynamic> cityQueryParameters(int city) {
    final apiKey = dotenv.env['API_KEY'];
    if (apiKey == null || apiKey.isEmpty) {
      throw const OperationException("Check Env Api Key");
    }
    return {
      "id": city,
      "appid": apiKey,
      "units": "metric",
    };
  }
}
