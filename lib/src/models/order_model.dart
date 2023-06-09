import 'package:mercadinho/src/models/cart_item_model.dart';

class OrderModel {
  String copyAndPaste;
  DateTime createdDateTime;
  DateTime overdueDateTime;
  String id;
  String status;
  double total;
  List<CartItemModel> items;

  OrderModel({
    required this.copyAndPaste,
    required this.createdDateTime,
    required this.overdueDateTime,
    required this.id,
    required this.status,
    required this.total,
    required this.items,
  });
}
