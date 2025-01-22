import 'package:flutter_starter_kit/app/imports.dart';

import '../../domain/entities/weather_entity.dart';
import '../../domain/i_repositories/i_weather_repository.dart';
import '../source/local/weather_local_data_source.dart';
import '../source/remote/weather_remote_data_source.dart';

@Singleton(as: IWeatherRepository)
class WeatherRepository implements IWeatherRepository {
  final WeatherRemoteDataSource _weatherRemoteDataSource;
  final WeatherLocalDataSource _weatherLocalDataSource;
  WeatherRepository(this._weatherRemoteDataSource, this._weatherLocalDataSource);
  String? _day; // cache it on memory not on local storage.

  @override
  Future<Either<AppError, List<WeatherEntity>>> getCityWeatherByDay(int cityId, String? day) async {
    try {
      if (_day == day) return Right(_getCachedWeatherEntity());

      final apiResponse = await _weatherRemoteDataSource.getCityWeather(cityId);
      final weatherData = _convertWeatherListForDay(apiResponse.data, day);
      if (weatherData.isEmpty) return Left(OperationError("Empty No Data"));

      _setCachedWeatherEntity(weatherData);
      _day = day;

      return Right(weatherData);
    } on UnAuthorizeException {
      return const Left(UnAuthorizedError());
    } on ConnectivityException catch (error) {
      Logger.error("message", error);
      return const Left(NetworkError());
    } catch (error, stackTrace) {
      Logger.trace("Error in getCityWeatherByDay $day ", error, stackTrace);
      return const Left(OperationError());
    }
  }

  // as we need to save only selected day so i dont need all the data
  List<WeatherEntity> _convertWeatherListForDay(List<dynamic> weatherList, String? day) {
    return weatherList
        .where((e) => DateTimeUtils.parseDate(e['dt_txt']).day.toString() == day)
        .map((e) => WeatherEntity.fromJson(e))
        .toList();
  }

  void _setCachedWeatherEntity(List<WeatherEntity> data) {
    final List<String> weatherDataString = data.map((e) => e.toJsonString()).toList();
    _weatherLocalDataSource.setCachedWeatherEntity(weatherDataString);
  }

  List<WeatherEntity> _getCachedWeatherEntity() {
    final weatherDataString = _weatherLocalDataSource.getCachedWeatherEntity();
    return weatherDataString.map((String e) => WeatherEntity.fromString(e)).toList();
  }
}
