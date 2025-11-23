import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Untuk fitur Copy Paste
import '../constants.dart';
import '../widgets/fade_in_slide.dart';

class SppPage extends StatefulWidget {
  const SppPage({super.key});

  @override
  State<SppPage> createState() => _SppPageState();
}

class _SppPageState extends State<SppPage> {
  // Dummy Data Tagihan SPP
  final List<Map<String, dynamic>> _payments = [
    {
      "month": "Desember 2024",
      "amount": 350000,
      "status": "Belum Lunas",
      "date": "-",
    },
    {
      "month": "November 2024",
      "amount": 350000,
      "status": "Lunas",
      "date": "10 Nov 2024",
    },
    {
      "month": "Oktober 2024",
      "amount": 350000,
      "status": "Lunas",
      "date": "05 Okt 2024",
    },
    {
      "month": "September 2024",
      "amount": 350000,
      "status": "Lunas",
      "date": "08 Sep 2024",
    },
    {
      "month": "Agustus 2024",
      "amount": 350000,
      "status": "Lunas",
      "date": "10 Agt 2024",
    },
  ];

  // Helper format rupiah sederhana
  String _formatRupiah(int number) {
    return "Rp ${number.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}";
  }

  // Hitung Total Tagihan
  int get _totalBill {
    return _payments
        .where((item) => item['status'] == 'Belum Lunas')
        .fold(0, (sum, item) => sum + (item['amount'] as int));
  }

  void _showPaymentModal() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Pilih Metode Pembayaran",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              _buildPaymentOption(
                "Virtual Account BNI",
                "8809 1234 5678 9000",
                "assets/bni.png",
              ), // Asset dummy
              const SizedBox(height: 16),
              _buildPaymentOption(
                "QRIS (Gopay/OVO/Dana)",
                "Scan Kode QR",
                "assets/qris.png",
              ),
              const SizedBox(height: 24),
            ],
          ),
        );
      },
    );
  }

  Widget _buildPaymentOption(String title, String subtitle, String iconPath) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const Icon(Icons.payment, color: kTelkomRed), // Placeholder icon
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  subtitle,
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),
          const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        title: const Text(
          "Pembayaran SPP",
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 1. BILL CARD (TAGIHAN)
            FadeInSlide(
              delay: 0.1,
              child: Container(
                margin: const EdgeInsets.all(20),
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [kTelkomRed, kTelkomDarkRed],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: kTelkomRed.withOpacity(0.4),
                      blurRadius: 15,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    const Text(
                      "Total Tagihan Anda",
                      style: TextStyle(color: Colors.white70, fontSize: 14),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _formatRupiah(_totalBill),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Icon(
                            Icons.warning_amber_rounded,
                            color: Colors.white,
                            size: 16,
                          ),
                          SizedBox(width: 8),
                          Text(
                            "Jatuh tempo: 10 Des 2024",
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _showPaymentModal,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: kTelkomRed,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          "BAYAR SEKARANG",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // 2. HEADER LIST
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Riwayat Pembayaran",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Icon(Icons.filter_list, color: Colors.grey[600]),
                ],
              ),
            ),
            const SizedBox(height: 10),

            // 3. LIST ITEMS
            ListView.builder(
              shrinkWrap: true, // Agar bisa dalam SingleChildScrollView
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: _payments.length,
              itemBuilder: (context, index) {
                final item = _payments[index];
                bool isPaid = item['status'] == 'Lunas';
                return FadeInSlide(
                  delay: 0.2 + (index * 0.1),
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                      border: Border(
                        left: BorderSide(
                          color: isPaid ? Colors.green : kTelkomRed,
                          width: 4,
                        ),
                      ),
                    ),
                    child: Row(
                      children: [
                        // Icon Bulat
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: isPaid
                                ? Colors.green.withOpacity(0.1)
                                : kTelkomRed.withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            isPaid ? Icons.check : Icons.priority_high,
                            color: isPaid ? Colors.green : kTelkomRed,
                            size: 20,
                          ),
                        ),
                        const SizedBox(width: 16),

                        // Detail
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item['month'],
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 4),
                              if (isPaid)
                                Text(
                                  "Dibayar: ${item['date']}",
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                )
                              else
                                const Text(
                                  "Belum Dibayar",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: kTelkomRed,
                                  ),
                                ),
                            ],
                          ),
                        ),

                        // Amount
                        Text(
                          _formatRupiah(item['amount']),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: isPaid ? Colors.black : kTelkomRed,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
