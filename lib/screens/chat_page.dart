import 'package:flutter/material.dart';
import '../constants.dart';
import 'video_call_page.dart';
import 'voice_call_page.dart';

class ChatPage extends StatefulWidget {
  final String teacherName;
  final String teacherImage;
  final String status;

  const ChatPage({
    super.key,
    required this.teacherName,
    required this.teacherImage,
    required this.status,
  });

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  // Dummy Percakapan Awal
  final List<Map<String, dynamic>> _messages = [
    {
      "text": "Selamat pagi, Pak. Maaf mengganggu waktunya.",
      "isSender": true,
      "time": "08:00",
    },
    {
      "text": "Pagi juga, Nak. Ada yang bisa Bapak bantu?",
      "isSender": false,
      "time": "08:05",
    },
    {
      "text":
          "Saya ingin bertanya mengenai tugas RPL kemarin, apakah deadline-nya bisa diperpanjang?",
      "isSender": true,
      "time": "08:06",
    },
    {
      "text":
          "Bisa, Nak. Bapak perpanjang sampai hari Jumat ya. Jangan lupa dikerjakan dengan teliti.",
      "isSender": false,
      "time": "08:10",
    },
    {
      "text": "Baik Pak, terima kasih banyak!",
      "isSender": true,
      "time": "08:11",
    },
  ];

  void _sendMessage() {
    if (_messageController.text.trim().isEmpty) return;

    setState(() {
      _messages.insert(0, {
        // Masukkan ke index 0 karena list kita reverse
        "text": _messageController.text,
        "isSender": true,
        "time":
            "${DateTime.now().hour}:${DateTime.now().minute.toString().padLeft(2, '0')}",
      });
    });
    _messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE5E9F0), // Warna background ala chat app
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
            CircleAvatar(
              radius: 18,
              backgroundImage: NetworkImage(widget.teacherImage),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.teacherName,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  widget.status,
                  style: TextStyle(
                    fontSize: 12,
                    color: widget.status == 'Online'
                        ? Colors.green
                        : Colors.grey,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          // TOMBOL VIDEO CALL
          IconButton(
            icon: const Icon(Icons.videocam_outlined, color: kTelkomRed),
            onPressed: () {
              // Navigasi ke Video Call Page
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => VideoCallPage(
                    teacherName: widget.teacherName, // Kirim Nama Guru
                    teacherImage: widget.teacherImage, // Kirim Foto Guru
                  ),
                ),
              );
            },
          ),
          // TOMBOL VOICE CALL (Update Bagian Ini)
          IconButton(
            icon: const Icon(Icons.call_outlined, color: kTelkomRed),
            onPressed: () {
              // Navigasi ke Voice Call Page
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => VoiceCallPage(
                    teacherName: widget.teacherName, // Kirim Data Nama
                    teacherImage: widget.teacherImage, // Kirim Data Foto
                  ),
                ),
              );
            },
          ),
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
              reverse: true, // Chat mulai dari bawah
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

          // INPUT FIELD
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            color: Colors.white,
            child: SafeArea(
              child: Row(
                children: [
                  const Icon(Icons.add, color: kTelkomRed),
                  const SizedBox(width: 12),
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
                          hintText: "Ketik pesan...",
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(vertical: 14),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
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
