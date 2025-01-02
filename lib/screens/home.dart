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
    // Mendapatkan ukuran layar
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.04, // 4% dari lebar layar
                vertical: screenHeight * 0.02, // 2% dari tinggi layar
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Pemilik',
                    style: TextStyle(
                      color: AppColors.secondary,
                      fontFamily: 'Poppins',
                      fontSize: screenWidth * 0.05, // Ukuran font dinamis
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.005), // Spasi dinamis
                  Text(
                    'Kayeye Kece',
                    style: TextStyle(
                      color: AppColors.primary,
                      fontFamily: 'Poppins',
                      fontSize: screenWidth * 0.05, // Ukuran font dinamis
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.007),
                  Text(
                    'Kami siap menyiapkan kebutuhan anda',
                    style: TextStyle(
                      color: AppColors.secondary,
                      fontFamily: 'Poppins',
                      fontSize: screenWidth * 0.035, // Ukuran font dinamis
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.03),
                  Center(
                    child: Image.asset(
                      'assets/images/HomeVector.png',
                      width: screenWidth * 0.5, // 50% dari lebar layar
                      height: screenWidth * 0.5, // Menyesuaikan rasio
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(
                        bottom: screenHeight * 0.1, // Jarak dari BottomBar
                      ),
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: screenWidth * 0.03,
                          mainAxisSpacing: screenHeight * 0.02,
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
                                    size: screenWidth * 0.1,
                                    color: AppColors.primary,
                                  ),
                                  SizedBox(height: screenHeight * 0.01),
                                  Text(
                                    index == 0
                                        ? 'History'
                                        : index == 1
                                            ? 'Product'
                                            : index == 2
                                                ? 'Kasir'
                                                : 'Setting',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: screenWidth * 0.04,
                                      color: AppColors.primary,
                                    ),
                                  ),
                                  SizedBox(height: screenHeight * 0.01),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: screenWidth * 0.04,
            right: screenWidth * 0.04,
            child: const BottomBar(),
          ),
        ],
      ),
    );
  }
}
