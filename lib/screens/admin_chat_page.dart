import 'package:flutter/material.dart';
import 'dart:async'; // Untuk timer simulasi balasan
import '../constants.dart';

class AdminChatPage extends StatefulWidget {
  const AdminChatPage({super.key});

  @override
  State<AdminChatPage> createState() => _AdminChatPageState();
}

class _AdminChatPageState extends State<AdminChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _isTyping = false;

  // Data Pesan Awal
  final List<Map<String, dynamic>> _messages = [
    {
      "text":
          "Halo! 👋\nSelamat datang di Layanan Bantuan IT SMK Telkom.\nAda yang bisa kami bantu hari ini?",
      "isSender": false,
      "time": "Sekarang",
      "type": "text",
    },
  ];

  void _sendMessage() {
    String text = _messageController.text.trim();
    if (text.isEmpty) return;

    // 1. Tambah Pesan Siswa
    setState(() {
      _messages.insert(0, {
        "text": text,
        "isSender": true,
        "time":
            "${DateTime.now().hour}:${DateTime.now().minute.toString().padLeft(2, '0')}",
        "type": "text",
      });
      _isTyping = true; // Admin seolah-olah mengetik
    });
    _messageController.clear();

    // 2. Simulasi Admin Mengetik & Membalas
    Timer(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _isTyping = false;
          _messages.insert(0, {
            "text":
                "Terima kasih atas laporannya. Tim IT kami akan segera mengecek kendala tersebut. Mohon tunggu sebentar ya.",
            "isSender": false,
            "time":
                "${DateTime.now().hour}:${DateTime.now().minute.toString().padLeft(2, '0')}",
            "type": "text",
          });
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE5E9F0),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leadingWidth: 40,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          children: [
            Stack(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.support_agent,
                    color: Colors.blue,
                    size: 24,
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 1.5),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "Admin Sekolah",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Online",
                  style: TextStyle(fontSize: 12, color: Colors.green),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert, color: Colors.black),
          ),
        ],
      ),
      body: Column(
        children: [
          // LIST PESAN
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              reverse: true,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                final isSender = message['isSender'];

                return Align(
                  alignment: isSender
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(12),
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.75,
                    ),
                    decoration: BoxDecoration(
                      color: isSender ? kTelkomRed : Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(16),
                        topRight: const Radius.circular(16),
                        bottomLeft: Radius.circular(isSender ? 16 : 0),
                        bottomRight: Radius.circular(isSender ? 0 : 16),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 5,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          message['text'],
                          style: TextStyle(
                            color: isSender ? Colors.white : Colors.black87,
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          message['time'],
                          style: TextStyle(
                            color: isSender ? Colors.white70 : Colors.grey,
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          // INDIKATOR MENGETIK (TYPING)
          if (_isTyping)
            Padding(
              padding: const EdgeInsets.only(left: 20, bottom: 10),
              child: Row(
                children: [
                  const Text(
                    "Admin sedang mengetik",
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                  const SizedBox(width: 4),
                  SizedBox(
                    width: 10,
                    height: 10,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),

          // INPUT FIELD
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            color: Colors.white,
            child: SafeArea(
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.add_photo_alternate,
                      color: kTelkomRed,
                    ),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Kirim Screenshot Error..."),
                        ),
                      );
                    },
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: TextField(
                        controller: _messageController,
                        decoration: const InputDecoration(
                          hintText: "Tulis keluhan...",
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(vertical: 14),
                        ),
                        onSubmitted: (_) => _sendMessage(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: _sendMessage,
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: const BoxDecoration(
                        color: kTelkomRed,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.send,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
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
