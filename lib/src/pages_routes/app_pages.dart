import 'package:get/get.dart';

abstract class AppPages {
  static final pages = <GetPage>[
    GetPage(
      name: "/splash",
      page: () => const SplashScreen(),
    ),
  ];
}
