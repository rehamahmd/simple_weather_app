import 'package:flutter_starter_kit/app/imports.dart';

import '../entities/weather_entity.dart';

abstract class IWeatherRepository {
  Future<Either<AppError, List<WeatherEntity>>> getCityWeatherByDay(int cityId, String? day);
}
