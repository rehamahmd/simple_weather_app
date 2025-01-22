import 'package:flutter_starter_kit/app/imports.dart';

enum WeatherTypeEnum {
  sunny('clear', 'Sunny \nDay \nWalk', AppIcons.sunnyPng, AppColors.sunnyBgColor),
  cloudy('cloud', "It's \ncloudy \nnow", AppIcons.cloudPng, AppColors.cloudyBgColor),
  rainy('rainy', "It's \nraining \nnow", AppIcons.rainPng, AppColors.rainyBgColor);

  final String text;
  final String uiText;
  final String icon;
  final Color color;
  const WeatherTypeEnum(this.text, this.uiText, this.icon, this.color);

  static WeatherTypeEnum fromString(String name) {
    return WeatherTypeEnum.values.firstWhere(
      (weatherType) => weatherType.text.toLowerCase() == name.toLowerCase(),
      orElse: () => WeatherTypeEnum.sunny,
    );
  }
}
