import 'food_model.dart';

class CartItemModel {
  CartItemModel({required this.food, required this.quantity});

  final FoodModel food;
  int quantity;

  double get subtotal => food.price * quantity;
}
