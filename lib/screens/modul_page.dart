import 'package:flutter/material.dart';
import '../constants.dart';
import '../widgets/fade_in_slide.dart';

class ModulPage extends StatefulWidget {
  const ModulPage({super.key});

  @override
  State<ModulPage> createState() => _ModulPageState();
}

class _ModulPageState extends State<ModulPage> {
  int _selectedCategoryIndex = 0;
  final List<String> _categories = [
    "Semua",
    "Produktif",
    "Umum",
    "Video Pembelajaran",
  ];

  // Dummy Data Modul
  final List<Map<String, dynamic>> _modules = [
    {
      "title": "Modul Pemrograman Web Dasar",
      "author": "Pak Asep",
      "type": "pdf",
      "size": "2.5 MB",
      "category": "Produktif",
      "date": "20 Nov 2024",
    },
    {
      "title": "Tutorial Instalasi Flutter",
      "author": "Bu Susi",
      "type": "video",
      "size": "150 MB",
      "category": "Produktif",
      "date": "18 Nov 2024",
    },
    {
      "title": "Materi Bahasa Indonesia Bab 3",
      "author": "Pak Budi",
      "type": "pdf",
      "size": "1.2 MB",
      "category": "Umum",
      "date": "15 Nov 2024",
    },
    {
      "title": "E-Book Basis Data MySQL",
      "author": "Tim Kurikulum",
      "type": "pdf",
      "size": "5.8 MB",
      "category": "Produktif",
      "date": "10 Nov 2024",
    },
    {
      "title": "Rumus Fisika Terapan",
      "author": "Bu Rina",
      "type": "pdf",
      "size": "800 KB",
      "category": "Umum",
      "date": "05 Nov 2024",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        title: const Text(
          "E-Modul & Materi",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.bookmark_outline, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // 1. SEARCH BAR
          Container(
            padding: const EdgeInsets.all(20),
            color: Colors.white,
            child: TextField(
              decoration: InputDecoration(
                hintText: "Cari judul buku atau materi...",
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

          // 2. KATEGORI (CHIPS)
          Container(
            height: 50,
            color: Colors.white,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: _categories.length,
              itemBuilder: (context, index) {
                bool isSelected = _selectedCategoryIndex == index;
                return GestureDetector(
                  onTap: () => setState(() => _selectedCategoryIndex = index),
                  child: Container(
                    margin: const EdgeInsets.only(right: 12, bottom: 10),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
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
                        fontSize: 13,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 10),

          // 3. LIST MODUL
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: _modules.length,
              itemBuilder: (context, index) {
                final item = _modules[index];

                // Filter logika sederhana (Hanya visualisasi, filter asli butuh logic list)
                if (_selectedCategoryIndex != 0 &&
                    item['category'] != _categories[_selectedCategoryIndex] &&
                    _categories[_selectedCategoryIndex] !=
                        "Video Pembelajaran") {
                  return const SizedBox.shrink(); // Sembunyikan jika kategori tidak cocok
                }
                // Khusus filter Video
                if (_selectedCategoryIndex == 3 && item['type'] != 'video') {
                  return const SizedBox.shrink();
                }

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
                        // Icon File Type
                        Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            color: item['type'] == 'pdf'
                                ? Colors.red.shade50
                                : Colors.blue.shade50,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            item['type'] == 'pdf'
                                ? Icons.picture_as_pdf
                                : Icons.play_circle_fill,
                            color: item['type'] == 'pdf'
                                ? Colors.red
                                : Colors.blue,
                            size: 28,
                          ),
                        ),
                        const SizedBox(width: 16),

                        // Detail Info
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item['title'],
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                "${item['author']} • ${item['date']}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey.shade500,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 6,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade100,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  item['size'],
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Download Button
                        IconButton(
                          icon: const Icon(
                            Icons.cloud_download_outlined,
                            color: kTelkomRed,
                          ),
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Mengunduh ${item['title']}..."),
                                duration: const Duration(seconds: 1),
                              ),
                            );
                          },
                        ),
                      ],
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
