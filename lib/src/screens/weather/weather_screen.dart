import 'package:flutter_starter_kit/app/imports.dart';

class WeatherScreen extends StatelessWidget {
  final String? day;
  const WeatherScreen({super.key, this.day});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WeatherCubit(getIt())..getCityWeatherByDay(day),
      child: Scaffold(
        // appBar: MainAppBar(props: MainAppBarProps(screenTitle: '')),
        body: Center(child: WeatherView()),
      ),
    );
  }
}
