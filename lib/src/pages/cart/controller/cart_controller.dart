import 'package:get/get.dart';
import 'package:mercadinho/src/models/cart_item_model.dart';
import 'package:mercadinho/src/models/item_model.dart';
import 'package:mercadinho/src/pages/auth/controller/auth_controller.dart';
import 'package:mercadinho/src/pages/cart/cart_result/cart_result.dart';
import 'package:mercadinho/src/pages/cart/repository/cart_repository.dart';
import 'package:mercadinho/src/services/utils_services.dart';

class CartController extends GetxController {
  final cartRepository = CartRepository();

  final autController = Get.find<AuthController>();
  final utilServices = UtilServices();

  List<CartItemModel> cartItems = [];

  @override
  void onInit() {
    super.onInit();
    getCartItems();
  }

  double cartTotalPrice() {
    double total = 0;
    for (final item in cartItems) {
      total += item.totalPrice();
    }
    return total;
  }

  int getCartTotalItems() {
    return cartItems.isEmpty
        ? 0
        : cartItems.map((e) => e.quantity).reduce((a, b) => a + b);
  }

  Future<bool> changeItemQuantity({
    required CartItemModel item,
    required int quantity,
  }) async {
    final result = await cartRepository.changeItemQuantity(
      token: autController.user.token!,
      cartItemId: item.id,
      quantity: quantity,
    );

    if (result) {
      if (quantity == 0) {
        cartItems.removeWhere((cartItem) => cartItem.id == item.id);
      } else {
        cartItems.firstWhere((cartItem) => cartItem.id == item.id).quantity =
            quantity;
      }
      update();
    } else {
      utilServices.showToast(
        message: "Erro ao atualizar o item",
        isError: true,
      );
    }

    return result;
  }

  Future<void> getCartItems() async {
    final CartResult<List<CartItemModel>> result =
        await cartRepository.getCartItems(
      token: autController.user.token!,
      userId: autController.user.id!,
    );

    result.when(
      success: (data) {
        cartItems = data;
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

  int getItemIndex(ItemModel item) {
    return cartItems.indexWhere((itemInList) => itemInList.item.id == item.id);
  }

  Future<void> addItemToCart({
    required ItemModel item,
    int quantity = 1,
  }) async {
    int itemIndex = getItemIndex(item);
    if (itemIndex >= 0) {
      // ja existe
      final product = cartItems[itemIndex];

      await changeItemQuantity(
        item: product,
        quantity: (product.quantity + quantity),
      );
    } else {
      final CartResult<String> result = await cartRepository.addItemToCart(
        userId: autController.user.id!,
        token: autController.user.token!,
        productId: item.id,
        quantity: quantity,
      );

      result.when(
        success: (cartItemId) {
          cartItems.add(
            CartItemModel(
              item: item,
              quantity: quantity,
              id: cartItemId,
            ),
          );
        },
        error: (message) {
          utilServices.showToast(
            message: message,
            isError: true,
          );
        },
      );
      // nao tem ainda
    }
    update();
  }
}
