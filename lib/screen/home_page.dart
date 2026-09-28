import 'package:flutter/material.dart';

import '../models/food_model.dart';
import 'food_detail_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.onAddToCart});

  final Function(FoodModel, int) onAddToCart;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _searchController = TextEditingController();
  String _category = 'Semua';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final query = _searchController.text.toLowerCase();
    final foods = foodCatalog.where((food) {
      final matchesCategory =
          _category == 'Semua' || food.category == _category;
      final matchesQuery = food.name.toLowerCase().contains(query);
      return matchesCategory && matchesQuery;
    }).toList();

    return Column(
      children: [
        Expanded(
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(22),
                        decoration: BoxDecoration(
                          color: const Color(0xFF285943),
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Hangat, segar,\ndan penuh rasa.',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 22,
                                      height: 1.15,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    'Masakan rumahan pilihan untuk harimu.',
                                    style: TextStyle(
                                      color: Colors.white.withValues(
                                        alpha: 0.82,
                                      ),
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Icon(
                              Icons.ramen_dining,
                              size: 68,
                              color: Color(0xFFFFD28D),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 22),
                      TextField(
                        controller: _searchController,
                        onChanged: (_) => setState(() {}),
                        decoration: const InputDecoration(
                          hintText: 'Cari menu favoritmu',
                          prefixIcon: Icon(Icons.search),
                        ),
                      ),
                      const SizedBox(height: 18),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: ['Semua', 'Makanan', 'Minuman'].map((item) {
                            final selected = _category == item;
                            return Padding(
                              padding: const EdgeInsets.only(right: 9),
                              child: ChoiceChip(
                                label: Text(item),
                                selected: selected,
                                showCheckmark: false,
                                onSelected: (_) =>
                                    setState(() => _category = item),
                                selectedColor: const Color(0xFFDDE9DF),
                                side: BorderSide(
                                  color: selected
                                      ? const Color(0xFF285943)
                                      : const Color(0xFFE1E4DA),
                                ),
                                labelStyle: TextStyle(
                                  color: selected
                                      ? const Color(0xFF285943)
                                      : const Color(0xFF68756D),
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      const SizedBox(height: 7),
                      Text(
                        'Menu pilihan',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: const Color(0xFF20382D),
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (foods.isEmpty)
                const SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(child: Text('Menu tidak ditemukan.')),
                )
              else
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
                  sliver: SliverGrid.builder(
                    itemCount: foods.length,
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 260,
                          mainAxisSpacing: 14,
                          crossAxisSpacing: 14,
                          childAspectRatio: 0.72,
                        ),
                    itemBuilder: (context, index) => _FoodCard(
                      food: foods[index],
                      onTap: () => Navigator.of(context).push<void>(
                        MaterialPageRoute<void>(
                          builder: (_) => FoodDetailPage(
                            food: foods[index],
                            onAddToCart: widget.onAddToCart,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

class _FoodCard extends StatelessWidget {
  const _FoodCard({required this.food, required this.onTap});

  final FoodModel food;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SizedBox(
                width: double.infinity,
                child: Image.network(
                  food.imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (_, _, _) => Container(
                    color: const Color(0xFFE5E8DD),
                    child: const Center(
                      child: Icon(Icons.restaurant, size: 42),
                    ),
                  ),
                  loadingBuilder: (context, child, progress) => progress == null
                      ? child
                      : Container(
                          color: const Color(0xFFE5E8DD),
                          alignment: Alignment.center,
                          child: const Icon(Icons.restaurant, size: 36),
                        ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 11, 12, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    food.category.toUpperCase(),
                    style: const TextStyle(
                      color: Color(0xFF788278),
                      fontSize: 10,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.6,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    food.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Color(0xFF20382D),
                      fontWeight: FontWeight.w700,
                      height: 1.15,
                    ),
                  ),
                  const SizedBox(height: 7),
                  Text(
                    formatRupiah(food.price),
                    style: const TextStyle(
                      color: Color(0xFFE7784A),
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
