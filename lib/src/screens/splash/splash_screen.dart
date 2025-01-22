import 'package:flutter_starter_kit/app/imports.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(seconds: 2), () {
        if (!mounted) return;
        Navigation.to(
          context,
          Routes.homeScreen,
          navigationType: NavigateType.goNamed,
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemUtils.setAppStatusBarThemeForAndroid(splash: true);
    return const Scaffold(body: AnimatedLogo());
  }
}

class AnimatedLogo extends HookWidget {
  const AnimatedLogo({super.key});

  @override
  Widget build(BuildContext context) {
    final animationController = useAnimationController(
      duration: const Duration(seconds: 3),
      lowerBound: .2,
    )..repeat(reverse: true);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FadeTransition(
              opacity: animationController,
              child: ImageWidget(
                props: ImageWidgetProps(
                  image: AppFlavors.logoPath,
                  width: 220.w,
                ),
              ),
            ),
            AppSpace.vertical(20),
            AppText.primary(
              text: 'Weather App',
              appTextStyle: AppTextStyle.bold36Royal,
            ),
          ],
        ),
      ),
    );
  }
}
