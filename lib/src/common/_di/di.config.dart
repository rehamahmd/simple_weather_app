// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../features/weather/application/services/weather_service.dart'
    as _i998;
import '../../features/weather/data/repositories/weather_repository.dart'
    as _i368;
import '../../features/weather/data/source/local/weather_local_data_source.dart'
    as _i1029;
import '../../features/weather/data/source/remote/weather_remote_data_source.dart'
    as _i440;
import '../../features/weather/domain/i_repositories/i_weather_repository.dart'
    as _i276;
import '../data/network/network_helper.dart' as _i538;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.factory<_i1029.WeatherLocalDataSource>(
        () => _i1029.WeatherLocalDataSource());
    gh.factory<_i538.NetworkHelper>(() => _i538.NetworkHelper());
    gh.factory<_i440.WeatherRemoteDataSource>(
        () => _i440.WeatherRemoteDataSource(gh<_i538.NetworkHelper>()));
    gh.singleton<_i276.IWeatherRepository>(() => _i368.WeatherRepository(
          gh<_i440.WeatherRemoteDataSource>(),
          gh<_i1029.WeatherLocalDataSource>(),
        ));
    gh.factory<_i998.WeatherService>(
        () => _i998.WeatherService(gh<_i276.IWeatherRepository>()));
    return this;
  }
}
