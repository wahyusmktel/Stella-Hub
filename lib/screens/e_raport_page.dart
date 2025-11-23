import 'package:flutter/material.dart';
import '../constants.dart';
import '../widgets/fade_in_slide.dart';

class ERaportPage extends StatefulWidget {
  const ERaportPage({super.key});

  @override
  State<ERaportPage> createState() => _ERaportPageState();
}

class _ERaportPageState extends State<ERaportPage> {
  String _selectedSemester = "Semester 3 (Ganjil 2024)";
  final List<String> _semesterOptions = [
    "Semester 3 (Ganjil 2024)",
    "Semester 2 (Genap 2023)",
    "Semester 1 (Ganjil 2023)",
  ];

  // Dummy Data Nilai Rapor (Format SMK: Pengetahuan & Keterampilan)
  final List<Map<String, dynamic>> _scores = [
    {
      "subject": "Pendidikan Agama",
      "kkm": 75,
      "p_score": 88, // Pengetahuan
      "p_pred": "B",
      "k_score": 90, // Keterampilan
      "k_pred": "A",
    },
    {
      "subject": "PPKN",
      "kkm": 75,
      "p_score": 85,
      "p_pred": "B",
      "k_score": 86,
      "k_pred": "B",
    },
    {
      "subject": "Bahasa Indonesia",
      "kkm": 75,
      "p_score": 92,
      "p_pred": "A",
      "k_score": 95,
      "k_pred": "A",
    },
    {
      "subject": "Matematika",
      "kkm": 70,
      "p_score": 78,
      "p_pred": "C",
      "k_score": 80,
      "k_pred": "B",
    },
    {
      "subject": "Pemrograman Web (Produktif)",
      "kkm": 78,
      "p_score": 95,
      "p_pred": "A",
      "k_score": 98,
      "k_pred": "A",
    },
    {
      "subject": "Basis Data (Produktif)",
      "kkm": 78,
      "p_score": 90,
      "p_pred": "B",
      "k_score": 92,
      "k_pred": "A",
    },
    {
      "subject": "Produk Kreatif & KWU",
      "kkm": 75,
      "p_score": 88,
      "p_pred": "B",
      "k_score": 90,
      "k_pred": "A",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        title: const Text(
          "E-Raport Siswa",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.download_rounded, color: kTelkomRed),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Mengunduh File PDF Rapor...")),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. SEMESTER DROPDOWN
            FadeInSlide(
              delay: 0.1,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _selectedSemester,
                    isExpanded: true,
                    icon: const Icon(
                      Icons.keyboard_arrow_down,
                      color: kTelkomRed,
                    ),
                    items: _semesterOptions.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        _selectedSemester = newValue!;
                      });
                    },
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // 2. HEADER SUMMARY (Warna Gradient)
            FadeInSlide(
              delay: 0.2,
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [kTelkomRed, kTelkomDarkRed],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: kTelkomRed.withOpacity(0.4),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildSummaryItem("Rata-rata", "88.5"),
                    Container(width: 1, height: 40, color: Colors.white30),
                    _buildSummaryItem("Peringkat", "3 / 32"),
                    Container(width: 1, height: 40, color: Colors.white30),
                    _buildSummaryItem("Sikap", "Baik"),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // 3. TABEL NILAI HEADER
            Row(
              children: [
                const Expanded(
                  flex: 4,
                  child: Text(
                    "Mata Pelajaran",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Center(
                    child: Text(
                      "Pengetahuan",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Center(
                    child: Text(
                      "Keterampilan",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),

            // 4. LIST NILAI RAPOR
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _scores.length,
              itemBuilder: (context, index) {
                final item = _scores[index];
                return FadeInSlide(
                  delay: 0.3 + (index * 0.05),
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 16,
                    ),
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
                    child: Row(
                      children: [
                        // Nama Mapel & KKM
                        Expanded(
                          flex: 4,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item['subject'],
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                "KKM: ${item['kkm']}",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: Colors.grey.shade500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Nilai Pengetahuan
                        Expanded(
                          flex: 2,
                          child: Column(
                            children: [
                              Text(
                                "${item['p_score']}",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 6,
                                  vertical: 1,
                                ),
                                decoration: BoxDecoration(
                                  color: _getGradeColor(item['p_pred']),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  item['p_pred'],
                                  style: const TextStyle(
                                    fontSize: 10,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Nilai Keterampilan
                        Expanded(
                          flex: 2,
                          child: Column(
                            children: [
                              Text(
                                "${item['k_score']}",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 6,
                                  vertical: 1,
                                ),
                                decoration: BoxDecoration(
                                  color: _getGradeColor(item['k_pred']),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  item['k_pred'],
                                  style: const TextStyle(
                                    fontSize: 10,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
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

            const SizedBox(height: 20),

            // 5. CATATAN WALI KELAS
            FadeInSlide(
              delay: 0.6,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.blue.shade200),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Catatan Wali Kelas:",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Pertahankan prestasimu. Tingkatkan lagi nilai Matematika di semester depan. Selalu rajin beribadah dan berdoa.",
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.blue.shade900,
                        fontStyle: FontStyle.italic,
                      ),
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

  // Helper Widget untuk Summary Header
  Widget _buildSummaryItem(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(color: Colors.white70, fontSize: 12),
        ),
      ],
    );
  }

  // Helper untuk Warna Predikat
  Color _getGradeColor(String grade) {
    switch (grade) {
      case 'A':
        return Colors.green;
      case 'B':
        return Colors.blue;
      case 'C':
        return Colors.orange;
      default:
        return Colors.red;
    }
  }
}
