import 'package:flutter_starter_kit/app/imports.dart';

class CityImageWidget extends StatelessWidget {
  const CityImageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppPadding.horizontalPadding,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.h),
          boxShadow: [
            BoxShadow(color: Colors.grey.shade300, blurRadius: 6),
          ],
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ImageWidget(
                props: ImageWidgetProps(
                  image: AppIcons.cityPng,
                  borderRadius: BorderRadius.circular(12.h),
                ),
              ),
            ),
            PositionedDirectional(
              top: 40.h,
              start: 40.w,
              child: AppText.primary(
                text: 'Dubai',
                appTextStyle: AppTextStyle.regular22White,
              ),
            )
          ],
        ),
      ),
    );
  }
}
