import 'package:flutter_starter_kit/app/imports.dart';

@injectable
class WeatherLocalDataSource {
  WeatherLocalDataSource();

  setCachedWeatherEntity(List<String> data) {
    SharedPreferencesStorage.setStringList(StorageKeys.dayWeather, data);
  }

  List<String> getCachedWeatherEntity() {
    final result = SharedPreferencesStorage.getStringList(StorageKeys.dayWeather);
    return result ?? [];
  }
}
