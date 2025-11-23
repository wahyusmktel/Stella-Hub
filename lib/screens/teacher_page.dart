import 'package:flutter/material.dart';
import '../constants.dart';
import '../widgets/fade_in_slide.dart';
import 'chat_page.dart';

class TeacherPage extends StatefulWidget {
  const TeacherPage({super.key});

  @override
  State<TeacherPage> createState() => _TeacherPageState();
}

class _TeacherPageState extends State<TeacherPage> {
  // Dummy Data Guru
  final List<Map<String, dynamic>> _teachers = [
    {
      "name": "Budi Santoso, S.Kom",
      "subject": "Produktif RPL",
      "nip": "19850101 201001 1 001",
      "status": "Online",
      "image": "https://i.pravatar.cc/150?img=11", // Gambar dummy
    },
    {
      "name": "Susi Susanti, S.Pd",
      "subject": "Bahasa Indonesia",
      "nip": "19900202 201502 2 002",
      "status": "Offline",
      "image": "https://i.pravatar.cc/150?img=5",
    },
    {
      "name": "Asep Saepudin, M.T",
      "subject": "Pemrograman Web",
      "nip": "19880303 201203 1 003",
      "status": "Online",
      "image": "https://i.pravatar.cc/150?img=3",
    },
    {
      "name": "Rina Mariani, S.Si",
      "subject": "Fisika Terapan",
      "nip": "19920404 201804 2 004",
      "status": "Mengajar",
      "image": "https://i.pravatar.cc/150?img=9",
    },
    {
      "name": "Dedi Mulyadi, S.Or",
      "subject": "PJOK",
      "nip": "19870505 201105 1 005",
      "status": "Offline",
      "image": "https://i.pravatar.cc/150?img=8",
    },
    {
      "name": "Siti Aminah, S.Pd",
      "subject": "Bahasa Inggris",
      "nip": "19930606 201906 2 006",
      "status": "Online",
      "image": "https://i.pravatar.cc/150?img=1",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        title: const Text(
          "Data Guru & Staf",
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
      body: Column(
        children: [
          // 1. SEARCH BAR
          Container(
            padding: const EdgeInsets.all(20),
            color: Colors.white,
            child: TextField(
              decoration: InputDecoration(
                hintText: "Cari nama guru atau mapel...",
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

          const SizedBox(height: 10),

          // 2. LIST GURU
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: _teachers.length,
              itemBuilder: (context, index) {
                final teacher = _teachers[index];

                // Tentukan warna status
                Color statusColor = Colors.grey;
                if (teacher['status'] == 'Online') statusColor = Colors.green;
                if (teacher['status'] == 'Mengajar')
                  statusColor = Colors.orange;

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
                        // FOTO PROFIL
                        Stack(
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundImage: NetworkImage(teacher['image']),
                              backgroundColor: Colors.grey.shade200,
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                height: 14,
                                width: 14,
                                decoration: BoxDecoration(
                                  color: statusColor,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 2,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 16),

                        // INFO GURU
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                teacher['name'],
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                teacher['subject'],
                                style: TextStyle(
                                  fontSize: 14,
                                  color: kTelkomRed,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                "NIP: ${teacher['nip']}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey.shade500,
                                ),
                              ),
                            ],
                          ),
                        ),

                        // ACTION BUTTON (CHAT)
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.indigo.shade50,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: IconButton(
                            icon: const Icon(
                              Icons.chat_bubble_outline,
                              color: Colors.indigo,
                            ),
                            onPressed: () {
                              // NAVIGASI KE CHAT PAGE
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ChatPage(
                                    teacherName: teacher['name'],
                                    teacherImage: teacher['image'],
                                    status: teacher['status'],
                                  ),
                                ),
                              );
                            },
                          ),
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
