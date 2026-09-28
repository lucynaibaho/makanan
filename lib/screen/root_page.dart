import 'package:flutter/material.dart';

import '../models/cart_item_model.dart';
import '../models/food_model.dart';
import 'cart_page.dart';
import 'home_page.dart';
import 'login_page.dart';
import 'profile_page.dart';

class RootPage extends StatefulWidget {
  const RootPage({
    super.key,
    required this.studentName,
    required this.studentId,
  });

  final String studentName;
  final String studentId;

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  final List<CartItemModel> _cart = [];
  int _selectedIndex = 0;

  void _addToCart(FoodModel food, int quantity) {
    setState(() {
      final matchingItems = _cart.where((item) => item.food.id == food.id);
      if (matchingItems.isNotEmpty) {
        matchingItems.first.quantity += quantity;
      } else {
        _cart.add(CartItemModel(food: food, quantity: quantity));
      }
    });
  }

  void _removeFromCart(String foodId) {
    setState(() {
      _cart.removeWhere((item) => item.food.id == foodId);
    });
  }

  void _clearCart() {
    setState(_cart.clear);
  }

  int get _totalQuantity =>
      _cart.fold(0, (total, item) => total + item.quantity);

  @override
  Widget build(BuildContext context) {
    final titles = ['Menu', 'Keranjang', 'Profil'];
    final pages = [
      HomePage(onAddToCart: _addToCart),
      CartPage(
        cart: _cart,
        onRemoveItem: _removeFromCart,
        onClearCart: _clearCart,
      ),
      ProfilePage(
        studentName: widget.studentName,
        studentId: widget.studentId,
        onLogout: () {
          _clearCart();
          Navigator.pushAndRemoveUntil<void>(
            context,
            MaterialPageRoute<void>(builder: (_) => const LoginPage()),
            (_) => false,
          );
        },
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          titles[_selectedIndex],
          style: const TextStyle(fontWeight: FontWeight.w800),
        ),
        actions: [
          if (_selectedIndex == 0)
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Center(
                child: Text(
                  'Halo, ${widget.studentName.split(' ').first}',
                  style: const TextStyle(
                    color: Color(0xFF68756D),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
        ],
      ),
      body: IndexedStack(index: _selectedIndex, children: pages),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) =>
            setState(() => _selectedIndex = index),
        destinations: [
          const NavigationDestination(
            icon: Icon(Icons.restaurant_menu_outlined),
            selectedIcon: Icon(Icons.restaurant_menu),
            label: 'Menu',
          ),
          NavigationDestination(
            icon: _CartBadge(count: _totalQuantity, selected: false),
            selectedIcon: _CartBadge(count: _totalQuantity, selected: true),
            label: 'Keranjang',
          ),
          const NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}

class _CartBadge extends StatelessWidget {
  const _CartBadge({required this.count, required this.selected});

  final int count;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 34,
      height: 30,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            left: 4,
            bottom: 2,
            child: Icon(
              selected ? Icons.shopping_bag : Icons.shopping_bag_outlined,
            ),
          ),
          if (count > 0)
            Positioned(
              right: -8,
              top: -6,
              child: Container(
                constraints: const BoxConstraints(minWidth: 18, minHeight: 18),
                padding: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFE7784A),
                  borderRadius: BorderRadius.circular(20),
                ),
                alignment: Alignment.center,
                child: Text(
                  count > 99 ? '99+' : '$count',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
