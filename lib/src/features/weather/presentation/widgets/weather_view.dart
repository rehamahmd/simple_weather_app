import 'package:flutter_starter_kit/app/imports.dart';

import 'weather_details_widget.dart';

class WeatherView extends StatelessWidget {
  const WeatherView({super.key});
  _onRefresh(context) {
    Navigation.root(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherCubit, WeatherState>(
      builder: (context, state) {
        return switch (state) {
          WeatherLoading() => const LoadingWidget(),
          WeatherLoaded() => WeatherDetailsWidget(weather: state.weather),
          WeatherError() => ErrorScreen.show(state.error),
          _ => const SizedBox()
        };
      },
    );
  }
}
