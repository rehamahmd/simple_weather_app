import 'package:flutter_starter_kit/app/imports.dart';

import 'widgets/city_image_widget.dart';
import 'widgets/days_list_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
        props: MainAppBarProps(
          screenTitle: 'Weather App',
          titleWidget: ImageWidget(
            props: ImageWidgetProps(
              image: AppFlavors.logoPath,
              height: 45.h,
            ),
          ),
          showBackArrow: false,
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(child: CityImageWidget()),
            AppSpace.vertical(20),
            DaysListWidget(),
            AppSpace.vertical(50),
          ],
        ),
      ),
    );
  }
}
