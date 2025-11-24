import 'package:flutter/material.dart';
import '../constants.dart';
import '../widgets/fade_in_slide.dart';
import 'permission_page.dart'; // Kita akan buat ini setelahnya
import 'e_raport_page.dart';
import 'e_kantin_page.dart';
import 'ekskul_page.dart';
import 'organization_page.dart';
import 'calendar_page.dart';
import 'settings_page.dart';
import 'help_page.dart';

class MoreMenuPage extends StatelessWidget {
  const MoreMenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Data Menu Tambahan
    final List<Map<String, dynamic>> _extraMenus = [
      {
        "label": "Perizinan",
        "icon": Icons.assignment_turned_in,
        "color": Colors.teal,
        "page": const PermissionPage(),
      },
      {
        "label": "E-Raport",
        "icon": Icons.assessment,
        "color": Colors.blue,
        "page": const ERaportPage(),
      },
      {
        "label": "E-Kantin",
        "icon": Icons.restaurant_menu,
        "color": Colors.orange,
        "page": const EKantinPage(),
      },
      {
        "label": "Ekskul",
        "icon": Icons.sports_basketball,
        "color": Colors.red,
        "page": const EkskulPage(),
      },
      {
        "label": "Organisasi",
        "icon": Icons.groups,
        "color": Colors.purple,
        "page": const OrganizationPage(),
      },
      {
        "label": "Kalender",
        "icon": Icons.calendar_today,
        "color": Colors.indigo,
        "page": const CalendarPage(),
      },
      {
        "label": "Pengaturan",
        "icon": Icons.settings,
        "color": Colors.grey,
        "page": const SettingsPage(),
      },
      {
        "label": "Bantuan",
        "icon": Icons.help_outline,
        "color": Colors.green,
        "page": const HelpPage(),
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        title: const Text(
          "Menu Lainnya",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: GridView.builder(
          itemCount: _extraMenus.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            mainAxisSpacing: 20,
            crossAxisSpacing: 12,
            childAspectRatio: 0.8,
          ),
          itemBuilder: (context, index) {
            final menu = _extraMenus[index];
            return FadeInSlide(
              delay: index * 0.05,
              child: GestureDetector(
                onTap: () {
                  if (menu['page'] != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => menu['page']),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Fitur segera hadir!")),
                    );
                  }
                },
                child: Column(
                  children: [
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        color: (menu['color'] as Color).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(menu['icon'], color: menu['color'], size: 24),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      menu['label'],
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 11,
                        color: Colors.black87,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
