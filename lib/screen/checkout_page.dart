import 'package:flutter/material.dart';

import '../models/cart_item_model.dart';
import '../models/food_model.dart';

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({super.key, required this.cart});

  final List<CartItemModel> cart;

  double get _total => cart.fold(0, (sum, item) => sum + item.subtotal);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          tooltip: 'Kembali',
          onPressed: () => Navigator.pop(context, false),
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text('Konfirmasi Pesanan'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(20),
              itemCount: cart.length,
              separatorBuilder: (_, _) => const Divider(height: 24),
              itemBuilder: (context, index) {
                final item = cart[index];
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.food.name,
                            style: const TextStyle(fontWeight: FontWeight.w700),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            '${item.quantity} porsi x ${formatRupiah(item.food.price)}',
                            style: const TextStyle(color: Color(0xFF758078)),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      formatRupiah(item.subtotal),
                      style: const TextStyle(fontWeight: FontWeight.w700),
                    ),
                  ],
                );
              },
            ),
          ),
          SafeArea(
            top: false,
            child: Container(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 18),
              color: Colors.white,
              child: Column(
                children: [
                  Row(
                    children: [
                      const Text('Total pembayaran'),
                      const Spacer(),
                      Text(
                        formatRupiah(_total),
                        style: const TextStyle(
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
                    child: FilledButton.icon(
                      onPressed: () => Navigator.pop(context, true),
                      icon: const Icon(Icons.check_circle_outline),
                      label: const Text('Konfirmasi & Bayar'),
                    ),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context, false),
                    child: const Text('Batal'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
