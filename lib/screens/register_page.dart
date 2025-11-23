import 'package:flutter/material.dart';
import '../constants.dart';
import '../widgets/fade_in_slide.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              const FadeInSlide(
                delay: 0.1,
                child: Text(
                  "Buat Akun Baru",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                    color: Colors.black87,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              const FadeInSlide(
                delay: 0.2,
                child: Text(
                  "Lengkapi data diri untuk menikmati fitur lengkap aplikasi.",
                  style: TextStyle(
                    fontSize: 15,
                    color: kGreyColor,
                    height: 1.5,
                  ),
                ),
              ),
              const SizedBox(height: 32),
              FadeInSlide(
                delay: 0.3,
                child: Column(
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: "Nama Lengkap",
                        prefixIcon: Icon(
                          Icons.person_outline,
                          size: 22,
                          color: kGreyColor,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: "Nomor HP",
                        prefixIcon: Icon(
                          Icons.phone_android_outlined,
                          size: 22,
                          color: kGreyColor,
                        ),
                      ),
                      keyboardType: TextInputType.phone,
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: "Email",
                        prefixIcon: Icon(
                          Icons.email_outlined,
                          size: 22,
                          color: kGreyColor,
                        ),
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      obscureText: _isObscure,
                      decoration: InputDecoration(
                        labelText: "Kata Sandi",
                        prefixIcon: const Icon(
                          Icons.lock_outline,
                          size: 22,
                          color: kGreyColor,
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isObscure
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                            size: 20,
                            color: kGreyColor,
                          ),
                          onPressed: () =>
                              setState(() => _isObscure = !_isObscure),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              FadeInSlide(
                delay: 0.4,
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Registrasi Berhasil!')),
                      );
                    },
                    child: const Text("Daftar"),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              FadeInSlide(
                delay: 0.5,
                child: Center(
                  child: Text(
                    "Dengan mendaftar, Anda menyetujui Syarat & Ketentuan serta Kebijakan Privasi kami.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: kGreyColor.withOpacity(0.8),
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
