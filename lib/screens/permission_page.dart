import 'package:flutter/material.dart';
import '../constants.dart';
import '../widgets/fade_in_slide.dart';

class PermissionPage extends StatefulWidget {
  const PermissionPage({super.key});

  @override
  State<PermissionPage> createState() => _PermissionPageState();
}

class _PermissionPageState extends State<PermissionPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        title: const Text(
          "Pengajuan Izin",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        bottom: TabBar(
          controller: _tabController,
          labelColor: kTelkomRed,
          unselectedLabelColor: Colors.grey,
          indicatorColor: kTelkomRed,
          tabs: const [
            Tab(text: "Keluar Kelas"),
            Tab(text: "Tidak Masuk"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _LeaveClassForm(), // Form Tab 1
          _AbsentForm(), // Form Tab 2
        ],
      ),
    );
  }
}

// =================================================
// 1. FORM IZIN KELUAR KELAS (LEAVE CLASS)
// =================================================
class _LeaveClassForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const FadeInSlide(
            delay: 0.1,
            child: InfoBanner(
              text:
                  "Izin ini digunakan jika Anda perlu meninggalkan KBM (Sakit di UKS, Dispensasi Organisasi, dll).",
            ),
          ),
          const SizedBox(height: 20),

          FadeInSlide(
            delay: 0.2,
            child: Column(
              children: [
                _buildTextField(
                  label: "Guru Pengajar Saat Ini",
                  hint: "Nama Guru...",
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: _buildTextField(
                        label: "Jam Keluar",
                        hint: "08:00",
                        icon: Icons.access_time,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _buildTextField(
                        label: "Estimasi Kembali",
                        hint: "09:00",
                        icon: Icons.access_time,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  label: "Alasan Meninggalkan Kelas",
                  hint: "Jelaskan alasan secara detail...",
                  maxLines: 4,
                ),
              ],
            ),
          ),

          const SizedBox(height: 30),
          FadeInSlide(
            delay: 0.3,
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () =>
                    _showSuccessDialog(context, "Izin Keluar Kelas"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: kTelkomRed,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text(
                  "AJUKAN IZIN",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// =================================================
// 2. FORM IZIN TIDAK MASUK (ABSENT)
// =================================================
class _AbsentForm extends StatefulWidget {
  @override
  State<_AbsentForm> createState() => _AbsentFormState();
}

class _AbsentFormState extends State<_AbsentForm> {
  String _selectedType = "Sakit";
  final List<String> _types = ["Sakit", "Izin", "Dispensasi"];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const FadeInSlide(
            delay: 0.1,
            child: InfoBanner(
              text:
                  "Formulir untuk tidak hadir seharian. Wajib melampirkan bukti (Surat Dokter/Ortu).",
            ),
          ),
          const SizedBox(height: 20),

          FadeInSlide(
            delay: 0.2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Jenis Izin",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
                const SizedBox(height: 8),
                Row(
                  children: _types.map((type) {
                    bool isSelected = _selectedType == type;
                    return GestureDetector(
                      onTap: () => setState(() => _selectedType = type),
                      child: Container(
                        margin: const EdgeInsets.only(right: 12),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected ? kTelkomRed : Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: isSelected
                                ? kTelkomRed
                                : Colors.grey.shade300,
                          ),
                        ),
                        child: Text(
                          type,
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.grey[700],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),

                const SizedBox(height: 20),

                Row(
                  children: [
                    Expanded(
                      child: _buildTextField(
                        label: "Dari Tanggal",
                        hint: "Pilih Tgl",
                        icon: Icons.calendar_today,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _buildTextField(
                        label: "Sampai Tanggal",
                        hint: "Pilih Tgl",
                        icon: Icons.calendar_today,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  label: "Keterangan Tambahan",
                  hint: "Tulis keterangan...",
                  maxLines: 3,
                ),

                const SizedBox(height: 16),
                const Text(
                  "Upload Bukti (Foto Surat/Dokter)",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
                const SizedBox(height: 8),
                GestureDetector(
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Membuka Galeri...")),
                    );
                  },
                  child: Container(
                    height: 100,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.grey.shade300,
                        style: BorderStyle.solid,
                      ), // Dotted style butuh package lain
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.cloud_upload_outlined,
                          size: 30,
                          color: Colors.grey.shade400,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Tap untuk unggah foto",
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 30),
          FadeInSlide(
            delay: 0.3,
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () =>
                    _showSuccessDialog(context, "Izin Tidak Masuk"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: kTelkomRed,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text(
                  "KIRIM PERMOHONAN",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// =================================================
// HELPER WIDGETS & FUNCTIONS
// =================================================

Widget _buildTextField({
  required String label,
  required String hint,
  int maxLines = 1,
  IconData? icon,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
      ),
      const SizedBox(height: 8),
      TextField(
        maxLines: maxLines,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.grey, fontSize: 13),
          prefixIcon: icon != null
              ? Icon(icon, color: Colors.grey, size: 20)
              : null,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
        ),
      ),
    ],
  );
}

class InfoBanner extends StatelessWidget {
  final String text;
  const InfoBanner({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.blue.shade200),
      ),
      child: Row(
        children: [
          const Icon(Icons.info_outline, color: Colors.blue),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: TextStyle(fontSize: 12, color: Colors.blue.shade800),
            ),
          ),
        ],
      ),
    );
  }
}

void _showSuccessDialog(BuildContext context, String type) {
  showDialog(
    context: context,
    builder: (context) => Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.check_circle,
                color: Colors.green,
                size: 40,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              "Permohonan Terkirim",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              "$type Anda sedang diproses oleh Wali Kelas / Piket.",
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: kTelkomRed),
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context); // Kembali ke Menu Lainnya
                },
                child: const Text(
                  "Oke, Mengerti",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
