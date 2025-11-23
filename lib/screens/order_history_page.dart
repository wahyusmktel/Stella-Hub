import 'package:flutter/material.dart';
import '../constants.dart';
import '../widgets/fade_in_slide.dart';
import 'reorder_page.dart';

class OrderHistoryPage extends StatefulWidget {
  const OrderHistoryPage({super.key});

  @override
  State<OrderHistoryPage> createState() => _OrderHistoryPageState();
}

class _OrderHistoryPageState extends State<OrderHistoryPage> {
  // Dummy Data Riwayat Order
  final List<Map<String, dynamic>> _orders = [
    {
      "id": "TRX-99210",
      "date": "Hari ini, 09:30",
      "total": 27000,
      "status": "Sedang Disiapkan", // Status aktif
      "items": ["1x Ayam Geprek Sambal Matah", "1x Es Teh Manis Jumbo"],
    },
    {
      "id": "TRX-88102",
      "date": "Kemarin, 10:00",
      "total": 13000,
      "status": "Selesai",
      "items": ["1x Soto Ayam Lamongan"],
    },
    {
      "id": "TRX-77291",
      "date": "20 Nov 2024",
      "total": 18000,
      "status": "Selesai",
      "items": ["1x Nasi Goreng Telkom", "1x Risoles Mayones"],
    },
    {
      "id": "TRX-66100",
      "date": "18 Nov 2024",
      "total": 15000,
      "status": "Dibatalkan",
      "items": ["1x Ayam Geprek Sambal Matah"],
    },
  ];

  String _formatRupiah(int number) {
    return "Rp ${number.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}";
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Sedang Disiapkan':
        return Colors.orange;
      case 'Selesai':
        return Colors.green;
      case 'Dibatalkan':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  void _showQRCode(String id) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Scan di Kantin",
                style: TextStyle(color: Colors.grey[600], fontSize: 12),
              ),
              const SizedBox(height: 8),
              Text(
                id,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 20),
              Container(
                height: 200,
                width: 200,
                color: Colors.black, // Placeholder QR Code
                child: const Center(
                  child: Icon(Icons.qr_code_2, color: Colors.white, size: 100),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Tunjukkan QR ini ke penjual untuk mengambil pesanan.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12),
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Tutup"),
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
          "Riwayat Pesanan",
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
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: _orders.length,
        itemBuilder: (context, index) {
          final order = _orders[index];
          final Color statusColor = _getStatusColor(order['status']);
          final bool isActive = order['status'] == 'Sedang Disiapkan';

          return FadeInSlide(
            delay: index * 0.1,
            child: Container(
              margin: const EdgeInsets.only(bottom: 16),
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
                border: isActive
                    ? Border.all(color: Colors.orange, width: 1.5)
                    : null,
              ),
              child: Column(
                children: [
                  // HEADER CARD
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              order['date'],
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              order['id'],
                              style: TextStyle(
                                color: Colors.grey[500],
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: statusColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            order['status'],
                            style: TextStyle(
                              color: statusColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 11,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const Divider(height: 1),

                  // BODY CARD (ITEM LIST)
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ...order['items']
                            .map<Widget>(
                              (item) => Padding(
                                padding: const EdgeInsets.only(bottom: 4),
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.restaurant,
                                      size: 14,
                                      color: Colors.grey,
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        item,
                                        style: const TextStyle(
                                          fontSize: 13,
                                          color: Colors.black87,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                            .toList(),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Total Bayar",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              _formatRupiah(order['total']),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: kTelkomRed,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // FOOTER ACTION (JIKA PERLU)
                  if (order['status'] != 'Dibatalkan')
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                      child: SizedBox(
                        width: double.infinity,
                        child: OutlinedButton(
                          onPressed: () {
                            if (isActive) {
                              _showQRCode(order['id']);
                            } else {
                              // --- UPDATE NAVIGASI REORDER ---
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ReorderPage(
                                    // Mengirim daftar item dari history ke halaman reorder
                                    // Pastikan tipe data sesuai (List<String>)
                                    originalItems: List<String>.from(
                                      order['items'],
                                    ),
                                  ),
                                ),
                              );
                            }
                          },
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(
                              color: isActive
                                  ? Colors.orange
                                  : Colors.grey.shade300,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text(
                            isActive ? "Lihat Kode QR (Ambil)" : "Pesan Lagi",
                            style: TextStyle(
                              color: isActive ? Colors.orange : Colors.black87,
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
