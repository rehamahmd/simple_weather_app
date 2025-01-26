import 'package:flutter_starter_kit/src/common/common.dart';
import 'package:flutter_starter_kit/src/features/weather/data/repositories/weather_repository.dart';
import 'package:flutter_starter_kit/src/features/weather/data/source/local/weather_local_data_source.dart';
import 'package:flutter_starter_kit/src/features/weather/data/source/remote/weather_remote_data_source.dart';
import 'package:flutter_starter_kit/src/features/weather/domain/entities/weather_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
export 'package:dartz/dartz.dart' hide State;

class MockWeatherRemoteDataSource extends Mock implements WeatherRemoteDataSource {}

class MockWeatherLocalDataSource extends Mock implements WeatherLocalDataSource {}

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  late WeatherRemoteDataSource mockRemoteDataSource;
  late WeatherLocalDataSource mockLocalDataSource;

  late WeatherRepository weatherRepository;

  setUp(() {
    mockRemoteDataSource = MockWeatherRemoteDataSource();
    mockLocalDataSource = MockWeatherLocalDataSource();
    SharedPreferences.setMockInitialValues({});
    weatherRepository = WeatherRepository(mockRemoteDataSource, mockLocalDataSource);
  });

  group('WeatherRepository Tests', () {
    final date = DateTime.now();
    const cityId = 12345;
    final day = date.day.toString();

    final mockApiResponse = [
      {
        "dt": 1672531200,
        "main": {"temp": 25.5, "humidity": 60},
        "weather": [
          {"main": "sunny"}
        ],
        "wind": {"speed": 5.2},
        "dt_txt": date.toString(),
      },
    ];
    final mockWeatherEntity = WeatherEntity(
      dt: 1672531200,
      temp: 25.5,
      humidity: 60,
      weatherType: WeatherTypeEnum.sunny,
      windSpeed: 5.2,
      date: date.toString(),
    );
    final mockWeatherEntityList = [mockWeatherEntity];
    final cachedWeatherData = mockWeatherEntityList.map((e) => e.toJsonString()).toList();

    test('getCityWeatherByDay Successful returns weather', () async {
      when(() => mockRemoteDataSource.getCityWeather(cityId)).thenAnswer((_) async => NetworkResponse(
            isSucceeded: true,
            data: mockApiResponse,
          ));
      when(() => mockLocalDataSource.setCachedWeatherEntity(cachedWeatherData)).thenAnswer((_) async {
        print("Mock setCachedWeatherEntity called");
      });
      final result = await weatherRepository.getCityWeatherByDay(cityId, day);
      expect(result.isRight(), isTrue);

      result.foldRight(
        (right) => expect(right, equals(mockWeatherEntityList)),
        (previousValue, element) => element,
      );
      verify(() => mockLocalDataSource.setCachedWeatherEntity(cachedWeatherData)).called(1);
      verify(() => mockRemoteDataSource.getCityWeather(cityId)).called(1);
    });

    test('getCityWeatherByDay  OperationError if data is Empty', () async {
      when(() => mockRemoteDataSource.getCityWeather(cityId))
          .thenAnswer((_) async => NetworkResponse(isSucceeded: true, data: []));
      final result = await weatherRepository.getCityWeatherByDay(cityId, day);
      expect(result.isLeft(), isTrue);
      expect(result.fold((l) => l, (r) => null), isA<OperationError>());
    });

    test('getCityWeatherByDay UnAuthorizeException', () async {
      when(() => mockRemoteDataSource.getCityWeather(cityId)).thenThrow(UnAuthorizeException());
      final result = await weatherRepository.getCityWeatherByDay(cityId, day);
      expect(result.isLeft(), isTrue);
      expect(result.fold((l) => l, (r) => null), isA<UnAuthorizedError>());
    });

    test('getCityWeatherByDay ConnectivityException ', () async {
      when(() => mockRemoteDataSource.getCityWeather(cityId)).thenThrow(ConnectivityException());
      final result = await weatherRepository.getCityWeatherByDay(cityId, day);
      expect(result.isLeft(), isTrue);
      expect(result.fold((l) => l, (r) => null), isA<NetworkError>());
    });

    test('getCityWeatherByDay handles generic exceptions', () async {
      when(() => mockRemoteDataSource.getCityWeather(cityId)).thenThrow(Exception("General error"));
      final result = await weatherRepository.getCityWeatherByDay(cityId, day);
      expect(result.isLeft(), isTrue);
      expect(result.fold((l) => l, (r) => null), isA<OperationError>());
    });
  });
}
