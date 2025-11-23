import 'package:flutter/material.dart';
import '../constants.dart';
import '../widgets/fade_in_slide.dart';
import 'report_bullying_page.dart';
import 'aptitude_test_page.dart';

class BkPage extends StatefulWidget {
  const BkPage({super.key});

  @override
  State<BkPage> createState() => _BkPageState();
}

class _BkPageState extends State<BkPage> {
  // Dummy Data History (Campuran Konseling & Pelanggaran)
  final List<Map<String, dynamic>> _history = [
    {
      "title": "Konseling Karir & Kuliah",
      "date": "20 Nov 2024",
      "type": "consultation", // consultation / violation
      "status": "Selesai",
      "points": 0,
    },
    {
      "title": "Keterlambatan Upacara",
      "date": "10 Nov 2024",
      "type": "violation",
      "status": "Diproses",
      "points": -5,
    },
    {
      "title": "Konseling Masalah Belajar",
      "date": "05 Okt 2024",
      "type": "consultation",
      "status": "Selesai",
      "points": 0,
    },
    {
      "title": "Atribut Seragam Tidak Lengkap",
      "date": "01 Sep 2024",
      "type": "violation",
      "status": "Selesai",
      "points": -2,
    },
  ];

  void _showBookingModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 24,
            right: 24,
            top: 24,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Ajukan Sesi Konseling",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              const TextField(
                decoration: InputDecoration(
                  labelText: "Topik Konseling",
                  hintText: "Misal: Konsultasi Jurusan Kuliah",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              const TextField(
                decoration: InputDecoration(
                  labelText: "Guru BK Tujuan (Opsional)",
                  hintText: "Pilih Guru...",
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.arrow_drop_down),
                ),
              ),
              const SizedBox(height: 16),
              const TextField(
                decoration: InputDecoration(
                  labelText: "Tanggal & Jam",
                  hintText: "Pilih Waktu",
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.calendar_today),
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Permintaan konseling terkirim!"),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: kTelkomRed),
                  child: const Text(
                    "AJUKAN SEKARANG",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        title: const Text(
          "Bimbingan Konseling",
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
            // 1. CARD POIN KEDISIPLINAN
            FadeInSlide(
              delay: 0.1,
              child: Container(
                margin: const EdgeInsets.all(20),
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFF2C3E50),
                      Color(0xFF4CA1AF),
                    ], // Warna Biru-Teal Tenang
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blueGrey.withOpacity(0.4),
                      blurRadius: 15,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "Poin Kedisiplinan",
                          style: TextStyle(color: Colors.white70, fontSize: 14),
                        ),
                        SizedBox(height: 8),
                        Text(
                          "93/100",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          "Status: Baik",
                          style: TextStyle(
                            color: Colors.lightGreenAccent,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    // Circular Indicator
                    SizedBox(
                      height: 70,
                      width: 70,
                      child: Stack(
                        children: [
                          const Center(
                            child: Icon(
                              Icons.shield,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                          CircularProgressIndicator(
                            value: 0.93,
                            strokeWidth: 6,
                            backgroundColor: Colors.white24,
                            valueColor: const AlwaysStoppedAnimation<Color>(
                              Colors.lightGreenAccent,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // 2. MENU GRID (QUICK ACTIONS)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Expanded(
                    child: _buildActionCard(
                      "Ajukan\nKonseling",
                      Icons.chat,
                      Colors.blue,
                      _showBookingModal,
                    ),
                  ),
                  const SizedBox(width: 12),
                  // --- UPDATE TOMBOL INI ---
                  Expanded(
                    child: _buildActionCard(
                      "Lapor\nBullying",
                      Icons.campaign,
                      Colors.orange,
                      () {
                        // Navigasi ke Halaman Lapor Bullying
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ReportBullyingPage(),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  // --- MENU TES MINAT BAKAT (UPDATE INI) ---
                  Expanded(
                    child: _buildActionCard(
                      "Tes Minat\nBakat",
                      Icons.psychology,
                      Colors.purple,
                      () {
                        // Navigasi ke Halaman Tes
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AptitudeTestPage(),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // 3. HEADER RIWAYAT
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Riwayat Aktivitas",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Lihat Semua",
                    style: TextStyle(color: Colors.grey[600], fontSize: 12),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            // 4. LIST RIWAYAT
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: _history.length,
              itemBuilder: (context, index) {
                final item = _history[index];
                bool isViolation = item['type'] == 'violation';

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
                          color: isViolation ? Colors.red : Colors.blue,
                          width: 4,
                        ),
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: isViolation
                                ? Colors.red.withOpacity(0.1)
                                : Colors.blue.withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            isViolation
                                ? Icons.warning_amber
                                : Icons.people_outline,
                            color: isViolation ? Colors.red : Colors.blue,
                            size: 20,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item['title'],
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                item['date'],
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            if (isViolation)
                              Text(
                                "${item['points']} Poin",
                                style: const TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            const SizedBox(height: 4),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade100,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                item['status'],
                                style: const TextStyle(
                                  fontSize: 10,
                                  color: Colors.black54,
                                ),
                              ),
                            ),
                          ],
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

  Widget _buildActionCard(
    String title,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 100,
        padding: const EdgeInsets.all(12),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(icon, color: color, size: 30),
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
            ),
          ],
        ),
      ),
    );
  }
}
