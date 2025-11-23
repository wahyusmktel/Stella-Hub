import 'package:flutter/material.dart';
import '../constants.dart';
import '../widgets/fade_in_slide.dart';

class ReorderPage extends StatefulWidget {
  final List<String>
  originalItems; // Menerima data ["1x Nasi Goreng", "1x Es Teh"]

  const ReorderPage({super.key, required this.originalItems});

  @override
  State<ReorderPage> createState() => _ReorderPageState();
}

class _ReorderPageState extends State<ReorderPage> {
  List<Map<String, dynamic>> _cartItems = [];

  @override
  void initState() {
    super.initState();
    _parseItems();
  }

  // Fungsi untuk mengubah String "1x Nasi Goreng" menjadi Data Object
  void _parseItems() {
    for (var itemStr in widget.originalItems) {
      // Logic sederhana memisahkan jumlah dan nama
      // Asumsi format string selalu "1x Nama Barang"
      try {
        List<String> parts = itemStr.split('x');
        int qty = int.parse(parts[0].trim());
        String name = parts[1].trim();

        // Simulasi harga (karena data history sebelumnya tidak simpan harga per item)
        int price = _getDummyPrice(name);

        _cartItems.add({"name": name, "qty": qty, "price": price});
      } catch (e) {
        // Fallback jika format error
        _cartItems.add({"name": itemStr, "qty": 1, "price": 10000});
      }
    }
  }

  // Dummy Price Database
  int _getDummyPrice(String name) {
    if (name.contains("Nasi Goreng")) return 12000;
    if (name.contains("Ayam Geprek")) return 15000;
    if (name.contains("Soto")) return 13000;
    if (name.contains("Es Teh")) return 5000;
    if (name.contains("Risoles")) return 6000;
    return 10000; // Harga default
  }

  void _incrementQty(int index) {
    setState(() {
      _cartItems[index]['qty']++;
    });
  }

  void _decrementQty(int index) {
    setState(() {
      if (_cartItems[index]['qty'] > 1) {
        _cartItems[index]['qty']--;
      } else {
        // Opsi hapus item jika qty jadi 0
        _cartItems.removeAt(index);
      }
    });
  }

  int get _totalPrice {
    return _cartItems.fold(
      0,
      (sum, item) => sum + ((item['price'] as int) * (item['qty'] as int)),
    );
  }

  String _formatRupiah(int number) {
    return "Rp ${number.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}";
  }

  void _processOrder() {
    // Simulasi Loading
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) =>
          const Center(child: CircularProgressIndicator(color: kTelkomRed)),
    );

    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pop(context); // Tutup loading
      _showSuccessDialog();
    });
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.check_circle, color: Colors.green, size: 60),
              const SizedBox(height: 16),
              const Text(
                "Pesanan Ulang Berhasil!",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                "Pesananmu sedang diproses ulang. Mohon tunggu notifikasi selanjutnya.",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context); // Tutup Dialog
                    Navigator.pop(context); // Kembali ke History
                    Navigator.pop(
                      context,
                    ); // Kembali ke E-Kantin (Opsional, tergantung flow)
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: kTelkomRed),
                  child: const Text(
                    "Oke",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        title: const Text(
          "Konfirmasi Pesanan",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: _cartItems.isEmpty
                ? const Center(child: Text("Keranjang Kosong"))
                : ListView.builder(
                    padding: const EdgeInsets.all(20),
                    itemCount: _cartItems.length,
                    itemBuilder: (context, index) {
                      final item = _cartItems[index];
                      return FadeInSlide(
                        delay: index * 0.1,
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 16),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.05),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              // Placeholder Gambar
                              Container(
                                height: 60,
                                width: 60,
                                decoration: BoxDecoration(
                                  color: Colors.orange.shade50,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Icon(
                                  Icons.fastfood,
                                  color: Colors.orange,
                                ),
                              ),
                              const SizedBox(width: 16),

                              // Detail Item
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item['name'],
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      _formatRupiah(item['price']),
                                      style: TextStyle(
                                        color: Colors.grey[600],
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              // Quantity Control
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade100,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Row(
                                  children: [
                                    IconButton(
                                      icon: const Icon(
                                        Icons.remove,
                                        size: 16,
                                        color: kTelkomRed,
                                      ),
                                      onPressed: () => _decrementQty(index),
                                      constraints: const BoxConstraints(
                                        minWidth: 32,
                                        minHeight: 32,
                                      ),
                                      padding: EdgeInsets.zero,
                                    ),
                                    Text(
                                      "${item['qty']}",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    IconButton(
                                      icon: const Icon(
                                        Icons.add,
                                        size: 16,
                                        color: kTelkomRed,
                                      ),
                                      onPressed: () => _incrementQty(index),
                                      constraints: const BoxConstraints(
                                        minWidth: 32,
                                        minHeight: 32,
                                      ),
                                      padding: EdgeInsets.zero,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),

          // BOTTOM SECTION (TOTAL & CHECKOUT)
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(24),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 20,
                  offset: const Offset(0, -5),
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Total Pembayaran",
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      _formatRupiah(_totalPrice),
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: kTelkomRed,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _cartItems.isNotEmpty ? _processOrder : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kTelkomRed,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      "PESAN SEKARANG",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
