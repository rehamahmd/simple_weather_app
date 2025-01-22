import 'package:flutter_starter_kit/app/imports.dart';

class DaysListWidget extends StatelessWidget {
  const DaysListWidget({super.key});
  _navigateToWeatherScreen(String day, BuildContext context) {
    Navigation.to(context, Routes.weatherScreen, pathParameters: {"day": day});
  }

  @override
  Widget build(BuildContext context) {
    final days = [
      DateTime.now(),
      DateTime.now().add(Duration(days: 1)),
      DateTime.now().add(Duration(days: 2)),
    ];
    return SizedBox(
      height: 130.h,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          ...days.map(
            (e) => InkWell(
              onTap: () => _navigateToWeatherScreen(e.day.toString(), context),
              child: Padding(
                padding: EdgeInsetsDirectional.symmetric(horizontal: 15.w, vertical: 6.h),
                child: Container(
                  constraints: BoxConstraints(minWidth: 320.w),
                  height: 130.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.h),
                    color: AppColors.whiteForeground,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade300,
                        blurRadius: 6,
                      ),
                    ],
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ImageWidget(
                        props: ImageWidgetProps(
                          image: AppFlavors.logoPath,
                          height: 45.h,
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppText.primary(
                            text: DateTimeUtils.getDayName(e),
                            appTextStyle: AppTextStyle.regular18Black,
                          ),
                          AppText.primary(
                            text: " ${DateTimeUtils.slashFormat(e)} ",
                            appTextStyle: AppTextStyle.regular14Grey,
                          ),
                          AppSpace.vertical(10),
                          Row(
                            children: [
                              AppText.primary(
                                text: 'see weather',
                                appTextStyle: AppTextStyle.regular16Royal,
                              ),
                              Icon(Icons.arrow_forward_rounded),
                            ],
                          )
                        ],
                      ),
                      AppText.primary(
                        text: e.day.toString(),
                        appTextStyle: AppTextStyle.bold36Royal,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
