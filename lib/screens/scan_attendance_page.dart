import 'package:flutter/material.dart';
import 'dart:async';
import '../constants.dart';

class ScanAttendancePage extends StatefulWidget {
  const ScanAttendancePage({super.key});

  @override
  State<ScanAttendancePage> createState() => _ScanAttendancePageState();
}

class _ScanAttendancePageState extends State<ScanAttendancePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  bool _isScanning = false;

  @override
  void initState() {
    super.initState();
    // Setup animasi garis scanner (naik turun)
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  // Fungsi Simulasi Proses Absen
  void _processAbsensi() {
    setState(() {
      _isScanning = true;
    });

    // Simulasi loading 2 detik lalu sukses
    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      setState(() {
        _isScanning = false;
      });
      _showSuccessDialog();
    });
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
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
              const Text(
                "Absensi Berhasil!",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                "Anda tercatat masuk pada pukul 07:15 WIB",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: kTelkomRed),
                  onPressed: () {
                    Navigator.pop(context); // Tutup Dialog
                    Navigator.pop(context); // Kembali ke halaman sebelumnya
                  },
                  child: const Text(
                    "Tutup",
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Background hitam ala kamera
      body: Stack(
        children: [
          // 1. KAMERA BACKGROUND (Placeholder Image)
          // Di aplikasi asli ini adalah CameraPreview()
          Positioned.fill(
            child: Opacity(
              opacity: 0.6,
              child: Image.network(
                'https://images.unsplash.com/photo-1577896335452-e3943f99e60f?ixlib=rb-4.0.3&auto=format&fit=crop&w=1000&q=80', // Gambar ruang kelas/sekolah
                fit: BoxFit.cover,
              ),
            ),
          ),

          // 2. OVERLAY GELAP DENGAN LUBANG TENGAH (SCANNER AREA)
          // Menggunakan ColorFiltered untuk membuat efek lubang
          ColorFiltered(
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.5),
              BlendMode.srcOut,
            ),
            child: Stack(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.transparent,
                    backgroundBlendMode: BlendMode.dstOut,
                  ),
                ),
                Center(
                  child: Container(
                    height: 280,
                    width: 280,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // 3. FRAME SCANNER & ANIMASI GARIS MERAH
          Center(
            child: Container(
              height: 280,
              width: 280,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 2),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Stack(
                children: [
                  // Sudut-sudut Scanner
                  _buildCorner(Alignment.topLeft),
                  _buildCorner(Alignment.topRight),
                  _buildCorner(Alignment.bottomLeft),
                  _buildCorner(Alignment.bottomRight),

                  // Garis Laser Animasi
                  AnimatedBuilder(
                    animation: _animationController,
                    builder: (context, child) {
                      return Positioned(
                        top:
                            280 *
                            _animationController
                                .value, // Bergerak dari 0 ke 280
                        left: 0,
                        right: 0,
                        child: Container(
                          height: 2,
                          // PERBAIKAN: Masukkan color dan boxShadow ke dalam BoxDecoration
                          decoration: BoxDecoration(
                            color: kTelkomRed,
                            boxShadow: [
                              BoxShadow(
                                color: kTelkomRed.withOpacity(0.8),
                                blurRadius: 10,
                                spreadRadius: 1,
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
          ),

          // 4. UI ATAS (Header & Lokasi)
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.close,
                          color: Colors.white,
                          size: 28,
                        ),
                        onPressed: () => Navigator.pop(context),
                      ),
                      const Text(
                        "Scan QR Code",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.flash_on,
                          color: Colors.white,
                          size: 28,
                        ),
                        onPressed: () {}, // Toggle Flashlight
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(Icons.location_on, color: kTelkomRed, size: 16),
                        SizedBox(width: 8),
                        Text(
                          "SMK Telkom Lampung",
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // 5. UI BAWAH (Info & Tombol Manual)
          Positioned(
            bottom: 40,
            left: 20,
            right: 20,
            child: Column(
              children: [
                const Text(
                  "Arahkan kamera ke QR Code yang tersedia di kelas",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                ),
                const SizedBox(height: 30),

                // Tombol Capture (Jika QR sulit terbaca)
                GestureDetector(
                  onTap: _isScanning ? null : _processAbsensi,
                  child: Container(
                    height: 70,
                    width: 70,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 4),
                    ),
                    child: Center(
                      child: Container(
                        height: 56,
                        width: 56,
                        decoration: BoxDecoration(
                          color: _isScanning ? Colors.grey : kTelkomRed,
                          shape: BoxShape.circle,
                        ),
                        child: _isScanning
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : const Icon(
                                Icons.camera_alt,
                                color: Colors.white,
                                size: 28,
                              ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  "Tap untuk Absen Manual",
                  style: TextStyle(color: Colors.white54, fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Helper Widget untuk Sudut Scanner
  Widget _buildCorner(Alignment alignment) {
    return Align(
      alignment: alignment,
      child: Container(
        height: 20,
        width: 20,
        decoration: BoxDecoration(
          border: Border(
            top: alignment.y == -1.0
                ? const BorderSide(color: kTelkomRed, width: 4)
                : BorderSide.none,
            bottom: alignment.y == 1.0
                ? const BorderSide(color: kTelkomRed, width: 4)
                : BorderSide.none,
            left: alignment.x == -1.0
                ? const BorderSide(color: kTelkomRed, width: 4)
                : BorderSide.none,
            right: alignment.x == 1.0
                ? const BorderSide(color: kTelkomRed, width: 4)
                : BorderSide.none,
          ),
        ),
      ),
    );
  }
}
