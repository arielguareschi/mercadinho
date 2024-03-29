import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mercadinho/src/pages/base/controller/navigation_controller.dart';
import 'package:mercadinho/src/pages/cart/view/cart_tab.dart';
import 'package:mercadinho/src/pages/home/view/home_tab.dart';
import 'package:mercadinho/src/pages/orders/view/orders_tab.dart';
import 'package:mercadinho/src/pages/profile/profile_tab.dart';

class BaseScreen extends StatefulWidget {
  const BaseScreen({super.key});

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  final navigationController = Get.find<NavigationController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: navigationController.pageController,
        children: const [
          HomeTab(),
          CartTab(),
          OrdersTab(),
          ProfileTab(),
        ],
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.green,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white.withAlpha(100),
          currentIndex: navigationController.currentIndex,
          onTap: (index) {
            navigationController.navigatePageView(index);
            // setState(() {
            //   currentIndex = index;
            //   //pageController.jumpToPage(index);
            //   pageController.animateToPage(
            //     index,
            //     duration: const Duration(
            //       milliseconds: 300,
            //     ),
            //     curve: Curves.bounceInOut,
            //   );
            // });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart_outlined),
              label: 'Carrinho',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              label: 'Pedidos',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              label: 'Perfil',
            ),
          ],
        ),
      ),
    );
  }
}
