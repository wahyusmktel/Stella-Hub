import 'package:flutter/material.dart';
import 'dart:ui'; // Penting untuk efek Blur
import '../constants.dart';

class VoiceCallPage extends StatefulWidget {
  final String teacherName;
  final String teacherImage;

  const VoiceCallPage({
    super.key,
    required this.teacherName,
    required this.teacherImage,
  });

  @override
  State<VoiceCallPage> createState() => _VoiceCallPageState();
}

class _VoiceCallPageState extends State<VoiceCallPage>
    with SingleTickerProviderStateMixin {
  bool _isMuted = false;
  bool _isSpeakerOn = false;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    // Animasi "Denyut" (Pulsing Effect)
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // 1. BACKGROUND BLUR IMAGE
          Image.network(widget.teacherImage, fit: BoxFit.cover),
          // Efek Blur Kaca (Glassmorphism)
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            child: Container(
              color: Colors.black.withOpacity(0.6), // Overlay gelap
            ),
          ),

          // 2. KONTEN UTAMA
          SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(flex: 1),

                // HEADER TEXT
                Text(
                  widget.teacherName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  "02:15", // Simulasi Timer
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                    letterSpacing: 1.0,
                  ),
                ),

                const Spacer(flex: 1),

                // AVATAR DENGAN ANIMASI PULSE
                Stack(
                  alignment: Alignment.center,
                  children: [
                    // Lingkaran Luar (Animasi)
                    AnimatedBuilder(
                      animation: _controller,
                      builder: (context, child) {
                        return Container(
                          height: 200 + (_controller.value * 30),
                          width: 200 + (_controller.value * 30),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white.withOpacity(
                              0.1 - (_controller.value * 0.05),
                            ),
                          ),
                        );
                      },
                    ),
                    // Lingkaran Dalam (Animasi)
                    AnimatedBuilder(
                      animation: _controller,
                      builder: (context, child) {
                        return Container(
                          height: 180 + (_controller.value * 15),
                          width: 180 + (_controller.value * 15),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white.withOpacity(0.1),
                          ),
                        );
                      },
                    ),
                    // Foto Profil Asli
                    Container(
                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 3),
                        image: DecorationImage(
                          image: NetworkImage(widget.teacherImage),
                          fit: BoxFit.cover,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const Spacer(flex: 2),

                // 3. TOMBOL KONTROL (Mute, End, Speaker)
                Container(
                  padding: const EdgeInsets.only(bottom: 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Tombol Mute
                      _buildCircleButton(
                        icon: _isMuted ? Icons.mic_off : Icons.mic,
                        isActive: _isMuted,
                        onTap: () => setState(() => _isMuted = !_isMuted),
                      ),

                      // Tombol End Call (Tutup)
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          height: 70,
                          width: 70,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.redAccent.withOpacity(0.5),
                                blurRadius: 20,
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

                      // Tombol Speaker
                      _buildCircleButton(
                        icon: _isSpeakerOn ? Icons.volume_up : Icons.volume_off,
                        isActive: _isSpeakerOn,
                        onTap: () =>
                            setState(() => _isSpeakerOn = !_isSpeakerOn),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Widget Helper untuk Tombol Samping
  Widget _buildCircleButton({
    required IconData icon,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              color: isActive ? Colors.white : Colors.white.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: isActive ? Colors.black : Colors.white,
              size: 28,
            ),
          ),
          const SizedBox(height: 8),
          // Label Text (Opsional)
        ],
      ),
    );
  }
}
