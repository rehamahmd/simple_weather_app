import 'dart:convert';

import 'package:flutter_starter_kit/app/imports.dart';

class WeatherEntity {
  final int? dt;
  final double? temp;
  final int? humidity;
  final WeatherTypeEnum weatherType;
  final double? windSpeed;
  final String? date;

  WeatherEntity({
    required this.dt,
    this.temp,
    this.humidity,
    required this.weatherType,
    this.windSpeed,
    this.date,
  });

  factory WeatherEntity.fromJson(Map<String, dynamic> json) {
    final weatherType = json['weather'] != null && json['weather'].isNotEmpty ? json['weather'][0] : {};
    return WeatherEntity(
      dt: json['dt'],
      temp: (json['main']['temp'] as num?)?.toDouble(),
      humidity: json['main']['humidity'],
      weatherType: WeatherTypeEnum.fromString(weatherType['main']),
      windSpeed: (json['wind']['speed'] as num?)?.toDouble(),
      date: json['dt_txt'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'dt': dt,
      'main': {
        'temp': temp,
        'humidity': humidity,
      },
      'weather': [
        {'main': weatherType.toString()},
      ],
      'wind': {'speed': windSpeed},
      'dt_txt': date,
    };
  }

  factory WeatherEntity.fromString(String jsonString) {
    final Map<String, dynamic> json = Map<String, dynamic>.from(jsonDecode(jsonString) as Map);
    return WeatherEntity.fromJson(json);
  }

  String toJsonString() {
    return jsonEncode(toJson());
  }
}
