import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mercadinho/src/config/custom_colors.dart';
import 'package:mercadinho/src/models/cart_item_model.dart';
import 'package:mercadinho/src/pages/cart/controller/cart_controller.dart';
import 'package:mercadinho/src/pages/common_widgets/quantity_widget.dart';
import 'package:mercadinho/src/services/utils_services.dart';

class CartTile extends StatefulWidget {
  final CartItemModel cartItem;

  const CartTile({
    super.key,
    required this.cartItem,
  });

  @override
  State<CartTile> createState() => _CartTileState();
}

class _CartTileState extends State<CartTile> {
  UtilServices utilServices = UtilServices();
  final controller = Get.find<CartController>();

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        // imagem
        leading: Image.network(
          widget.cartItem.item.imgUrl,
          height: 60,
          width: 60,
        ),
        // titulo
        title: Text(
          widget.cartItem.item.itemName,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),
        // total
        subtitle: Text(
          utilServices.priceToCurrency(widget.cartItem.totalPrice()),
          style: TextStyle(
            color: CustomColors.customSwatchColor,
            fontWeight: FontWeight.bold,
          ),
        ),

        // quantidade
        trailing: QuantityWidget(
          isRemovable: true,
          suffixText: widget.cartItem.item.unit,
          value: widget.cartItem.quantity,
          result: (quantity) {
            controller.changeItemQuantity(
              item: widget.cartItem,
              quantity: quantity,
            );
          },
        ),
      ),
    );
  }
}
