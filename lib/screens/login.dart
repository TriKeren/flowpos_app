import 'dart:convert';
import 'package:flowpos_app/models/popup_login.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flowpos_app/screens/home.dart';
import 'package:flowpos_app/screens/registrasi.dart';
import 'package:flowpos_app/colors/colors.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _obscureText = true;
  bool _usernameText = false;
  bool _passwordHasText = false;

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _login() async {
    final String username = _usernameController.text;
    final String password = _passwordController.text;

    // Validasi input
    if (username.isEmpty || password.isEmpty) {
      _showError("Email dan Password harus diisi.");
      return;
    }

    try {
      final response = await http.post(
        Uri.parse('https://posify-app.vercel.app/api/admin/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'username': username,
          'password': password,
        }),
      );

      print("Response status: ${response.statusCode}");
      print("Response body: ${response.body}");

      final responseBody = json.decode(response.body);

      if (response.statusCode == 200) {
        _showSuccess();
      } else {
        _showError(responseBody['message'] ?? "Login gagal. Coba lagi.");
      }
    } catch (e) {
      print("Exception: $e");
      _showError("Terjadi kesalahan, periksa koneksi internet.");
    }
  }

  void _showSuccess() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SuccessDialog(
          onConfirm: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const HomePage()),
            );
          },
        );
      },
    );
  }

  void _showError(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Tutup'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Posify',
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
                controller: _usernameController,
                onChanged: (text) {
                  setState(() {
                    _usernameText = text.isNotEmpty;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Username',
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  labelStyle: TextStyle(
                      color: _usernameText
                          ? AppColors.primary
                          : AppColors.secondary.withOpacity(0.5),
                      fontFamily: 'Poppins'),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _passwordController,
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
                onPressed: _login,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 159, vertical: 15),
                  textStyle: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                child: const Text(
                  'Login',
                  style: TextStyle(
                      color: Colors.white, fontSize: 16, fontFamily: 'Poppins'),
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
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                child: const Text(
                  'Registrasi',
                  style: TextStyle(
                      color: Colors.white, fontSize: 16, fontFamily: 'Poppins'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
