import 'package:flutter/material.dart';
import '../constants.dart';
import '../widgets/fade_in_slide.dart';

class OrganizationPage extends StatefulWidget {
  const OrganizationPage({super.key});

  @override
  State<OrganizationPage> createState() => _OrganizationPageState();
}

class _OrganizationPageState extends State<OrganizationPage> {
  // Dummy Data Organisasi
  final List<Map<String, dynamic>> _organizations = [
    {
      "name": "OSIS",
      "fullName": "Organisasi Siswa Intra Sekolah",
      "leader": "Ahmad Fadhil",
      "members": 42,
      "desc":
          "Induk organisasi siswa di sekolah yang menaungi seluruh aktivitas kesiswaan dan menjadi jembatan antara siswa dengan sekolah.",
      "icon": Icons.shield_outlined,
      "color": Colors.blue.shade800,
    },
    {
      "name": "MPK",
      "fullName": "Majelis Perwakilan Kelas",
      "leader": "Sarah Amalia",
      "members": 24,
      "desc":
          "Organisasi legislator yang bertugas mengawasi kinerja OSIS, menampung aspirasi siswa, dan menetapkan Garis Besar Program Kerja.",
      "icon": Icons.gavel,
      "color": Colors.brown,
    },
    {
      "name": "Pramuka",
      "fullName": "Praja Muda Karana",
      "leader": "Budi Santoso",
      "members": 150,
      "desc":
          "Gerakan kepanduan yang melatih kedisiplinan, kemandirian, kepemimpinan, dan cinta alam.",
      "icon": Icons.explore,
      "color": Colors.orange.shade800,
    },
    {
      "name": "PMR",
      "fullName": "Palang Merah Remaja",
      "leader": "Rina Kartika",
      "members": 35,
      "desc":
          "Wadah pembinaan dan pengembangan anggota remaja PMI di sekolah yang bergerak di bidang kemanusiaan dan kesehatan.",
      "icon": Icons.medical_services,
      "color": Colors.red,
    },
    {
      "name": "Rohis",
      "fullName": "Kerohanian Islam",
      "leader": "Fauzan Azima",
      "members": 60,
      "desc":
          "Organisasi yang memperdalam ilmu agama Islam, ukhuwah islamiyah, dan dakwah sekolah.",
      "icon": Icons.mosque,
      "color": Colors.green.shade700,
    },
  ];

  void _showDetailModal(Map<String, dynamic> item) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.55,
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

                  // Header Logo & Nama
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
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              item['fullName'],
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 30),

                  // Info Struktur
                  _buildDetailRow(Icons.person, "Ketua Umum", item['leader']),
                  const SizedBox(height: 16),
                  _buildDetailRow(
                    Icons.groups,
                    "Jumlah Anggota",
                    "${item['members']} Orang",
                  ),

                  const SizedBox(height: 24),
                  const Text(
                    "Tentang Organisasi",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    item['desc'],
                    style: const TextStyle(color: Colors.black87, height: 1.5),
                  ),

                  const SizedBox(height: 30),

                  // Tombol Aksi
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              "Pendaftaran ${item['name']} dibuka bulan Juli!",
                            ),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: item['color'],
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        "INFO PENDAFTARAN",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
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

  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Colors.grey[600]),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
            ),
            Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        title: const Text(
          "Organisasi Sekolah",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: _organizations.length,
        itemBuilder: (context, index) {
          final org = _organizations[index];
          return FadeInSlide(
            delay: index * 0.1,
            child: GestureDetector(
              onTap: () => _showDetailModal(org),
              child: Container(
                margin: const EdgeInsets.only(bottom: 16),
                padding: const EdgeInsets.all(20),
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
                  // Border kiri berwarna
                  border: Border(
                    left: BorderSide(color: org['color'], width: 4),
                  ),
                ),
                child: Row(
                  children: [
                    // Icon Organisasi
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: (org['color'] as Color).withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(org['icon'], color: org['color'], size: 28),
                    ),
                    const SizedBox(width: 16),

                    // Info Singkat
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            org['name'],
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          Text(
                            org['fullName'],
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Icon(
                                Icons.person_outline,
                                size: 14,
                                color: Colors.grey[600],
                              ),
                              const SizedBox(width: 4),
                              Text(
                                "Ketua: ${org['leader']}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const Icon(Icons.chevron_right, color: Colors.grey),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
