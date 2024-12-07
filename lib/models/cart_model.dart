import 'package:flutter/material.dart';

typedef Product = Map<String, dynamic>;

class CartModel extends ChangeNotifier {
  final List<Product> _cartItems = [];

  List<Product> get cartItems => List.unmodifiable(_cartItems);

  int get totalItems =>
      _cartItems.fold(0, (sum, item) => sum + (item['count'] as int));

  double get totalPrice =>
      _cartItems.fold(0, (sum, item) => sum + (item['price'] * item['count']));

  /// Menambahkan produk ke keranjang
  void addItem(Product product) {
    assert(
        product.containsKey('name'), 'Produk harus memiliki properti "name".');
    assert(product.containsKey('price'),
        'Produk harus memiliki properti "price".');

    final index =
        _cartItems.indexWhere((item) => item['name'] == product['name']);
    if (index != -1) {
      _cartItems[index]['count']++;
    } else {
      _cartItems.add({...product, 'count': 1});
    }
    notifyListeners();
  }

  /// Menghapus produk dari keranjang
  void removeItem(Map<String, dynamic> product) {
    final index =
        _cartItems.indexWhere((item) => item['name'] == product['name']);
    if (index != -1) {
      _cartItems.removeAt(index); // Hapus item dari keranjang
      notifyListeners();
    }
  }

  /// Membersihkan keranjang
  void clearCart() {
    if (_cartItems.isNotEmpty) {
      _cartItems.clear();
      notifyListeners();
    }
  }

  /// Memperbarui jumlah produk
  void updateItemCount(Product product, int newCount) {
    assert(newCount > 0, 'Jumlah produk harus lebih besar dari 0.');

    final index =
        _cartItems.indexWhere((item) => item['name'] == product['name']);
    if (index != -1) {
      _cartItems[index]['count'] = newCount;
      notifyListeners();
    }
  }

  /// Format harga total untuk tampilan
  String get formattedTotalPrice => 'Rp ${totalPrice.toStringAsFixed(2)}';
}
