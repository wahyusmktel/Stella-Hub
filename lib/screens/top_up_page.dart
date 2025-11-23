import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../constants.dart';
import '../widgets/fade_in_slide.dart';

class TopUpPage extends StatefulWidget {
  const TopUpPage({super.key});

  @override
  State<TopUpPage> createState() => _TopUpPageState();
}

class _TopUpPageState extends State<TopUpPage> {
  final TextEditingController _amountController = TextEditingController();
  int _selectedAmount = 0;
  int _selectedMethodIndex = -1;

  // Pilihan Nominal Cepat
  final List<int> _quickAmounts = [10000, 20000, 50000, 100000, 150000, 200000];

  // Pilihan Metode Pembayaran
  final List<Map<String, dynamic>> _methods = [
    {"name": "Bank BNI (VA)", "icon": Icons.account_balance, "fee": 0},
    {"name": "Bank Mandiri (VA)", "icon": Icons.account_balance, "fee": 0},
    {"name": "Gopay / QRIS", "icon": Icons.qr_code, "fee": 1000},
    {"name": "Alfamart / Indomaret", "icon": Icons.store, "fee": 2500},
  ];

  // Helper Format Rupiah
  String _formatRupiah(int number) {
    return "Rp ${number.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}";
  }

  void _selectAmount(int amount) {
    setState(() {
      _selectedAmount = amount;
      _amountController.text = amount.toString();
    });
  }

  void _processTopUp() {
    if (_amountController.text.isEmpty ||
        int.tryParse(_amountController.text) == 0) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Masukkan nominal top up!")));
      return;
    }
    if (_selectedMethodIndex == -1) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Pilih metode pembayaran!")));
      return;
    }

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
    int amount = int.tryParse(_amountController.text) ?? 0;
    int fee = _methods[_selectedMethodIndex]['fee'];
    int total = amount + fee;

    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.receipt_long, color: Colors.orange, size: 60),
              const SizedBox(height: 16),
              const Text(
                "Menunggu Pembayaran",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                "Silakan selesaikan pembayaran sebesar ${_formatRupiah(total)}",
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "No. Virtual Account:",
                      style: TextStyle(fontSize: 12),
                    ),
                    Row(
                      children: const [
                        Text(
                          "8809 1234 5678",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 8),
                        Icon(Icons.copy, size: 14, color: Colors.grey),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context); // Tutup Dialog
                    Navigator.pop(context); // Kembali ke E-Kantin
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: kTelkomRed),
                  child: const Text(
                    "Tutup",
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
          "Isi Saldo",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. CARD SALDO SAAT INI
            FadeInSlide(
              delay: 0.1,
              child: Container(
                padding: const EdgeInsets.all(20),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "Saldo Saat Ini",
                      style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Rp 50.000",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // 2. INPUT NOMINAL
            const Text(
              "Pilih Nominal Top Up",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 12),

            // Grid Nominal Cepat
            FadeInSlide(
              delay: 0.2,
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 2.2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: _quickAmounts.length,
                itemBuilder: (context, index) {
                  int amount = _quickAmounts[index];
                  bool isSelected = _selectedAmount == amount;
                  return GestureDetector(
                    onTap: () => _selectAmount(amount),
                    child: Container(
                      decoration: BoxDecoration(
                        color: isSelected ? kTelkomRed : Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: isSelected ? kTelkomRed : Colors.grey.shade300,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          "${amount ~/ 1000}k",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: isSelected ? Colors.white : Colors.black87,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 16),

            // Input Manual
            FadeInSlide(
              delay: 0.3,
              child: TextField(
                controller: _amountController,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                onChanged: (value) {
                  setState(() {
                    _selectedAmount = int.tryParse(value) ?? 0;
                  });
                },
                decoration: InputDecoration(
                  labelText: "Nominal Lainnya",
                  prefixText: "Rp ",
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),

            // 3. METODE PEMBAYARAN
            const Text(
              "Metode Pembayaran",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 12),

            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _methods.length,
              itemBuilder: (context, index) {
                final method = _methods[index];
                bool isSelected = _selectedMethodIndex == index;
                return FadeInSlide(
                  delay: 0.4 + (index * 0.05),
                  child: GestureDetector(
                    onTap: () => setState(() => _selectedMethodIndex = index),
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isSelected ? kTelkomRed : Colors.transparent,
                          width: 1.5,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.05),
                            blurRadius: 5,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Icon(
                            method['icon'],
                            color: isSelected ? kTelkomRed : Colors.grey,
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  method['name'],
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                if (method['fee'] > 0)
                                  Text(
                                    "Biaya Admin: ${_formatRupiah(method['fee'])}",
                                    style: const TextStyle(
                                      fontSize: 10,
                                      color: Colors.grey,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          if (isSelected)
                            const Icon(Icons.check_circle, color: kTelkomRed),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: 30),

            // 4. TOMBOL PROSES
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _processTopUp,
                style: ElevatedButton.styleFrom(
                  backgroundColor: kTelkomRed,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  "KONFIRMASI & BAYAR",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
