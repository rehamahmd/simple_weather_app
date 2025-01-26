import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_starter_kit/src/common/common.dart';
import 'package:flutter_starter_kit/src/features/weather/presentation/cubit/weather_cubit.dart';
import 'package:flutter_starter_kit/src/features/weather/domain/entities/weather_entity.dart';
import 'package:flutter_starter_kit/src/features/weather/application/services/weather_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';

class MockWeatherService extends Mock implements WeatherService {}

void main() {
  late WeatherService mockWeatherService;
  late WeatherCubit weatherCubit;

  setUp(() {
    mockWeatherService = MockWeatherService();
    weatherCubit = WeatherCubit(mockWeatherService);
  });

  group('WeatherCubit', () {
    const cityId = 292223;
    const day = "28";
    final mockWeatherEntityList = [
      WeatherEntity(
        dt: 1672531200,
        temp: 25.5,
        humidity: 60,
        weatherType: WeatherTypeEnum.rainy,
        windSpeed: 5.2,
        date: "2025-01-28 12:00:00",
      ),
    ];

    blocTest<WeatherCubit, WeatherState>(
      'GetCityWeatherByDay Fail emits WeatherLoading and (OperationError) & Empty Error ',
      build: () {
        when(() => mockWeatherService.getCityWeatherByDay(cityId, day)).thenAnswer(
          (_) async => Left(OperationError()),
        );
        return weatherCubit;
      },
      act: (cubit) => cubit.getCityWeatherByDay(day),
      expect: () => [
        isA<WeatherLoading>(),
        isA<WeatherError>(),
      ],
    );

    blocTest<WeatherCubit, WeatherState>(
      'GetCityWeatherByDay Success emits WeatherLoading and WeatherLoaded',
      build: () {
        when(() => mockWeatherService.getCityWeatherByDay(cityId, day))
            .thenAnswer((_) async => Right(mockWeatherEntityList));
        return weatherCubit;
      },
      act: (cubit) => cubit.getCityWeatherByDay(day),
      expect: () => [
        isA<WeatherLoading>(),
        isA<WeatherLoaded>(),
      ],
    );
  });
}
