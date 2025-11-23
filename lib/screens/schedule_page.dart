import 'package:flutter/material.dart';
import '../constants.dart';
import '../widgets/fade_in_slide.dart'; // Kita pakai animasi yang sudah ada biar keren

class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key});

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  // Simulasi Index Hari (0 = Senin, 1 = Selasa, dst)
  int _selectedDayIndex = 0;

  final List<String> _days = ["Senin", "Selasa", "Rabu", "Kamis", "Jumat"];

  // Simulasi Data Jadwal (Bisa diganti data dari API/Database nanti)
  final List<Map<String, dynamic>> _schedules = [
    {
      "time": "07:00",
      "endTime": "08:30",
      "subject": "Upacara Bendera",
      "room": "Lapangan",
      "teacher": "Tim Kesiswaan",
      "status": "done", // done, active, upcoming
    },
    {
      "time": "08:30",
      "endTime": "10:00",
      "subject": "Pemrograman Web",
      "room": "Lab RPL 1",
      "teacher": "Pak Asep",
      "status": "active", // Sedang berlangsung
    },
    {
      "time": "10:00",
      "endTime": "10:30",
      "subject": "Istirahat",
      "room": "-",
      "teacher": "-",
      "status": "upcoming",
    },
    {
      "time": "10:30",
      "endTime": "12:00",
      "subject": "Bahasa Indonesia",
      "room": "R. Teori 4",
      "teacher": "Bu Susi",
      "status": "upcoming",
    },
    {
      "time": "13:00",
      "endTime": "14:30",
      "subject": "Basis Data",
      "room": "Lab RPL 2",
      "teacher": "Pak Budi",
      "status": "upcoming",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        title: const Text(
          "Jadwal Pelajaran",
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
          // 1. DAY SELECTOR (PILIH HARI)
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: SizedBox(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: _days.length,
                itemBuilder: (context, index) {
                  bool isSelected = _selectedDayIndex == index;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedDayIndex = index;
                        // Disini nanti logika ganti data jadwal berdasarkan hari
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.only(right: 12),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected ? kTelkomRed : Colors.grey[100],
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Center(
                        child: Text(
                          _days[index],
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

          // 2. LIST JADWAL
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: _schedules.length,
              itemBuilder: (context, index) {
                final data = _schedules[index];
                return FadeInSlide(
                  delay: index * 0.1, // Efek muncul satu per satu
                  child: _buildScheduleCard(data),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScheduleCard(Map<String, dynamic> data) {
    bool isActive = data['status'] == 'active';
    bool isDone = data['status'] == 'done';

    // Warna strip samping (Merah jika aktif, abu jika lewat, biru jika belum)
    Color statusColor = isActive
        ? kTelkomRed
        : (isDone ? Colors.grey : kPrimaryColor);

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Kolom Waktu
          SizedBox(
            width: 50,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  data['time'],
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                Text(
                  data['endTime'],
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),
          ),

          const SizedBox(width: 12),

          // Garis Timeline & Dot
          Column(
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: isActive ? Colors.white : statusColor,
                  border: Border.all(color: statusColor, width: 2),
                  shape: BoxShape.circle,
                ),
                child: isActive
                    ? Center(
                        child: Container(
                          width: 6,
                          height: 6,
                          decoration: BoxDecoration(
                            color: statusColor,
                            shape: BoxShape.circle,
                          ),
                        ),
                      )
                    : null,
              ),
              Container(
                width: 2,
                height: 100, // Tinggi garis penghubung
                color: Colors.grey.shade300,
              ),
            ],
          ),

          const SizedBox(width: 12),

          // Card Informasi
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
                // Jika aktif, kasih border merah tipis
                border: isActive
                    ? Border.all(color: kTelkomRed.withOpacity(0.5))
                    : null,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (isActive)
                    Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: kTelkomRed.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Text(
                        "Sedang Berlangsung",
                        style: TextStyle(
                          fontSize: 10,
                          color: kTelkomRed,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                  Text(
                    data['subject'],
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: isDone ? Colors.grey : Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        size: 14,
                        color: Colors.grey[600],
                      ),
                      const SizedBox(width: 4),
                      Text(
                        data['room'],
                        style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                      ),
                      const SizedBox(width: 16),
                      Icon(
                        Icons.person_outline,
                        size: 14,
                        color: Colors.grey[600],
                      ),
                      const SizedBox(width: 4),
                      Text(
                        data['teacher'],
                        style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
