import 'package:flutter/material.dart';

import '../models/food_model.dart';

class FoodDetailPage extends StatefulWidget {
  const FoodDetailPage({
    super.key,
    required this.food,
    required this.onAddToCart,
  });

  final FoodModel food;
  final Function(FoodModel, int) onAddToCart;

  @override
  State<FoodDetailPage> createState() => _FoodDetailPageState();
}

class _FoodDetailPageState extends State<FoodDetailPage> {
  int _quantity = 1;

  void _addToCart() {
    widget.onAddToCart(widget.food, _quantity);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '$_quantity porsi ${widget.food.name} ditambahkan ke keranjang.',
        ),
      ),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final food = widget.food;
    return Scaffold(
      appBar: AppBar(title: const Text('Detail Menu')),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(20, 4, 20, 24),
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(18),
                  child: AspectRatio(
                    aspectRatio: 1.25,
                    child: Image.network(
                      food.imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (_, _, _) => Container(
                        color: const Color(0xFFE5E8DD),
                        child: const Icon(Icons.restaurant, size: 64),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 22),
                Text(
                  food.category.toUpperCase(),
                  style: const TextStyle(
                    color: Color(0xFF758078),
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.8,
                  ),
                ),
                const SizedBox(height: 7),
                Text(
                  food.name,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: const Color(0xFF20382D),
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  formatRupiah(food.price),
                  style: const TextStyle(
                    color: Color(0xFFE7784A),
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  food.description,
                  style: const TextStyle(
                    color: Color(0xFF68756D),
                    fontSize: 15,
                    height: 1.55,
                  ),
                ),
                const SizedBox(height: 28),
                Row(
                  children: [
                    const Text(
                      'Jumlah porsi',
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                    const Spacer(),
                    IconButton.filledTonal(
                      tooltip: 'Kurangi porsi',
                      onPressed: _quantity > 1
                          ? () => setState(() => _quantity--)
                          : null,
                      icon: const Icon(Icons.remove),
                    ),
                    SizedBox(
                      width: 48,
                      child: Text(
                        '$_quantity',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    IconButton.filledTonal(
                      tooltip: 'Tambah porsi',
                      onPressed: () => setState(() => _quantity++),
                      icon: const Icon(Icons.add),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 16),
              child: SizedBox(
                width: double.infinity,
                height: 54,
                child: FilledButton.icon(
                  onPressed: _addToCart,
                  icon: const Icon(Icons.add_shopping_cart),
                  label: const Text('Tambah ke Keranjang'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
