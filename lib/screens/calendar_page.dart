import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Kita pakai helper bawaan Flutter untuk format tanggal
import '../constants.dart';
import '../widgets/fade_in_slide.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime _focusedDay = DateTime(2024, 12, 1);
  DateTime _selectedDay = DateTime(2024, 12, 1);

  // Dummy Data Event (Format: Tahun-Bulan-Hari)
  final Map<String, List<Map<String, dynamic>>> _events = {
    // --- NOVEMBER 2024 ---
    "2024-11-10": [
      {"title": "Upacara Hari Pahlawan", "type": "activity"},
    ],
    "2024-11-15": [
      {"title": "Kunjungan Industri (RPL)", "type": "activity"},
    ],
    "2024-11-25": [
      {"title": "Hari Guru Nasional", "type": "important"},
    ],

    // --- DESEMBER 2024 (AGENDA PADAT) ---
    "2024-12-02": [
      {"title": "UAS: B. Indonesia & Agama", "type": "exam"},
    ],
    "2024-12-03": [
      {"title": "UAS: Matematika & PKN", "type": "exam"},
    ],
    "2024-12-04": [
      {"title": "UAS: B. Inggris & Sejarah", "type": "exam"},
    ],
    "2024-12-05": [
      {"title": "UAS: Teori Kejuruan (RPL)", "type": "exam"},
    ],
    "2024-12-06": [
      {"title": "UAS: Praktik Kejuruan", "type": "exam"},
    ],

    "2024-12-09": [
      {"title": "Remedial Mapel Umum", "type": "activity"},
    ],
    "2024-12-10": [
      {"title": "Remedial Mapel Produktif", "type": "activity"},
    ],

    "2024-12-12": [
      {"title": "Class Meeting: Futsal", "type": "activity"},
    ],
    "2024-12-13": [
      {"title": "Class Meeting: E-Sport", "type": "activity"},
    ],
    "2024-12-14": [
      {"title": "Pentas Seni Sekolah", "type": "activity"},
    ],

    "2024-12-20": [
      {"title": "Pembagian Raport Smstr 1", "type": "important"},
    ],
    "2024-12-21": [
      {"title": "Libur Semester Ganjil Mulai", "type": "holiday"},
    ],
    "2024-12-24": [
      {"title": "Cuti Bersama Natal", "type": "holiday"},
    ],
    "2024-12-25": [
      {"title": "Hari Raya Natal", "type": "holiday"},
    ],

    // --- JANUARI 2025 ---
    "2025-01-01": [
      {"title": "Tahun Baru 2025", "type": "holiday"},
    ],
    "2025-01-06": [
      {"title": "Masuk Sekolah Semester 2", "type": "important"},
    ],
  };

  // Helper untuk pindah bulan
  void _changeMonth(int offset) {
    setState(() {
      _focusedDay = DateTime(_focusedDay.year, _focusedDay.month + offset, 1);
    });
  }

  // Helper warna kategori
  Color _getTypeColor(String type) {
    switch (type) {
      case 'holiday':
        return Colors.red;
      case 'exam':
        return Colors.blue;
      case 'activity':
        return Colors.green;
      case 'important':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Logika Kalender Grid
    final int daysInMonth = DateTime(
      _focusedDay.year,
      _focusedDay.month + 1,
      0,
    ).day;
    final int firstWeekday = DateTime(
      _focusedDay.year,
      _focusedDay.month,
      1,
    ).weekday; // 1 = Senin, 7 = Minggu
    final List<String> weekDays = [
      "Sen",
      "Sel",
      "Rab",
      "Kam",
      "Jum",
      "Sab",
      "Min",
    ];

    // Filter Event bulan ini untuk list di bawah
    final monthEvents =
        _events.entries
            .where(
              (entry) => entry.key.startsWith(
                "${_focusedDay.year}-${_focusedDay.month.toString().padLeft(2, '0')}",
              ),
            )
            .toList()
          ..sort((a, b) => a.key.compareTo(b.key));

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        title: const Text(
          "Kalender Akademik",
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
          // 1. CALENDAR WIDGET
          Container(
            margin: const EdgeInsets.all(20),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              children: [
                // Header Bulan
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.chevron_left),
                      onPressed: () => _changeMonth(-1),
                    ),
                    Text(
                      DateFormat(
                        'MMMM yyyy',
                      ).format(_focusedDay), // Format Bulan Tahun
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.chevron_right),
                      onPressed: () => _changeMonth(1),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Nama Hari
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: weekDays
                      .map(
                        (day) => Expanded(
                          child: Center(
                            child: Text(
                              day,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
                const SizedBox(height: 10),

                // Grid Tanggal
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: daysInMonth + (firstWeekday - 1),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 7,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                  ),
                  itemBuilder: (context, index) {
                    if (index < firstWeekday - 1)
                      return const SizedBox(); // Slot kosong

                    final int day = index - (firstWeekday - 2);
                    final String dateKey =
                        "${_focusedDay.year}-${_focusedDay.month.toString().padLeft(2, '0')}-${day.toString().padLeft(2, '0')}";
                    final bool hasEvent = _events.containsKey(dateKey);
                    final bool isToday =
                        day == DateTime.now().day &&
                        _focusedDay.month == DateTime.now().month &&
                        _focusedDay.year == DateTime.now().year;

                    // Ambil warna event pertama jika ada
                    Color markerColor = Colors.transparent;
                    if (hasEvent) {
                      markerColor = _getTypeColor(_events[dateKey]![0]['type']);
                    }

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedDay = DateTime(
                            _focusedDay.year,
                            _focusedDay.month,
                            day,
                          );
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: isToday ? kTelkomRed : Colors.transparent,
                          shape: BoxShape.circle,
                          border: day == _selectedDay.day
                              ? Border.all(color: kTelkomRed, width: 2)
                              : null,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "$day",
                              style: TextStyle(
                                color: isToday ? Colors.white : Colors.black87,
                                fontWeight: isToday
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                              ),
                            ),
                            if (hasEvent)
                              Container(
                                margin: const EdgeInsets.only(top: 4),
                                width: 6,
                                height: 6,
                                decoration: BoxDecoration(
                                  color: isToday ? Colors.white : markerColor,
                                  shape: BoxShape.circle,
                                ),
                              ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),

          // 2. UPCOMING EVENTS HEADER
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Agenda Bulan Ini",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: kTelkomRed.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    "${monthEvents.length} Agenda",
                    style: const TextStyle(
                      color: kTelkomRed,
                      fontWeight: FontWeight.bold,
                      fontSize: 10,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),

          // 3. EVENT LIST
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: monthEvents.length,
              itemBuilder: (context, index) {
                final String dateKey = monthEvents[index].key;
                final List listEvent = monthEvents[index].value;
                // Ambil event pertama di tanggal tsb (bisa di loop kalau banyak)
                final event = listEvent[0];

                // Format tanggal cantik (dd MMM)
                DateTime date = DateTime.parse(dateKey);
                String dateFormatted = DateFormat('dd MMM').format(date);
                String dayName = DateFormat(
                  'EEEE',
                ).format(date); // Nama Hari (inggris default, gapapa)

                return FadeInSlide(
                  delay: index * 0.1,
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border(
                        left: BorderSide(
                          color: _getTypeColor(event['type']),
                          width: 4,
                        ),
                      ),
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
                        Column(
                          children: [
                            Text(
                              dateFormatted,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              dayName,
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          width: 1,
                          height: 30,
                          color: Colors.grey[300],
                          margin: const EdgeInsets.symmetric(horizontal: 16),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                event['title'],
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                event['type'].toString().toUpperCase(),
                                style: TextStyle(
                                  color: _getTypeColor(event['type']),
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
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
          ),
        ],
      ),
    );
  }
}
