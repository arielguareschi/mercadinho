import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mercadinho/src/pages/auth/controller/auth_controller.dart';
import 'package:mercadinho/src/pages_routes/app_pages.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(AuthController());
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Mercadinho',
      theme: ThemeData(
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: Colors.white.withAlpha(190),
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: PagesRoutes.splashRoute,
      getPages: AppPages.pages,
    );
  }
}
