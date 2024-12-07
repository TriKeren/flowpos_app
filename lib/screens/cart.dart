import 'package:flowpos_app/colors/colors.dart';
import 'package:flowpos_app/screens/kasir_menu.dart';
import 'package:flowpos_app/screens/payment.dart';
import 'package:flowpos_app/widget/bottombar.dart';
import 'package:flutter/material.dart';
import 'package:flowpos_app/models/cart_model.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final numberFormat =
        NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        titleSpacing: 16,
        title: const Text(
          'KERANJANG  ',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 20,
            color: Colors.black,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => KasirMenuPage()));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'LIST MENU',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 14,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: Consumer<CartModel>(
              builder: (context, cart, child) {
                return ListView.builder(
                  itemCount: cart.cartItems.length,
                  itemBuilder: (context, index) {
                    final item = cart.cartItems[index];
                    return Card(
                      color: Colors.white,
                      margin: const EdgeInsets.all(8.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        side: BorderSide(
                          color: AppColors.border.withOpacity(0.5),
                          width: 1.0,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          children: [
                            Image.asset(
                              item['image'],
                              width: 80,
                              height: 80,
                              fit: BoxFit.cover,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item['name'],
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    numberFormat.format(item['price']),
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.black,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      IconButton(
                                        icon: const Icon(Icons.remove),
                                        onPressed: () {
                                          if (item['count'] > 1) {
                                            cart.updateItemCount(
                                                item,
                                                item['count'] -
                                                    1); 
                                          } else {
                                            cart.removeItem(
                                                item); 
                                          }
                                        },
                                      ),
                                      SizedBox(
                                        width: 50,
                                        height: 40,
                                        child: TextField(
                                          textAlign: TextAlign.center,
                                          keyboardType: TextInputType.number,
                                          controller: TextEditingController(
                                            text: '${item['count']}',
                                          ),
                                          onSubmitted: (value) {
                                            final newCount =
                                                int.tryParse(value) ?? 0;
                                            if (newCount > 0) {
                                              cart.updateItemCount(item,
                                                  newCount); 
                                            } else {
                                              cart.removeItem(
                                                  item); 
                                            }
                                          },
                                          decoration: const InputDecoration(
                                            border: OutlineInputBorder(),
                                          ),
                                        ),
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.add),
                                        onPressed: () =>
                                            cart.addItem(item),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                cart.removeItem(item); 
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Produk dihapus')),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Consumer<CartModel>(
              builder: (context, cart, child) {
                return Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    boxShadow: const [
                      BoxShadow(
                        blurRadius: 4,
                        color: Colors.grey,
                      ),
                    ],
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total: ${numberFormat.format(cart.totalPrice)}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PaymentPage(
                                totalAmount: cart.totalPrice,
                              ),
                            ),
                          );
                        },
                        child: const Text('Bayar'),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: BottomBar(),
          ),
        ],
      ),
    );
  }
}
