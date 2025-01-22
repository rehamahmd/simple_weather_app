import 'package:flutter_starter_kit/app/imports.dart';

import '../../application/services/weather_service.dart';
import '../../domain/entities/weather_entity.dart';

part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  final WeatherService _weatherService;
  WeatherCubit(this._weatherService) : super(WeatherInitial());

  getCityWeatherByDay(String? day) async {
    int cityId = 292223; // static for now [Dubai]
    emit(WeatherLoading());
    final result = await _weatherService.getCityWeatherByDay(cityId, day);
    result.fold(
      (error) => emit(WeatherError(error)),
      (data) => emit(WeatherLoaded(data.first)),
    );
  }
}
