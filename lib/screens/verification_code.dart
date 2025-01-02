import 'package:flowpos_app/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class VerificationCode extends StatelessWidget {
  final String email; 
  final TextEditingController _otpController = TextEditingController();

  VerificationCode({Key? key, required this.email}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    final bool isSmallScreen = screenWidth < 500;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Posify',
          style: TextStyle(
            fontFamily: 'Poppins',
            color: AppColors.primary,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: isSmallScreen ? 20.0 : 30.0,
        ),
          child: SingleChildScrollView(
            // ignore: prefer_const_constructors
            padding: EdgeInsets.symmetric(vertical: 60),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Verification',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Kami telah mengirimkan kode verifikasi ke alamat email Anda:',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 10),
                Text(
                  email,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(height: 30),
                PinCodeTextField(
                  appContext: context,
                  controller: _otpController,
                  length: 4,
                  keyboardType: TextInputType.number,
                  textStyle: TextStyle(fontSize: isSmallScreen ? 18 : 20),
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(5),
                    fieldHeight: isSmallScreen ? 60 : 70,
                    fieldWidth: isSmallScreen ? 60 : 80,
                  ),
                  onChanged: (value) {},
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    final otp = _otpController.text;
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Kode OTP: $otp')),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding: const EdgeInsets.all(0),
                  minimumSize: Size(screenWidth * 0.9, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                  child: const Text(
                    'Verify',
                    style: TextStyle(
                      fontSize:16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
  }
}
