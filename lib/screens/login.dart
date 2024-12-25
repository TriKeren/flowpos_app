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
  bool _isLoading = false; // Track loading state
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _login() async {
    final String username = _usernameController.text;
    final String password = _passwordController.text;

    if (username.isEmpty || password.isEmpty) {
      _showError("Email dan Password harus diisi.");
      return;
    }

    setState(() {
      _isLoading = true; // Start loading
    });

    try {
      final response = await http.post(
        Uri.parse('https://posify-app.vercel.app/api/admin/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'username': username,
          'password': password,
        }),
      );

      final responseBody = json.decode(response.body);
      if (response.statusCode == 200) {
        _showSuccess();
      } else {
        _showError(responseBody['message'] ?? "Login gagal. Coba lagi.");
      }
    } catch (e) {
      _showError("Terjadi kesalahan, periksa koneksi internet.");
    } finally {
      setState(() {
        _isLoading = false; // Stop loading after process completes
      });
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
    final double screenWidth = MediaQuery.of(context).size.width;

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
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.05,
          vertical: 50,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const AnimatedOpacity(
                opacity: 1.0,
                duration: Duration(seconds: 1),
                child: Text(
                  'Login',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 25,
                    color: AppColors.secondary,
                  ),
                ),
              ),
              SizedBox(height: screenWidth * 0.1),
              AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
                child: TextField(
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
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
              ),
              SizedBox(height: screenWidth * 0.04),
              AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
                child: TextField(
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
              ),
              SizedBox(height: screenWidth * 0.1),
              ElevatedButton(
                onPressed: _isLoading ? null : _login, // Disable button during loading
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding: const EdgeInsets.all(0),
                  minimumSize: Size(screenWidth * 0.9, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                child: _isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : const Text(
                        'Login',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontFamily: 'Poppins',
                        ),
                      ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Belum Punya Akun ??",
                style: TextStyle(
                  color: AppColors.secondary,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RegistrasiPage(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.secondary,
                  padding: const EdgeInsets.all(0),
                  minimumSize: Size(screenWidth * 0.9, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                child: const Text(
                  'Registrasi',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
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
