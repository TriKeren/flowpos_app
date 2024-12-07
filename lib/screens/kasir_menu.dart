import 'package:flowpos_app/colors/colors.dart';
import 'package:flowpos_app/widget/bottombar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:flowpos_app/models/cart_model.dart';
import 'package:flowpos_app/screens/cart.dart';

class KasirMenuPage extends StatefulWidget {
  @override
  _KasirMenuPageState createState() => _KasirMenuPageState();
}

class _KasirMenuPageState extends State<KasirMenuPage> {
  String? selectedCategory;
  final List<String> categories = ['Makanan', 'Minuman', 'Cemilan'];
  final List<Map<String, dynamic>> products = [
    {
      'name': 'Nasi Goreng',
      'price': 15000,
      'category': 'Makanan',
      'image': 'assets/images/nasigoreng.png',
    },
    {
      'name': 'Mie Goreng',
      'price': 15000,
      'category': 'Makanan',
      'image': 'assets/images/miegoreng.png',
    },
    {
      'name': 'Es Teh',
      'price': 5000,
      'category': 'Minuman',
      'image': 'assets/images/esteh.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final filteredProducts =
        (selectedCategory == null || selectedCategory == 'Semua Produk')
            ? products
            : products
                .where((product) => product['category'] == selectedCategory)
                .toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        titleSpacing: 16,
        title: const Text(
          'TAMBAH PRODUK',
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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CartPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Keranjang',
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
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: DropdownButtonFormField<String>(
                      value: selectedCategory,
                      isExpanded: true,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 8),
                      ),
                      hint: const Text(
                        'Pilih Kategori',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 14,
                          color: Colors.black54,
                        ),
                      ),
                      dropdownColor: Colors.white,
                      elevation: 1,
                      items: ['Semua Produk', ...categories].map((category) {
                        return DropdownMenuItem<String>(
                          value: category,
                          child: Text(
                            category,
                            style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 14,
                            ),
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedCategory = value;
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                RefreshIcon(
                  onRefresh: () {
                    setState(() {
                      selectedCategory = null;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: 0.9,
                ),
                itemCount: filteredProducts.length,
                itemBuilder: (context, index) {
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 4,
                    child: Stack(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.asset(
                                  filteredProducts[index]['image'],
                                  height: 100,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    filteredProducts[index]['name'],
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    '${NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0).format(filteredProducts[index]['price'])}',
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.green,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Positioned(
                          bottom: 10,
                          right: 2,
                          child: ElevatedButton(
                            onPressed: () {
                              Provider.of<CartModel>(context, listen: false)
                                  .addItem(filteredProducts[index]);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              padding: const EdgeInsets.all(8),
                              shape: const CircleBorder(),
                            ),
                            child: const Icon(
                              Icons.add,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: BottomBar(),
      ),
    );
  }
}

class RefreshIcon extends StatefulWidget {
  final VoidCallback onRefresh;

  const RefreshIcon({Key? key, required this.onRefresh}) : super(key: key);

  @override
  _RefreshIconState createState() => _RefreshIconState();
}

class _RefreshIconState extends State<RefreshIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _rotationAnimation = Tween<double>(begin: 0, end: 2 * 3.14159).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.linear));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: IconButton(
        onPressed: () {
          widget.onRefresh();
          _animationController.forward(from: 0);
        },
        icon: AnimatedBuilder(
          animation: _rotationAnimation,
          builder: (context, child) {
            return Transform.rotate(
              angle: _rotationAnimation.value,
              child:
                  const Icon(Icons.refresh_outlined, color: AppColors.primary),
            );
          },
        ),
        iconSize: 30,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
