import 'package:flutter/material.dart';
import '../constants.dart'; // Pastikan import ini ada
import '../widgets/fade_in_slide.dart';

class AptitudeTestPage extends StatefulWidget {
  const AptitudeTestPage({super.key});

  @override
  State<AptitudeTestPage> createState() => _AptitudeTestPageState();
}

class _AptitudeTestPageState extends State<AptitudeTestPage> {
  int _currentQuestionIndex = 0;
  bool _isFinished = false;

  // Dummy Data Pertanyaan
  final List<Map<String, dynamic>> _questions = [
    {
      "question": "Apa yang paling kamu sukai saat menggunakan komputer?",
      "options": [
        "Membuat program / Coding",
        "Mengedit video atau desain grafis",
        "Memperbaiki hardware / merakit PC",
        "Bermain game online kompetitif",
      ],
    },
    {
      "question": "Pelajaran apa yang paling kamu nantikan di sekolah?",
      "options": [
        "Matematika & Logika",
        "Seni Budaya & Keterampilan",
        "Fisika & Elektronika",
        "Bahasa Inggris",
      ],
    },
    {
      "question": "Jika ada masalah pada HP temanmu, apa yang kamu lakukan?",
      "options": [
        "Mencari penyebab error di sistem",
        "Menyarankan beli casing baru yang keren",
        "Mengecek baterai atau layar fisik",
        "Langsung bawa ke tukang servis",
      ],
    },
    {
      "question": "Karir impianmu di masa depan adalah?",
      "options": [
        "Software Engineer / Programmer",
        "UI/UX Designer / Content Creator",
        "Network Engineer / Teknisi",
        "IT Consultant / Manager",
      ],
    },
  ];

  // Fungsi saat jawaban dipilih
  void _answerQuestion(int index) {
    if (_currentQuestionIndex < _questions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
      });
    } else {
      setState(() {
        _isFinished = true;
      });
    }
  }

  // Reset Test
  void _resetTest() {
    setState(() {
      _currentQuestionIndex = 0;
      _isFinished = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        title: const Text(
          "Tes Minat Bakat",
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
      body: _isFinished ? _buildResultScreen() : _buildQuizScreen(),
    );
  }

  // ------------------- QUIZ SCREEN -------------------
  Widget _buildQuizScreen() {
    final question = _questions[_currentQuestionIndex];
    double progress = (_currentQuestionIndex + 1) / _questions.length;

    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Progress Bar
          Text(
            "Pertanyaan ${_currentQuestionIndex + 1} dari ${_questions.length}",
            style: const TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.grey.shade300,
              color: Colors.purple, // Tema Ungu
              minHeight: 8,
            ),
          ),
          const SizedBox(height: 40),

          // Pertanyaan
          FadeInSlide(
            // Kunci (Key) penting agar animasi jalan setiap ganti soal
            key: ValueKey(_currentQuestionIndex),
            delay: 0.1,
            child: Text(
              question['question'],
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                height: 1.3,
              ),
            ),
          ),

          const SizedBox(height: 30),

          // Pilihan Jawaban
          Expanded(
            child: ListView.builder(
              itemCount: (question['options'] as List).length,
              itemBuilder: (context, index) {
                String option = question['options'][index];
                return FadeInSlide(
                  key: ValueKey(
                    "opt_$_currentQuestionIndex$index",
                  ), // Unique Key per tombol
                  delay: 0.2 + (index * 0.1),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: ElevatedButton(
                      onPressed: () => _answerQuestion(index),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.purple,
                        padding: const EdgeInsets.symmetric(
                          vertical: 16,
                          horizontal: 20,
                        ),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: BorderSide(
                            color: Colors.purple.withOpacity(0.2),
                            width: 1.5,
                          ),
                        ),
                        alignment: Alignment.centerLeft, // Teks rata kiri
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.purple.shade50,
                              shape: BoxShape.circle,
                            ),
                            child: Text(
                              String.fromCharCode(65 + index), // A, B, C, D
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.purple,
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Text(
                              option,
                              style: const TextStyle(
                                fontSize: 15,
                                color: Colors.black87,
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

  // ------------------- RESULT SCREEN -------------------
  Widget _buildResultScreen() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FadeInSlide(
              delay: 0.1,
              child: Container(
                height: 150,
                width: 150,
                decoration: BoxDecoration(
                  color: Colors.purple.shade50,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.emoji_events,
                  size: 80,
                  color: Colors.purple,
                ),
              ),
            ),
            const SizedBox(height: 24),

            const FadeInSlide(
              delay: 0.2,
              child: Text(
                "Hasil Analisa",
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            ),
            const SizedBox(height: 8),
            const FadeInSlide(
              delay: 0.3,
              child: Text(
                "Rekayasa Perangkat Lunak (RPL)",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.purple,
                ),
              ),
            ),
            const SizedBox(height: 16),
            const FadeInSlide(
              delay: 0.4,
              child: Text(
                "Kamu memiliki pola pikir logis dan kreatif yang sangat cocok untuk menjadi seorang Programmer atau Developer aplikasi.",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black54, height: 1.5),
              ),
            ),

            const SizedBox(height: 40),

            FadeInSlide(
              delay: 0.5,
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: _resetTest,
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        side: const BorderSide(color: Colors.purple),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        "Ulangi Tes",
                        style: TextStyle(color: Colors.purple),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        "Selesai",
                        style: TextStyle(color: Colors.white),
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
  }
}
