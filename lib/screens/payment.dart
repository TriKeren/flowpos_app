import 'package:flowpos_app/screens/payment_succes.dart';
import 'package:flowpos_app/widget/bottombar.dart';
import 'package:flutter/material.dart';
import 'package:flowpos_app/colors/colors.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';

class PaymentPage extends StatefulWidget {
  final double totalAmount;

  const PaymentPage({Key? key, required this.totalAmount}) : super(key: key);

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final numberFormat =
      NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);

  final TextEditingController _bayarController = TextEditingController();
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _keteranganController = TextEditingController();

  double _kembalian = 0;

  void _hitungKembalian() {
  double bayar = double.tryParse(_bayarController.text.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0;
  print("Jumlah yang dibayar: $bayar");  
  setState(() {
    _kembalian = bayar >= widget.totalAmount ? bayar - widget.totalAmount : 0;
  });
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: const Text(
          'Halaman Pembayaran',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 20,
            color: Colors.black,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Total Harga',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      numberFormat.format(widget.totalAmount),
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),

                    const Text(
                      'Jumlah yang Dibayar',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _bayarController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        _CurrencyInputFormatter(),
                      ],
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        prefixText: 'Rp ',
                      ),
                      onChanged: (_) => _hitungKembalian(),
                    ),
                    const SizedBox(height: 10),

                    const Text(
                      'Kembalian',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      numberFormat.format(_kembalian),
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                    const SizedBox(height: 20),

                    const Text(
                      'Nama Pembeli',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _namaController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Keterangan (Opsional)',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _keteranganController,
                      maxLines: 5,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        hintText: 'Masukkan keterangan atau catatan pembelian...',
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 150),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TransactionSucces(),
                        ),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Pembayaran berhasil!'),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    child: const Text(
                      'Konfirmasi Pembayaran',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: BottomBar(),
      ),
    );
  }
}

class _CurrencyInputFormatter extends TextInputFormatter {
  final NumberFormat _currencyFormatter =
      NumberFormat.currency(locale: 'id_ID', symbol: '', decimalDigits: 0);

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    String newText = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');
    if (newText.isEmpty) {
      return const TextEditingValue(text: '');
    }
    final double value = double.tryParse(newText) ?? 0;
    final formattedValue = _currencyFormatter.format(value);
    return TextEditingValue(
      text: formattedValue,
      selection: TextSelection.collapsed(offset: formattedValue.length),
    );
  }
}
