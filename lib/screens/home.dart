import 'package:flowpos_app/screens/history.dart';
import 'package:flowpos_app/screens/kasir_menu.dart';
import 'package:flowpos_app/screens/product.dart';
import 'package:flowpos_app/screens/setting.dart';
import 'package:flutter/material.dart';
import 'package:flowpos_app/colors/colors.dart';
import 'package:flowpos_app/widget/bottombar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SafeArea(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Pemilik',
                    style: TextStyle(
                      color: AppColors.secondary,
                      fontFamily: 'Poppins',
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    'Kayeye Kece',
                    style: TextStyle(
                      color: AppColors.primary,
                      fontFamily: 'Poppins',
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 7),
                  const Text(
                    'Kami siap menyiapkan kebutuhan anda',
                    style: TextStyle(
                      color: AppColors.secondary,
                      fontFamily: 'Poppins',
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: Image.asset(
                      'assets/images/HomeVector.png',
                      width: 220,
                      height: 220,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Expanded(
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemCount: 4,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  switch (index) {
                                    case 0:
                                      return const HistoryPage();
                                    case 1:
                                      return const ProductPage();
                                    case 2:
                                      return KasirMenuPage();
                                    case 3:
                                      return const SettingPage();
                                    default:
                                      return const HomePage();
                                  }
                                },
                              ),
                            );
                          },
                          child: Card(
                            color: Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: const BorderSide(color: AppColors.border),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  index == 0
                                      ? Icons.calendar_month_outlined
                                      : index == 1
                                          ? Icons.shopping_bag_outlined
                                          : index == 2
                                              ? Icons
                                                  .production_quantity_limits_outlined
                                              : Icons.settings,
                                  size: 40,
                                  color: AppColors.primary,
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  index == 0
                                      ? 'History'
                                      : index == 1
                                          ? 'Product'
                                          : index == 2
                                              ? 'Kasir'
                                              : 'Setting',
                                  style: const TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 16,
                                    color: AppColors.primary,
                                  ),
                                ),
                                const SizedBox(height: 10),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Positioned(
            bottom: 0,
            left: 15,
            right: 15,
            child: BottomBar(),
          ),
        ],
      ),
    );
  }
}
