class FoodModel {
  const FoodModel({
    required this.id,
    required this.name,
    required this.category,
    required this.description,
    required this.imageUrl,
    required this.price,
  });

  final String id;
  final String name;
  final String category;
  final String description;
  final String imageUrl;
  final double price;
}

const foodCatalog = <FoodModel>[
  FoodModel(
    id: 'nasi-goreng',
    name: 'Nasi Goreng Kampung',
    category: 'Makanan',
    description: 'Nasi goreng berbumbu rempah dengan telur mata sapi, acar segar, dan kerupuk.',
    imageUrl: 'https://images.unsplash.com/photo-1603133872878-684f208fb84b?w=900&q=85',
    price: 28000,
  ),
  FoodModel(
    id: 'ayam-bakar',
    name: 'Ayam Bakar Madu',
    category: 'Makanan',
    description: 'Ayam bakar dengan olesan madu dan kecap, disajikan bersama nasi hangat dan sambal.',
    imageUrl: 'https://images.unsplash.com/photo-1598103442097-8b74394b95c6?w=900&q=85',
    price: 35000,
  ),
  FoodModel(
    id: 'soto-ayam',
    name: 'Soto Ayam Bening',
    category: 'Makanan',
    description: 'Kuah kaldu ayam yang ringan dengan suwiran ayam, telur, dan taburan bawang goreng.',
    imageUrl:
        'https://images.unsplash.com/photo-1547592180-85f173990554?w=900&q=85',
    price: 26000,
  ),
  FoodModel(
    id: 'gado-gado',
    name: 'Gado-Gado Siram',
    category: 'Makanan',
    description: 'Sayuran segar, tahu, tempe, dan telur dengan saus kacang yang dibuat setiap hari.',
    imageUrl: 'https://images.unsplash.com/photo-1512621776951-a57141f2eefd?w=900&q=85',
    price: 24000,
  ),
  FoodModel(
    id: 'es-teh',
    name: 'Es Teh Lemon',
    category: 'Minuman',
    description: 'Teh melati dingin dengan perasan lemon dan sedikit madu.',
    imageUrl:
        'https://images.unsplash.com/photo-1556679343-c7306c1976bc?w=900&q=85',
    price: 12000,
  ),
  FoodModel(
    id: 'jus-alpukat',
    name: 'Jus Alpukat',
    category: 'Minuman',
    description: 'Alpukat matang yang diblender lembut dengan susu cokelat.',
    imageUrl: 'https://images.unsplash.com/photo-1525385133512-2f3bdd039054?w=900&q=85',
    price: 18000,
  ),
];

String formatRupiah(num amount) {
  final rounded = amount.round().toString();
  final formatted = rounded.replaceAllMapped(
    RegExp(r'\B(?=(\d{3})+(?!\d))'),
    (_) => '.',
  );
  return 'Rp $formatted';
}
