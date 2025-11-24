import 'package:flutter/material.dart';
import '../constants.dart';
import '../widgets/fade_in_slide.dart';
import 'login_page.dart'; // Import Login Page untuk fitur Logout

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  // State untuk Switch (Toggle)
  bool _notifEnabled = true;
  bool _darkMode = false;
  bool _biometricEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        title: const Text(
          "Pengaturan",
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. PROFILE SUMMARY
            FadeInSlide(
              delay: 0.1,
              child: Container(
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
                    const CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(
                        'https://i.pravatar.cc/150?img=12',
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Rizky Fauzan",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          Text(
                            "XI RPL 2 | 543211",
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.edit_square, color: kTelkomRed),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Edit Profil")),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // 2. GROUP: AKUN
            _buildSectionHeader("Akun"),
            _buildSettingsTile(
              icon: Icons.lock_outline,
              title: "Ganti Kata Sandi",
              onTap: () {},
            ),
            _buildSettingsTile(
              icon: Icons.privacy_tip_outlined,
              title: "Privasi & Keamanan",
              onTap: () {},
            ),
            _buildSwitchTile(
              icon: Icons.fingerprint,
              title: "Login Biometrik",
              value: _biometricEnabled,
              onChanged: (val) => setState(() => _biometricEnabled = val),
            ),

            const SizedBox(height: 24),

            // 3. GROUP: TAMPILAN & NOTIFIKASI
            _buildSectionHeader("Preferensi"),
            _buildSwitchTile(
              icon: Icons.notifications_outlined,
              title: "Notifikasi Push",
              value: _notifEnabled,
              onChanged: (val) => setState(() => _notifEnabled = val),
            ),
            _buildSwitchTile(
              icon: Icons.dark_mode_outlined,
              title: "Mode Gelap",
              value: _darkMode,
              onChanged: (val) => setState(() => _darkMode = val),
            ),
            _buildSettingsTile(
              icon: Icons.language,
              title: "Bahasa",
              trailingText: "Indonesia",
              onTap: () {},
            ),

            const SizedBox(height: 24),

            // 4. GROUP: LAINNYA
            _buildSectionHeader("Lainnya"),
            _buildSettingsTile(
              icon: Icons.help_outline,
              title: "Pusat Bantuan",
              onTap: () {},
            ),
            _buildSettingsTile(
              icon: Icons.info_outline,
              title: "Tentang Aplikasi",
              trailingText: "v1.0.0",
              onTap: () {},
            ),

            const SizedBox(height: 40),

            // 5. TOMBOL LOGOUT
            FadeInSlide(
              delay: 0.5,
              child: SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () => _showLogoutDialog(context),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    side: const BorderSide(color: Colors.red),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    "KELUAR APLIKASI",
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // --- WIDGET BUILDERS ---

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12, left: 4),
      child: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.grey,
          fontSize: 14,
        ),
      ),
    );
  }

  // Tile Biasa (Navigasi)
  Widget _buildSettingsTile({
    required IconData icon,
    required String title,
    String? trailingText,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        onTap: onTap,
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color(0xFFF5F7FA),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: Colors.black87, size: 20),
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
        ),
        trailing: trailingText != null
            ? Text(
                trailingText,
                style: const TextStyle(color: Colors.grey, fontSize: 12),
              )
            : const Icon(Icons.chevron_right, color: Colors.grey),
      ),
    );
  }

  // Tile Switch (Toggle)
  Widget _buildSwitchTile({
    required IconData icon,
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: SwitchListTile(
        value: value,
        onChanged: onChanged,
        activeColor: kTelkomRed,
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
        ),
        secondary: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color(0xFFF5F7FA),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: Colors.black87, size: 20),
        ),
      ),
    );
  }

  // Dialog Konfirmasi Logout
  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Konfirmasi"),
        content: const Text("Apakah Anda yakin ingin keluar dari aplikasi?"),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Batal", style: TextStyle(color: Colors.grey)),
          ),
          TextButton(
            onPressed: () {
              // Hapus semua stack dan kembali ke Login Page
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
                (route) => false,
              );
            },
            child: const Text(
              "Ya, Keluar",
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
