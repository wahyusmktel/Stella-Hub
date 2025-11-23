import 'package:flutter/material.dart';
import '../constants.dart';
import 'schedule_page.dart'; // PENTING: Import halaman jadwal biar bisa dipanggil
import 'grades_page.dart';
import 'attendance_page.dart';
import 'spp_page.dart';
import 'modul_page.dart';
import 'teacher_page.dart';
import 'bk_page.dart';
import 'more_menu_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(
        0xFFF5F7FA,
      ), // Background abu-abu muda bersih
      body: SingleChildScrollView(
        child: Column(
          children: [
            // =========================================
            // 1. HEADER PROFILE (MERAH TELKOM)
            // =========================================
            Container(
              padding: const EdgeInsets.only(
                top: 60,
                left: 24,
                right: 24,
                bottom: 30,
              ),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [kTelkomRed, kTelkomDarkRed],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Column(
                children: [
                  // Baris Profil & Notifikasi
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(2),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: const CircleAvatar(
                          radius: 26,
                          backgroundImage: NetworkImage(
                            'https://i.pravatar.cc/150?img=12',
                          ), // Foto Profil
                          backgroundColor: Colors.grey,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "Halo, Siswa Telkom!",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "XI RPL 2 | 54221123",
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.notifications_outlined,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),

                  // Statistik Ringkas (Floating Card)
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildStatItem("Hadir", "98%", Colors.green),
                        Container(
                          height: 30,
                          width: 1,
                          color: Colors.grey[200],
                        ),
                        _buildStatItem("Nilai", "88.5", Colors.orange),
                        Container(
                          height: 30,
                          width: 1,
                          color: Colors.grey[200],
                        ),
                        _buildStatItem("Sanksi", "0", kTelkomRed),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // =========================================
            // 2. MENU GRID (TOMBOL-TOMBOL UTAMA)
            // =========================================
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Menu Utama",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 16),

                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 4,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 12,
                    childAspectRatio: 0.85,
                    children: [
                      // --- MENU 1: JADWAL (ADA NAVIGASINYA) ---
                      _buildMenuItem(
                        context,
                        Icons.calendar_month,
                        "Jadwal",
                        Colors.blue,
                        onTap: () {
                          // Pindah ke Halaman Jadwal
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SchedulePage(),
                            ),
                          );
                        },
                      ),

                      // --- MENU NILAI (SUDAH DI-UPDATE) ---
                      _buildMenuItem(
                        context,
                        Icons.assignment,
                        "Nilai",
                        Colors.orange,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const GradesPage(),
                            ),
                          );
                        },
                      ),

                      // --- MENU ABSENSI (SUDAH DI-UPDATE) ---
                      _buildMenuItem(
                        context,
                        Icons.fingerprint, // Icon Sidik Jari
                        "Absensi",
                        Colors.green,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const AttendancePage(),
                            ),
                          );
                        },
                      ),

                      // --- MENU SPP (SUDAH DI-UPDATE) ---
                      _buildMenuItem(
                        context,
                        Icons.payment,
                        "SPP",
                        Colors.purple,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SppPage(),
                            ),
                          );
                        },
                      ),

                      // --- MENU MODUL (SUDAH DI-UPDATE) ---
                      _buildMenuItem(
                        context,
                        Icons.book, // Icon Buku
                        "Modul",
                        Colors.teal,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ModulPage(),
                            ),
                          );
                        },
                      ),

                      // --- MENU GURU (SUDAH DI-UPDATE) ---
                      _buildMenuItem(
                        context,
                        Icons.school, // Icon Topi Toga/Sekolah
                        "Guru",
                        Colors.indigo,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const TeacherPage(),
                            ),
                          );
                        },
                      ),

                      // --- MENU BK (SUDAH DI-UPDATE) ---
                      _buildMenuItem(
                        context,
                        Icons.support_agent, // Icon Support/Headset
                        "BK",
                        Colors.pink,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const BkPage(),
                            ),
                          );
                        },
                      ),

                      // --- MENU LAINNYA (SUDAH DI-UPDATE) ---
                      _buildMenuItem(
                        context,
                        Icons.grid_view,
                        "Lainnya",
                        Colors.grey,
                        onTap: () {
                          // Navigasi ke Halaman Menu Lainnya
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const MoreMenuPage(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // =========================================
            // 3. PENGUMUMAN / INFO TERBARU
            // =========================================
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Info Terbaru",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          "Lihat Semua",
                          style: TextStyle(color: kTelkomRed),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  _buildNewsCard(
                    "Ujian Akhir Semester",
                    "Jadwal UAS akan dimulai pada tanggal 10 Desember...",
                    "2 Jam lalu",
                  ),
                  _buildNewsCard(
                    "Lomba Web Design",
                    "Pendaftaran lomba web design tingkat provinsi telah dibuka.",
                    "1 Hari lalu",
                  ),
                  _buildNewsCard(
                    "Libur Nasional",
                    "Sekolah libur memperingati hari besar nasional.",
                    "3 Hari lalu",
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),

      // =========================================
      // 4. BOTTOM NAVIGATION BAR
      // =========================================
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: kTelkomRed,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Beranda"),
          BottomNavigationBarItem(
            icon: Icon(Icons.class_outlined),
            label: "Kelas",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble_outline),
            label: "Pesan",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: "Profil",
          ),
        ],
      ),
    );
  }

  // =========================================
  // HELPER WIDGETS (Fungsi-fungsi pembantu)
  // =========================================

  Widget _buildStatItem(String label, String value, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: color,
          ),
        ),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
      ],
    );
  }

  // UPDATE: Menambahkan parameter 'onTap' agar bisa diklik
  Widget _buildMenuItem(
    BuildContext context,
    IconData icon,
    String label,
    Color color, {
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap, // Menjalankan fungsi ketika diklik
      borderRadius: BorderRadius.circular(12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(fontSize: 12, color: Colors.black87),
            textAlign: TextAlign.center,
            maxLines: 1,
          ),
        ],
      ),
    );
  }

  Widget _buildNewsCard(String title, String desc, String time) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.red.shade50,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.campaign, color: kTelkomRed),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  desc,
                  style: const TextStyle(fontSize: 13, color: Colors.grey),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Text(
                  time,
                  style: const TextStyle(fontSize: 11, color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
