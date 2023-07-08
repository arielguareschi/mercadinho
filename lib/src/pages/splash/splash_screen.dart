import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mercadinho/src/config/custom_colors.dart';
// import 'package:mercadinho/src/pages/auth/sign_in_screen.dart';
import 'package:mercadinho/src/pages/common_widgets/app_name_widget.dart';
import 'package:mercadinho/src/pages_routes/app_pages.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(
      const Duration(seconds: 2),
      () {
        Get.offNamed(PagesRoutes.signInRoute);
        // Navigator.of(context).pushReplacement(
        //   MaterialPageRoute(
        //     builder: (context) {
        //       return const SignInScreen();
        //     },
        //   ),
        // );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              CustomColors.customSwatchColor.shade300,
              CustomColors.customSwatchColor.shade500,
              CustomColors.customSwatchColor,
            ],
          ),
        ),
        alignment: Alignment.center,
        child: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppNameWidget(
              greenTitleColor: Colors.green,
              textSize: 60,
            ),
            LinearProgressIndicator(
              valueColor: AlwaysStoppedAnimation(Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
