import 'package:flutter/material.dart';
import 'dart:ui'; // Untuk efek blur (optional)
import '../constants.dart';

class VideoCallPage extends StatefulWidget {
  final String teacherName;
  final String teacherImage;

  const VideoCallPage({
    super.key,
    required this.teacherName,
    required this.teacherImage,
  });

  @override
  State<VideoCallPage> createState() => _VideoCallPageState();
}

class _VideoCallPageState extends State<VideoCallPage> {
  bool _isMuted = false;
  bool _isVideoOff = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // 1. BACKGROUND (VIDEO GURU)
          // Di aplikasi nyata, ini adalah CameraPreview / WebRTC Stream
          Image.network(widget.teacherImage, fit: BoxFit.cover),

          // Overlay Gelap Tipis agar tulisan terbaca
          Container(color: Colors.black.withOpacity(0.3)),

          // 2. HEADER INFO (NAMA GURU & DURASI)
          Positioned(
            top: 60,
            left: 0,
            right: 0,
            child: Column(
              children: [
                Text(
                  widget.teacherName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    shadows: [Shadow(color: Colors.black54, blurRadius: 10)],
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    "00:45", // Timer simulasi
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // 3. USER CAMERA (PIP - Picture in Picture)
          Positioned(
            right: 20,
            bottom: 160, // Di atas tombol kontrol
            child: Container(
              height: 160,
              width: 110,
              decoration: BoxDecoration(
                color: Colors.grey.shade900,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.white, width: 2),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(14),
                // Gambar placeholder siswa (kamera sendiri)
                child: Image.network(
                  'https://i.pravatar.cc/150?img=12',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

          // 4. CONTROL BUTTONS (MUTE, END CALL, VIDEO)
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [Colors.black87, Colors.transparent],
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Tombol Mute
                  _buildControlButton(
                    icon: _isMuted ? Icons.mic_off : Icons.mic,
                    color: _isMuted
                        ? Colors.white
                        : Colors.white.withOpacity(0.2),
                    iconColor: _isMuted ? Colors.black : Colors.white,
                    onTap: () => setState(() => _isMuted = !_isMuted),
                  ),

                  // Tombol End Call (Tutup Telepon)
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.redAccent,
                            blurRadius: 15,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.call_end,
                        color: Colors.white,
                        size: 32,
                      ),
                    ),
                  ),

                  // Tombol Matikan Video
                  _buildControlButton(
                    icon: _isVideoOff ? Icons.videocam_off : Icons.videocam,
                    color: _isVideoOff
                        ? Colors.white
                        : Colors.white.withOpacity(0.2),
                    iconColor: _isVideoOff ? Colors.black : Colors.white,
                    onTap: () => setState(() => _isVideoOff = !_isVideoOff),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper Widget untuk Tombol Bulat Transparan
  Widget _buildControlButton({
    required IconData icon,
    required Color color,
    required Color iconColor,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        child: Icon(icon, color: iconColor, size: 28),
      ),
    );
  }
}
