import 'package:flutter/material.dart';

class SuccessDialog extends StatelessWidget {
  final VoidCallback onConfirm;

  const SuccessDialog({super.key, required this.onConfirm});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Sukses'),
      content: const Text('Login berhasil!'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context); // Tutup dialog
            onConfirm(); // Jalankan fungsi setelah dialog ditutup
          },
          child: const Text('OK'),
        ),
      ],
    );
  }
}
