import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:flowpos_app/widget/bottombar.dart';
import 'package:flowpos_app/widget/refresh_icon.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final TextEditingController _dateController = TextEditingController();
  String _selectedStatus = "Semua Status";

  List<Map<String, dynamic>> transactions = List.generate(5, (index) {
    return {
      'name': 'Transaksi #$index',
      'price': 250000 + index * 5000,
      'date': DateTime.now().subtract(Duration(days: index)),
      'status': index % 2 == 0 ? 'Berhasil' : 'Pending',
    };
  });

  List<Map<String, dynamic>> get filteredTransactions {
    return _selectedStatus == "Semua Status"
        ? transactions
        : transactions.where((t) => t['status'] == _selectedStatus).toList();
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      setState(() {
        _dateController.text = DateFormat('dd-MM-yyyy').format(pickedDate);
      });
    }
  }

  void _refreshTransactions() {
    setState(() {
      _selectedStatus = "Semua Status";
      transactions = List.generate(5, (index) {
        return {
          'name': 'Transaksi Baru #$index',
          'price': 200000 + index * 10000,
          'date': DateTime.now().subtract(Duration(days: index)),
          'status': index % 2 == 0 ? 'Berhasil' : 'Pending',
        };
      });
    });
  }

  void _confirmDelete(BuildContext context, Map<String, dynamic> transaction) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Hapus Transaksi'),
        content: const Text('Apakah Anda yakin ingin menghapus transaksi ini?'),
        actions: [
          TextButton(
            child: const Text('Batal'),
            onPressed: () => Navigator.of(context).pop(),
          ),
          TextButton(
            child: const Text('Hapus'),
            onPressed: () {
              setState(() {
                transactions.remove(transaction);
              });
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final formatter = NumberFormat("#,##0", "id_ID");

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        titleSpacing: 16,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'HISTORY PENJUALAN',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 20,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _dateController,
                    readOnly: true,
                    onTap: () => _selectDate(context),
                    decoration: InputDecoration(
                      hintText: 'Masukkan tanggal (dd-mm-yyyy)',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 0, horizontal: 10),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: _selectedStatus,
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedStatus = newValue!;
                        });
                      },
                      items: <String>[
                        'Semua Status',
                        'Berhasil',
                        'Pending',
                        'Gagal',
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                RefreshIcon(onRefresh: _refreshTransactions),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: filteredTransactions.isNotEmpty
                  ? ListView.builder(
                      itemCount: filteredTransactions.length,
                      itemBuilder: (context, index) {
                        String formattedDate = DateFormat('dd-MM-yyyy')
                            .format(filteredTransactions[index]['date']);
                        String formattedTime = DateFormat('HH:mm')
                            .format(filteredTransactions[index]['date']);

                        return Card(
                          elevation: 1,
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          child: ListTile(
                            leading: const Icon(Icons.shopping_cart_outlined),
                            title: Text(filteredTransactions[index]['name']),
                            subtitle: Text(
                                '$formattedDate, $formattedTime\nStatus: ${filteredTransactions[index]['status']}'),
                            trailing: SizedBox(
                              width: 150,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                      'Rp ${formatter.format(filteredTransactions[index]['price'])}'),
                                  IconButton(
                                    icon: const Icon(Icons.delete,
                                        color: Colors.red),
                                    onPressed: () => _confirmDelete(
                                        context, filteredTransactions[index]),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    )
                  : const Center(
                      child: Text(
                        'Tidak ada transaksi ditemukan',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black54,
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: BottomBar(),
      ),
    );
  }
}
