import 'package:flutter/material.dart';
import '../constants.dart';
import '../widgets/fade_in_slide.dart';
import 'scan_attendance_page.dart';

class AttendancePage extends StatefulWidget {
  const AttendancePage({super.key});

  @override
  State<AttendancePage> createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
  int _selectedMonthIndex = 0;
  final List<String> _months = [
    "November 2024",
    "Oktober 2024",
    "September 2024",
  ];

  // Dummy Data Riwayat Absensi
  final List<Map<String, dynamic>> _history = [
    {
      "date": "24",
      "day": "Kamis",
      "status": "Hadir",
      "in": "06:45",
      "out": "15:30",
      "color": Colors.green,
    },
    {
      "date": "23",
      "day": "Rabu",
      "status": "Hadir",
      "in": "06:50",
      "out": "15:00",
      "color": Colors.green,
    },
    {
      "date": "22",
      "day": "Selasa",
      "status": "Sakit",
      "in": "-",
      "out": "-",
      "color": Colors.orange,
    },
    {
      "date": "21",
      "day": "Senin",
      "status": "Hadir",
      "in": "06:40",
      "out": "15:30",
      "color": Colors.green,
    },
    {
      "date": "20",
      "day": "Jumat",
      "status": "Hadir",
      "in": "06:55",
      "out": "11:30",
      "color": Colors.green,
    },
    {
      "date": "19",
      "day": "Kamis",
      "status": "Izin",
      "in": "-",
      "out": "-",
      "color": Colors.blue,
    },
    {
      "date": "18",
      "day": "Rabu",
      "status": "Hadir",
      "in": "06:30",
      "out": "15:00",
      "color": Colors.green,
    },
    {
      "date": "17",
      "day": "Selasa",
      "status": "Alpha",
      "in": "-",
      "out": "-",
      "color": Colors.red,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        title: const Text(
          "Riwayat Absensi",
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
          // 1. HEADER STATISTIK (GRID 2x2)
          Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Ringkasan Bulan Ini",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: _buildSummaryCard(
                        "Hadir",
                        "18",
                        Colors.green,
                        Icons.check_circle_outline,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildSummaryCard(
                        "Sakit",
                        "1",
                        Colors.orange,
                        Icons.medical_services_outlined,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: _buildSummaryCard(
                        "Izin",
                        "1",
                        Colors.blue,
                        Icons.assignment_outlined,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildSummaryCard(
                        "Alpha",
                        "1",
                        Colors.red,
                        Icons.cancel_outlined,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // 2. FILTER BULAN
          Container(
            height: 40,
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _months.length,
              itemBuilder: (context, index) {
                bool isSelected = _selectedMonthIndex == index;
                return GestureDetector(
                  onTap: () => setState(() => _selectedMonthIndex = index),
                  child: Container(
                    margin: const EdgeInsets.only(right: 12),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected ? kTelkomRed : Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: isSelected ? kTelkomRed : Colors.grey.shade300,
                      ),
                    ),
                    child: Text(
                      _months[index],
                      style: TextStyle(
                        color: isSelected ? Colors.white : Colors.grey[700],
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 16),

          // 3. LIST LOG ABSENSI
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: _history.length,
              itemBuilder: (context, index) {
                final data = _history[index];
                return FadeInSlide(
                  delay: index * 0.1,
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
                        left: BorderSide(color: data['color'], width: 4),
                      ), // Garis warna status di kiri
                    ),
                    child: Row(
                      children: [
                        // TANGGAL
                        Column(
                          children: [
                            Text(
                              data['date'],
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              data['day'],
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          width: 1,
                          height: 40,
                          color: Colors.grey[200],
                          margin: const EdgeInsets.symmetric(horizontal: 16),
                        ),

                        // INFO STATUS
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: (data['color'] as Color).withOpacity(
                                    0.1,
                                  ),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  data['status'],
                                  style: TextStyle(
                                    color: data['color'],
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 4),
                              if (data['status'] == 'Hadir')
                                Text(
                                  "Masuk: ${data['in']} • Pulang: ${data['out']}",
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                ),
                              if (data['status'] != 'Hadir')
                                const Text(
                                  "Tidak ada catatan waktu",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                ),
                            ],
                          ),
                        ),

                        // ICON CHECK
                        Icon(
                          data['status'] == 'Hadir'
                              ? Icons.check_circle
                              : Icons.info,
                          color: (data['color'] as Color).withOpacity(0.5),
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
      // Floating Action Button (Optional: Untuk Scan Absen)
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Pindah ke Halaman Scan
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ScanAttendancePage()),
          );
        },
        backgroundColor: kTelkomRed,
        icon: const Icon(Icons.qr_code_scanner),
        label: const Text("Scan Masuk"),
      ),
    );
  }

  Widget _buildSummaryCard(
    String title,
    String count,
    Color color,
    IconData icon,
  ) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                count,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              Text(
                title,
                style: TextStyle(fontSize: 12, color: color.withOpacity(0.8)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
