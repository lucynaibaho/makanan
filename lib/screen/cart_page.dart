import 'package:flutter/material.dart';

import '../models/cart_item_model.dart';
import '../models/food_model.dart';
import 'checkout_page.dart';

class CartPage extends StatelessWidget {
  const CartPage({
    super.key,
    required this.cart,
    required this.onRemoveItem,
    required this.onClearCart,
  });

  final List<CartItemModel> cart;
  final void Function(String) onRemoveItem;
  final VoidCallback onClearCart;

  double get _total => cart.fold(0, (sum, item) => sum + item.subtotal);

  Future<void> _checkout(BuildContext context) async {
    final result = await Navigator.push<bool>(
      context,
      MaterialPageRoute<bool>(
        builder: (_) => CheckoutPage(cart: List.unmodifiable(cart)),
      ),
    );

    if (result == true && context.mounted) {
      onClearCart();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Pesanan berhasil diproses. Terima kasih!'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (cart.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.shopping_bag_outlined,
                size: 62,
                color: Color(0xFF9AA49A),
              ),
              const SizedBox(height: 14),
              Text(
                'Keranjang masih kosong',
                style: Theme.of(context).textTheme.titleMedium
                    ?.copyWith(fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 6),
              const Text('Pilih menu yang ingin kamu nikmati.'),
            ],
          ),
        ),
      );
    }

    return Column(
      children: [
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
            itemCount: cart.length,
            separatorBuilder: (_, _) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final item = cart[index];
              return Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        item.food.imageUrl,
                        width: 74,
                        height: 74,
                        fit: BoxFit.cover,
                        errorBuilder: (_, _, _) => Container(
                          width: 74,
                          height: 74,
                          color: const Color(0xFFE5E8DD),
                          child: const Icon(Icons.restaurant),
                        ),
                      ),
                    ),
                    const SizedBox(width: 13),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.food.name,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontWeight: FontWeight.w700),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            '${item.quantity} porsi x ${formatRupiah(item.food.price)}',
                            style: const TextStyle(
                              color: Color(0xFF758078),
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            formatRupiah(item.subtotal),
                            style: const TextStyle(
                              color: Color(0xFFE7784A),
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      tooltip: 'Hapus ${item.food.name}',
                      onPressed: () => onRemoveItem(item.food.id),
                      icon: const Icon(
                        Icons.delete_outline,
                        color: Color(0xFFB64036),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        SafeArea(
          top: false,
          child: Container(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(top: BorderSide(color: Color(0xFFE8E9E2))),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    const Text('Total pembayaran'),
                    const Spacer(),
                    Text(
                      formatRupiah(_total),
                      style: const TextStyle(
                        color: Color(0xFF20382D),
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: FilledButton(
                    onPressed: () => _checkout(context),
                    child: const Text('Proses Pesanan'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
