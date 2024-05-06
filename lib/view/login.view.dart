import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:simpan_pinjam/utils/global.colors.dart';
import 'package:simpan_pinjam/view/dashboard.view.dart';
import 'package:simpan_pinjam/view/signup.view.dart';
import 'package:simpan_pinjam/view/widgets/button.global.dart';
import 'package:simpan_pinjam/view/widgets/socialLogin.dart';
import 'package:simpan_pinjam/view/widgets/text.form.global.dart';
import 'package:get_storage/get_storage.dart';

class LoginView extends StatelessWidget {
  LoginView({Key? key}) : super(key: key);
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _dio = Dio();
  final _storage = GetStorage();
  final _apiUrl = 'https://mobileapis.manpits.xyz/api/login';

  void _login(BuildContext context) async {
    // Validasi email dan password
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (email.isNotEmpty && password.isNotEmpty) {
      try {
        // Membuat permintaan HTTP POST untuk login
        final response = await _dio.post(
          _apiUrl,
          data: {
            'email': email,
            'password': password,
          },
        );

        // Memeriksa apakah respons berhasil
        if (response.statusCode == 200) {
          // Simpan token dalam kelas TokenManager
          _storage.write('token', response.data['data']['token']);

          // Navigasi ke halaman dashboard jika berhasil login
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Dashboard()),
          );
        } else {
          // Menampilkan pesan kesalahan jika login gagal
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Login gagal, silahkan coba lagi'),
            ),
          );
        }
      } catch (error) {
        // Menampilkan pesan kesalahan jika terjadi kesalahan saat melakukan permintaan HTTP
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Kesalahan Pada API.'),
          ),
        );
      }
    } else {
      // Menampilkan pesan kesalahan jika email atau password kosong
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please fill in email and password.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    'HeartBank',
                    style: TextStyle(
                      color: GlobalColors.mainColor,
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 50),
                Text(
                  'Login to your account',
                  style: TextStyle(
                    color: GlobalColors.textColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                // Email input
                const SizedBox(height: 15),
                TextFormGlobal(
                  controller: emailController,
                  text: 'Email',
                  obscure: false,
                  textInputType: TextInputType.emailAddress,
                ),

                const SizedBox(height: 10),

                // Password input
                TextFormGlobal(
                  controller: passwordController,
                  text: 'Password',
                  textInputType: TextInputType.text,
                  obscure: true,
                ),
                const SizedBox(height: 10),
                ButtonGlobal(
                  text: 'Login',
                  onPressed: () => _login(context), // Call login function
                ),
                const SizedBox(height: 25),
                SocialLogin(),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 50,
        color: Colors.white,
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Don\'t have an account',
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SignUpScreen(key: UniqueKey()),
                  ),
                );
              },
              child: Text(
                ' Sign Up',
                style: TextStyle(
                  color: GlobalColors.mainColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
