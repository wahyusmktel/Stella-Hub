import 'package:flutter/material.dart';
import '../constants.dart';
import '../widgets/fade_in_slide.dart';
import 'admin_chat_page.dart';

class HelpPage extends StatefulWidget {
  const HelpPage({super.key});

  @override
  State<HelpPage> createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {
  // Dummy Data FAQ
  final List<Map<String, String>> _faqs = [
    {
      "question": "Bagaimana cara mereset password?",
      "answer":
          "Untuk mereset password, silakan hubungi Wali Kelas atau Admin IT di ruang server. Pastikan Anda membawa Kartu Pelajar saat melapor.",
    },
    {
      "question": "Absensi gagal karena 'Lokasi Tidak Sesuai'?",
      "answer":
          "Pastikan GPS (Lokasi) di HP Anda sudah aktif dan izinkan aplikasi mengakses lokasi. Cobalah refresh GPS dengan membuka Google Maps sebentar, lalu kembali ke aplikasi ini.",
    },
    {
      "question": "Pembayaran SPP sudah transfer tapi status belum berubah?",
      "answer":
          "Sistem membutuhkan waktu 5-10 menit untuk verifikasi otomatis. Jika lebih dari 1 jam status belum berubah, silakan kirim bukti transfer melalui menu 'Lapor Masalah' atau chat Admin TU.",
    },
    {
      "question": "Bagaimana cara izin tidak masuk sekolah?",
      "answer":
          "Buka menu 'Lainnya' -> 'Perizinan'. Pilih tab 'Tidak Masuk', isi formulir, dan lampirkan foto surat dokter atau surat izin orang tua.",
    },
    {
      "question": "Apakah bisa memesan makanan kantin dari rumah?",
      "answer":
          "Fitur E-Kantin hanya dapat diakses saat jam sekolah (07.00 - 15.00 WIB) dan pengambilan pesanan harus dilakukan di area kantin sekolah.",
    },
  ];

  // Filter Search
  String _searchQuery = "";

  @override
  Widget build(BuildContext context) {
    final filteredFaqs = _faqs.where((faq) {
      return faq['question']!.toLowerCase().contains(
        _searchQuery.toLowerCase(),
      );
    }).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        title: const Text(
          "Pusat Bantuan",
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. HEADER & SEARCH
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(24),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  const Text(
                    "Apa yang bisa kami bantu?",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Cari topik permasalahanmu di bawah ini",
                    style: TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    onChanged: (val) {
                      setState(() {
                        _searchQuery = val;
                      });
                    },
                    decoration: InputDecoration(
                      hintText: "Cari kata kunci (cth: password, spp)...",
                      prefixIcon: const Icon(Icons.search, color: Colors.grey),
                      filled: true,
                      fillColor: const Color(0xFFF5F7FA),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // 2. CONTACT SUPPORT BUTTONS
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Expanded(
                    child: _buildContactCard(
                      "Chat Admin",
                      Icons.chat,
                      Colors.green,
                      () {
                        // Navigasi ke Halaman Chat Admin
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AdminChatPage(),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildContactCard(
                      "Email IT",
                      Icons.email,
                      Colors.blue,
                      () {},
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildContactCard(
                      "Call Center",
                      Icons.call,
                      Colors.orange,
                      () {},
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // 3. FAQ LIST
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: const Text(
                "Pertanyaan Umum (FAQ)",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
            const SizedBox(height: 12),

            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: filteredFaqs.length,
              itemBuilder: (context, index) {
                final faq = filteredFaqs[index];
                return FadeInSlide(
                  delay: index * 0.1,
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: Theme(
                      data: Theme.of(
                        context,
                      ).copyWith(dividerColor: Colors.transparent),
                      child: ExpansionTile(
                        title: Text(
                          faq['question']!,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: Colors.black87,
                          ),
                        ),
                        iconColor: kTelkomRed,
                        collapsedIconColor: Colors.grey,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                            child: Text(
                              faq['answer']!,
                              style: TextStyle(
                                color: Colors.grey[700],
                                height: 1.5,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),

            // Empty State jika pencarian tidak ditemukan
            if (filteredFaqs.isEmpty)
              Padding(
                padding: const EdgeInsets.all(40.0),
                child: Center(
                  child: Column(
                    children: const [
                      Icon(Icons.search_off, size: 50, color: Colors.grey),
                      SizedBox(height: 10),
                      Text(
                        "Topik tidak ditemukan",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildContactCard(
    String title,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: () {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Menghubungi $title...")));
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.05),
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 28),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
