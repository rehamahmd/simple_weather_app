import 'package:flutter_starter_kit/app/imports.dart';

import '../../domain/entities/weather_entity.dart';
import '../../domain/i_repositories/i_weather_repository.dart';

@injectable
class WeatherService {
  final IWeatherRepository _weatherRepository;
  WeatherService(this._weatherRepository);

  Future<Either<AppError, List<WeatherEntity>>> getCityWeatherByDay(int cityId, String? day) async {
    final dayWeatherList = await _weatherRepository.getCityWeatherByDay(cityId, day);
    Logger.debug(dayWeatherList);
    return dayWeatherList;
  }
}
