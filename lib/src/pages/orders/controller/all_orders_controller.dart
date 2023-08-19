import 'package:get/get.dart';
import 'package:mercadinho/src/models/order_model.dart';
import 'package:mercadinho/src/pages/auth/controller/auth_controller.dart';
import 'package:mercadinho/src/pages/orders/repository/orders_repository.dart';
import 'package:mercadinho/src/pages/orders/result/orders_result.dart';
import 'package:mercadinho/src/services/utils_services.dart';

class AllOrdersController extends GetxController {
  List<OrderModel> allOrders = [];

  final ordersRepository = OrdersRepository();

  final authController = Get.find<AuthController>();
  final utilServices = UtilServices();

  @override
  void onInit() {
    super.onInit();
    getAllOrders();
  }

  Future<void> getAllOrders() async {
    OrdersResult<List<OrderModel>> result = await ordersRepository.getAllOrders(
      userId: authController.user.id!,
      token: authController.user.token!,
    );

    result.when(
      success: (orders) {
        allOrders = orders;
        update();
      },
      error: (message) {
        utilServices.showToast(
          message: message,
          isError: true,
        );
      },
    );
  }
}
