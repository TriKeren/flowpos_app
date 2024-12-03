import 'package:flowpos_app/screens/home.dart';
import 'package:flowpos_app/screens/registrasi.dart';
import 'package:flutter/material.dart';
import 'package:flowpos_app/colors/colors.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _obscureText = true;
  bool _storeNameHasText = false;
  bool _usernameHasText = false;
  bool _passwordHasText = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'tePOS',
          style: TextStyle(
              fontFamily: 'Poppins',
              color: AppColors.primary,
              fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 80),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Login',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 25,
                  color: AppColors.secondary,
                ),
              ),
              const SizedBox(height: 40),
              TextField(
                onChanged: (text) {
                  setState(() {
                    _storeNameHasText = text.isNotEmpty;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Store Name',
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  labelStyle: TextStyle(
                      color: _storeNameHasText
                          ? AppColors.primary
                          : AppColors.secondary.withOpacity(0.5),
                      fontFamily: 'Poppins'),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                onChanged: (text) {
                  setState(() {
                    _usernameHasText = text.isNotEmpty;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Username',
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  labelStyle: TextStyle(
                      color: _usernameHasText
                          ? AppColors.primary
                          : AppColors.secondary.withOpacity(0.5),
                      fontFamily: 'Poppins'),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                obscureText: _obscureText,
                onChanged: (text) {
                  setState(() {
                    _passwordHasText = text.isNotEmpty;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  labelStyle: TextStyle(
                      color: _passwordHasText
                          ? AppColors.primary
                          : AppColors.secondary.withOpacity(0.5),
                      fontFamily: 'Poppins'),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HomePage()));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 159, vertical: 15),
                  textStyle: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                child: const Text(
                  'Login',
                  style: TextStyle(
                      color: Colors.white, fontSize: 18, fontFamily: 'Poppins'),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Belum Punya Akun ??",
                style: TextStyle(
                    color: AppColors.secondary,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const RegistrasiPage()));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.secondary,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 140, vertical: 15),
                  textStyle: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                child: const Text(
                  'Registrasi',
                  style: TextStyle(
                      color: Colors.white, fontSize: 18, fontFamily: 'Poppins'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
