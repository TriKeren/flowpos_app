import 'package:flowpos_app/screens/history.dart';
import 'package:flowpos_app/screens/home.dart';
import 'package:flowpos_app/screens/kasir_menu.dart';
import 'package:flowpos_app/screens/product.dart';
import 'package:flowpos_app/screens/setting.dart';
import 'package:flutter/material.dart';
import 'package:flowpos_app/colors/colors.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 3, vertical: 20),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(30),
          bottom: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            icon: const Icon(Icons.home_outlined, color: Colors.white),
            onPressed: () {
              Navigator.push(context, 
                  MaterialPageRoute(builder: (context) => const HomePage()));
            },
          ),
          IconButton(
            icon: const Icon(Icons.production_quantity_limits_outlined, color: Colors.white),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => KasirMenuPage()));
            },
          ),
          IconButton(
            icon: const Icon(Icons.shopping_bag_outlined, color: Colors.white),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const ProductPage()));
            },
          ),
          IconButton(
            icon: const Icon(Icons.calendar_month_outlined, color: Colors.white),
            onPressed: () {
               Navigator.push(context, MaterialPageRoute(builder: (context) => const HistoryPage()));
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.white),
            onPressed: () {
               Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingPage()));
            },
          ),
        ],
      ),
    );
  }
}
