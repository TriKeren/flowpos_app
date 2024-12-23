import 'package:flowpos_app/colors/colors.dart';
import 'package:flowpos_app/screens/home.dart';
import 'package:flutter/material.dart';

class TransactionSucces extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          height: MediaQuery.of(context)
              .size
              .height,
          decoration: const BoxDecoration(
            color: AppColors.primary
          ),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 80),
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Positioned(
                          top: 30,
                          bottom: -20,
                          left: 20,
                          right: 20,
                          child: Container(
                            height: 200,
                            decoration: BoxDecoration(
                                color:
                                    const Color(0xff2D8DDC).withOpacity(0.80),
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.white.withOpacity(0.4),
                                      spreadRadius: 2,
                                      blurRadius: 20,
                                      offset: const Offset(0, 2))
                                ]),
                          ),
                        ),
                        Positioned(
                          top: 20,
                          bottom: -40,
                          left: 40,
                          right: 40,
                          child: Container(
                            height: 200,
                            decoration: BoxDecoration(
                              color: const Color(0xff2D8DDC).withOpacity(0.40),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        Card(
                          elevation: 2.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(20, 40, 20, 220),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image.asset('assets/images/Succes.png', width: 150),
                                const SizedBox(height: 20),
                                const Text(
                                  'Pembayaran Berhasil',
                                  style: TextStyle(
                                    color: Color(0xff1A72DD),
                                    fontSize: 29,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                RichText(
                                  textAlign: TextAlign.center,
                                  text: const TextSpan(
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                    ),
                                    children: [
                                      TextSpan(
                                        text:
                                            'Terima kasih atas pembayaran Anda! Transaksi telah berhasil diproses.',
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePage()));
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 125, vertical: 20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        )),
                    child: const Text(
                      'Next Order',
                      style: TextStyle(
                        color: Color(0xFF1488CC),
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
