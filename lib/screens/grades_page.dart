import 'package:flutter/material.dart';
import '../constants.dart';
import '../widgets/fade_in_slide.dart';

class GradesPage extends StatefulWidget {
  const GradesPage({super.key});

  @override
  State<GradesPage> createState() => _GradesPageState();
}

class _GradesPageState extends State<GradesPage> {
  int _selectedSemester = 0;
  final List<String> _semesters = [
    "Semester 1",
    "Semester 2",
    "Semester 3",
    "Semester 4",
  ];

  // Dummy Data Nilai
  final List<Map<String, dynamic>> _grades = [
    {"subject": "Pemrograman Web", "code": "RPL-01", "score": 92, "kkm": 75},
    {"subject": "Basis Data", "code": "RPL-02", "score": 88, "kkm": 75},
    {"subject": "Matematika", "code": "UM-04", "score": 78, "kkm": 70},
    {"subject": "Bahasa Indonesia", "code": "UM-01", "score": 85, "kkm": 75},
    {"subject": "B. Inggris", "code": "UM-02", "score": 95, "kkm": 75},
    {"subject": "PKN", "code": "UM-03", "score": 80, "kkm": 75},
    {
      "subject": "Fisika Terapan",
      "code": "DK-01",
      "score": 68,
      "kkm": 70,
    }, // Contoh nilai dibawah KKM
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        title: const Text(
          "Transkrip Nilai",
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
            icon: const Icon(Icons.print_outlined, color: kTelkomRed),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Mencetak Transkrip...")),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // 1. SUMMARY CARD (IPK / Rata-rata)
          FadeInSlide(
            delay: 0.1,
            child: Container(
              width: double.infinity,
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(20),
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Indeks Prestasi",
                        style: TextStyle(color: Colors.white70, fontSize: 14),
                      ),
                      SizedBox(height: 8),
                      Text(
                        "3.85",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "Sangat Baik",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  // Progress Circle Hiasan
                  SizedBox(
                    height: 80,
                    width: 80,
                    child: Stack(
                      children: [
                        const Center(
                          child: Text(
                            "A",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        CircularProgressIndicator(
                          value: 0.9,
                          strokeWidth: 8,
                          backgroundColor: Colors.white24,
                          valueColor: const AlwaysStoppedAnimation<Color>(
                            Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // 2. SEMESTER SELECTOR
          Container(
            height: 50,
            margin: const EdgeInsets.only(bottom: 10),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: _semesters.length,
              itemBuilder: (context, index) {
                bool isSelected = _selectedSemester == index;
                return GestureDetector(
                  onTap: () => setState(() => _selectedSemester = index),
                  child: Container(
                    margin: const EdgeInsets.only(right: 12),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.black87 : Colors.white,
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(
                        color: isSelected
                            ? Colors.transparent
                            : Colors.grey.shade300,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        _semesters[index],
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.grey[600],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // 3. LIST NILAI
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              itemCount: _grades.length,
              itemBuilder: (context, index) {
                final data = _grades[index];
                return FadeInSlide(
                  delay: 0.2 + (index * 0.1),
                  child: _buildGradeCard(data),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGradeCard(Map<String, dynamic> data) {
    int score = data['score'];
    int kkm = data['kkm'];

    // Logika Warna & Grade
    Color gradeColor;
    String gradeLetter;

    if (score >= 90) {
      gradeColor = const Color(0xFF00C853); // Hijau
      gradeLetter = "A";
    } else if (score >= 80) {
      gradeColor = Colors.blue;
      gradeLetter = "B";
    } else if (score >= 70) {
      gradeColor = Colors.orange;
      gradeLetter = "C";
    } else {
      gradeColor = Colors.red;
      gradeLetter = "D";
    }

    return Container(
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
          // Icon Subject Bulat
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              color: gradeColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(
                gradeLetter,
                style: TextStyle(
                  color: gradeColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),

          // Info Mapel
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data['subject'],
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "Kode: ${data['code']} • KKM: $kkm",
                  style: TextStyle(fontSize: 12, color: Colors.grey[500]),
                ),
              ],
            ),
          ),

          // Nilai Angka
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "$score",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: gradeColor,
                ),
              ),
              const Text(
                "Poin",
                style: TextStyle(fontSize: 10, color: Colors.grey),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
