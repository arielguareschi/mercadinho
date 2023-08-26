import 'package:get/get.dart';
import 'package:mercadinho/src/pages/cart/controller/cart_controller.dart';

class CartBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => CartController(),
      fenix: true,
    );
  }
}
