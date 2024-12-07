import 'package:flowpos_app/colors/colors.dart';
import 'package:flowpos_app/screens/login.dart';
import 'package:flutter/material.dart';

class RegistrasiPage extends StatefulWidget {
  const RegistrasiPage({super.key});

  @override
  _RegistrasiPageState createState() => _RegistrasiPageState();
}

class _RegistrasiPageState extends State<RegistrasiPage> {
  bool _obscureText = true;
  bool _usernameHasText = false;
  bool _passwordHasText = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'tePOS',
          style: TextStyle(
            fontFamily: 'Poppins',
            color: AppColors.primary,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 80),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Center(
                child: Text(
                  'Register',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 25,
                    color: AppColors.secondary,
                  ),
                ),
              ),
              const SizedBox(height: 40),
              TextField(
                onChanged: (text) {
                  setState(() {
                    _usernameHasText = text.isNotEmpty;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Nama Pemilik Toko',
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  labelStyle: TextStyle(
                    color: _usernameHasText
                        ? AppColors.primary
                        : AppColors.secondary.withOpacity(0.5),
                    fontFamily: 'Poppins',
                  ),
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
                    fontFamily: 'Poppins',
                  ),
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
                    fontFamily: 'Poppins',
                  ),
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
              const SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Storename',
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  labelStyle: TextStyle(
                    color: AppColors.secondary.withOpacity(0.5),
                    fontFamily: 'Poppins',
                  ),
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 140,
                    vertical: 15,
                  ),
                  textStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                child: const Text(
                  'Register',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Poppins',
                    fontSize: 16
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Center(
                child: Text(
                  'Sudah punya akun ???',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 16,
                    color: AppColors.secondary,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.secondary,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 150,
                    vertical: 15,
                  ),
                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                child: const Text(
                  'Login',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Poppins',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
