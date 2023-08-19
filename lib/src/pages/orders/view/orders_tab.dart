import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mercadinho/src/pages/orders/controller/all_orders_controller.dart';
import 'package:mercadinho/src/pages/orders/view/components/order_tile.dart';

class OrdersTab extends StatelessWidget {
  const OrdersTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pedidos"),
      ),
      body: GetBuilder<AllOrdersController>(
        builder: (controller) {
          return ListView.separated(
            padding: const EdgeInsets.all(16),
            physics: const BouncingScrollPhysics(),
            itemBuilder: (_, index) =>
                OrderTile(order: controller.allOrders[index]),
            separatorBuilder: (_, index) => const SizedBox(height: 10),
            itemCount: controller.allOrders.length,
          );
        },
      ),
    );
  }
}
