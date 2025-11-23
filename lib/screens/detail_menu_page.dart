import 'package:flutter/material.dart';
import '../constants.dart';
import '../widgets/fade_in_slide.dart';

class DetailMenuPage extends StatefulWidget {
  final Map<String, dynamic> menu; // Menerima data menu

  const DetailMenuPage({super.key, required this.menu});

  @override
  State<DetailMenuPage> createState() => _DetailMenuPageState();
}

class _DetailMenuPageState extends State<DetailMenuPage> {
  int _qty = 1;

  // Helper Format Rupiah
  String _formatRupiah(int number) {
    return "Rp ${number.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}";
  }

  void _incrementQty() {
    setState(() => _qty++);
  }

  void _decrementQty() {
    if (_qty > 1) setState(() => _qty--);
  }

  @override
  Widget build(BuildContext context) {
    // Hitung total harga berdasarkan qty
    int totalPrice = (widget.menu['price'] as int) * _qty;

    return Scaffold(
      body: Stack(
        children: [
          // 1. GAMBAR MAKANAN (FULL SCREEN ATAS)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: MediaQuery.of(context).size.height * 0.45,
            child: Image.network(widget.menu['image'], fit: BoxFit.cover),
          ),

          // 2. TOMBOL BACK & FAVORITE
          Positioned(
            top: 50,
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.arrow_back, color: Colors.black),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Ditambahkan ke Favorit ❤️"),
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.favorite_border, color: Colors.red),
                  ),
                ),
              ],
            ),
          ),

          // 3. KONTEN DETAIL (SHEET PUTIH)
          Positioned(
            top: MediaQuery.of(context).size.height * 0.4,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.fromLTRB(
                24,
                30,
                24,
                100,
              ), // Padding bawah besar utk tombol
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Badge Stand Kantin
                    FadeInSlide(
                      delay: 0.1,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: kTelkomRed.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.store,
                              size: 16,
                              color: kTelkomRed,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              widget.menu['stand'],
                              style: const TextStyle(
                                color: kTelkomRed,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Judul & Rating
                    FadeInSlide(
                      delay: 0.2,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              widget.menu['name'],
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                height: 1.2,
                              ),
                            ),
                          ),
                          Column(
                            children: [
                              const Icon(
                                Icons.star,
                                color: Colors.amber,
                                size: 28,
                              ),
                              Text(
                                "${widget.menu['rating']}",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 8),
                    FadeInSlide(
                      delay: 0.3,
                      child: Text(
                        _formatRupiah(widget.menu['price']),
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: kTelkomRed,
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),
                    const Divider(),
                    const SizedBox(height: 16),

                    // Deskripsi Dummy
                    const FadeInSlide(
                      delay: 0.4,
                      child: Text(
                        "Deskripsi",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    FadeInSlide(
                      delay: 0.5,
                      child: Text(
                        "Nikmati kelezatan ${widget.menu['name']} yang dibuat dengan bahan-bahan pilihan berkualitas. Cocok untuk menemani istirahat makan siangmu di sekolah. Pesan sekarang sebelum kehabisan!",
                        style: TextStyle(color: Colors.grey[600], height: 1.6),
                      ),
                    ),

                    const SizedBox(height: 20),
                    const FadeInSlide(
                      delay: 0.6,
                      child: Text(
                        "Catatan (Opsional)",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    FadeInSlide(
                      delay: 0.7,
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "Contoh: Jangan pakai pedas...",
                          filled: true,
                          fillColor: const Color(0xFFF5F7FA),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // 4. BOTTOM BAR (QTY & ADD TO CART)
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 20,
                    offset: const Offset(0, -5),
                  ),
                ],
              ),
              child: Row(
                children: [
                  // QTY CONTROL
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5F7FA),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: _decrementQty,
                          icon: const Icon(Icons.remove),
                        ),
                        Text(
                          "$_qty",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        IconButton(
                          onPressed: _incrementQty,
                          icon: const Icon(Icons.add),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),

                  // ADD BUTTON
                  Expanded(
                    child: SizedBox(
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          // Kirim data kembali ke halaman sebelumnya (E-Kantin)
                          Navigator.pop(context, {
                            'qty': _qty,
                            'menu': widget.menu,
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: kTelkomRed,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 0,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Tambah",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              _formatRupiah(totalPrice),
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
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
