import 'package:flowpos_app/screens/product.dart';
import 'package:flowpos_app/widget/bottombar.dart';
import 'package:flutter/material.dart';
import 'package:flowpos_app/colors/colors.dart';
import 'package:image_picker/image_picker.dart';

class EditProduct extends StatefulWidget {
  final String initialName;
  final String initialPrice;
  final String initialDescription;
  final String initialCategory;
  final XFile? initialImage;

  const EditProduct({
    super.key,
    required this.initialName,
    required this.initialPrice,
    required this.initialDescription,
    required this.initialCategory,
    this.initialImage,
  });

  @override
  State<EditProduct> createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  String? selectedCategory;
  final List<String> categories = ['Makanan', 'Minuman', 'Dessert'];
  late TextEditingController nameController;
  late TextEditingController priceController;
  late TextEditingController descriptionController;
  XFile? imageFile;

  @override
  void initState() {
    super.initState();
    selectedCategory = widget.initialCategory;
    nameController = TextEditingController(text: widget.initialName);
    priceController = TextEditingController(text: widget.initialPrice);
    descriptionController =
        TextEditingController(text: widget.initialDescription);
    imageFile = widget.initialImage;
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      imageFile = pickedFile;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        titleSpacing: 16,
        title: const Text(
          'EDIT PRODUK',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 20,
            color: Colors.black,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const ProductPage()));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Produk',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 14,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Pilih Kategori',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.border),
                borderRadius: BorderRadius.circular(8),
              ),
              child: DropdownButtonFormField<String>(
                value: selectedCategory,
                isExpanded: true,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 16),
                ),
                hint: const Text(
                  'Pilih Kategori',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
                dropdownColor: Colors.white,
                elevation: 2,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 14,
                  color: Colors.black,
                ),
                items: categories.map((category) {
                  return DropdownMenuItem<String>(
                      value: category, child: Text(category));
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedCategory = value;
                  });
                },
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Nama Produk',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(
                hintText: 'Masukkan Nama Produk',
                hintStyle: const TextStyle(fontSize: 14, color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Harga Jual',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: priceController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Masukkan Harga Jual',
                hintStyle: const TextStyle(fontSize: 14, color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Deskripsi Produk',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: descriptionController,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: 'Masukkan Deskripsi Produk',
                hintStyle: const TextStyle(fontSize: 14, color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Upload Gambar',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: _pickImage,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: const BorderSide(color: AppColors.border),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Row(
                  children: [
                    const Icon(
                      Icons.image,
                      color: Colors.black,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      imageFile == null ? 'Pilih Gambar' : 'Gambar Terpilih',
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.red,
                    border: Border.all(
                        color: Colors.red,
                        width: 1),
                    borderRadius:
                        BorderRadius.circular(8), 
                  ),
                  child: IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Hapus Produk'),
                            content: const Text(
                                'Apakah Anda yakin ingin menghapus produk ini?'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Batal'),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Hapus'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    icon: const Icon(Icons.delete, color: Colors.white),
                  ),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 126),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Update',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: BottomBar(),
      ),
    );
  }
}
