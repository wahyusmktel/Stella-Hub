import 'package:flutter/material.dart';
import '../constants.dart';
import '../widgets/fade_in_slide.dart';

class EkskulPage extends StatefulWidget {
  const EkskulPage({super.key});

  @override
  State<EkskulPage> createState() => _EkskulPageState();
}

class _EkskulPageState extends State<EkskulPage> {
  int _selectedCategoryIndex = 0;
  final List<String> _categories = [
    "Semua",
    "Olahraga",
    "Seni & Musik",
    "Teknologi",
    "Organisasi",
  ];

  // Dummy Data Ekskul
  final List<Map<String, dynamic>> _ekskuls = [
    {
      "name": "Basket Telkom",
      "category": "Olahraga",
      "schedule": "Senin & Kamis, 16:00",
      "members": 45,
      "coach": "Pak Denny",
      "icon": Icons.sports_basketball,
      "color": Colors.orange,
    },
    {
      "name": "Telkom Futsal",
      "category": "Olahraga",
      "schedule": "Jumat, 15:30",
      "members": 60,
      "coach": "Pak Budi",
      "icon": Icons.sports_soccer,
      "color": Colors.blue,
    },
    {
      "name": "Coding Club",
      "category": "Teknologi",
      "schedule": "Rabu, 14:00",
      "members": 80,
      "coach": "Pak Asep",
      "icon": Icons.terminal,
      "color": Colors.indigo,
    },
    {
      "name": "Paduan Suara",
      "category": "Seni & Musik",
      "schedule": "Selasa, 15:00",
      "members": 30,
      "coach": "Bu Rina",
      "icon": Icons.mic_external_on,
      "color": Colors.purple,
    },
    {
      "name": "Paskibra",
      "category": "Organisasi",
      "schedule": "Sabtu, 08:00",
      "members": 50,
      "coach": "Kak Ridwan",
      "icon": Icons.flag,
      "color": Colors.red,
    },
    {
      "name": "English Club",
      "category": "Organisasi",
      "schedule": "Kamis, 14:00",
      "members": 25,
      "coach": "Miss Sarah",
      "icon": Icons.language,
      "color": Colors.teal,
    },
    {
      "name": "Robotika",
      "category": "Teknologi",
      "schedule": "Jumat, 13:30",
      "members": 20,
      "coach": "Pak Dedi",
      "icon": Icons.precision_manufacturing,
      "color": Colors.blueGrey,
    },
    {
      "name": "Tari Tradisional",
      "category": "Seni & Musik",
      "schedule": "Rabu, 15:00",
      "members": 15,
      "coach": "Bu Siti",
      "icon": Icons.emoji_people,
      "color": Colors.pink,
    },
  ];

  // Menampilkan Detail & Form Daftar
  void _showDetailModal(Map<String, dynamic> item) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.6,
          minChildSize: 0.4,
          maxChildSize: 0.9,
          expand: false,
          builder: (context, scrollController) {
            return SingleChildScrollView(
              controller: scrollController,
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 50,
                      height: 5,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Header Icon & Nama
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: (item['color'] as Color).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Icon(
                          item['icon'],
                          color: item['color'],
                          size: 40,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item['name'],
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              item['category'],
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 30),

                  // Info Grid
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    childAspectRatio: 2.5,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    children: [
                      _buildInfoCard(
                        Icons.calendar_today,
                        "Jadwal",
                        item['schedule'],
                      ),
                      _buildInfoCard(Icons.person, "Pembina", item['coach']),
                      _buildInfoCard(
                        Icons.groups,
                        "Anggota",
                        "${item['members']} Siswa",
                      ),
                      _buildInfoCard(
                        Icons.location_on,
                        "Lokasi",
                        "Lapangan/Lab",
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),
                  const Text(
                    "Deskripsi",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Bergabunglah dengan ${item['name']} untuk mengembangkan bakat dan minatmu. Kegiatan ini sangat cocok untuk melatih kedisiplinan, kerjasama tim, dan prestasi non-akademik.",
                    style: TextStyle(color: Colors.grey[600], height: 1.5),
                  ),

                  const SizedBox(height: 30),

                  // Tombol Daftar
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        _showSuccessJoin(item['name']);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kTelkomRed,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        "GABUNG SEKARANG",
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
            );
          },
        );
      },
    );
  }

  Widget _buildInfoCard(IconData icon, String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F7FA),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.grey[700]),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  label,
                  style: const TextStyle(fontSize: 10, color: Colors.grey),
                ),
                Text(
                  value,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showSuccessJoin(String name) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle, color: Colors.white),
            const SizedBox(width: 12),
            Expanded(child: Text("Berhasil mendaftar ke $name!")),
          ],
        ),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Filter Logic
    final filteredEkskuls = _selectedCategoryIndex == 0
        ? _ekskuls
        : _ekskuls
              .where(
                (item) =>
                    item['category'] == _categories[_selectedCategoryIndex],
              )
              .toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        title: const Text(
          "Ekstrakurikuler",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          // 1. SEARCH BAR
          Container(
            padding: const EdgeInsets.all(20),
            color: Colors.white,
            child: TextField(
              decoration: InputDecoration(
                hintText: "Cari ekskul (Basket, Musik...)",
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                filled: true,
                fillColor: Colors.grey.shade100,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 0,
                  horizontal: 16,
                ),
              ),
            ),
          ),

          // 2. KATEGORI
          Container(
            height: 50,
            color: Colors.white,
            padding: const EdgeInsets.only(bottom: 10),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: _categories.length,
              itemBuilder: (context, index) {
                bool isSelected = _selectedCategoryIndex == index;
                return GestureDetector(
                  onTap: () => setState(() => _selectedCategoryIndex = index),
                  child: Container(
                    margin: const EdgeInsets.only(right: 10),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected ? kTelkomRed : Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      _categories[index],
                      style: TextStyle(
                        color: isSelected ? Colors.white : Colors.grey.shade600,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 10),

          // 3. LIST GRID
          Expanded(
            child: filteredEkskuls.isEmpty
                ? const Center(child: Text("Tidak ada ekskul di kategori ini"))
                : GridView.builder(
                    padding: const EdgeInsets.all(20),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.85,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                        ),
                    itemCount: filteredEkskuls.length,
                    itemBuilder: (context, index) {
                      final item = filteredEkskuls[index];
                      return FadeInSlide(
                        delay: 0.1 + (index * 0.05),
                        child: GestureDetector(
                          onTap: () => _showDetailModal(item),
                          child: Container(
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
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: (item['color'] as Color).withOpacity(
                                      0.1,
                                    ),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    item['icon'],
                                    color: item['color'],
                                    size: 40,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  item['name'],
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  item['schedule'],
                                  style: const TextStyle(
                                    fontSize: 11,
                                    color: Colors.grey,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 12),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.grey.shade200,
                                    ),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: const Text(
                                    "Lihat Detail",
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
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
          ),
        ],
      ),
    );
  }
}
