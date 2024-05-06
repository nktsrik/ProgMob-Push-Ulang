import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simpan_pinjam/utils/global.colors.dart';
import 'package:simpan_pinjam/view/login.view.dart';

class SplashView extends StatelessWidget {
  // ignore: use_super_parameters
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 2), () {
      Get.to(LoginView());
    });
    return Scaffold(
      backgroundColor: GlobalColors.mainColor,
      body: const Center(
        child: Text(
          'BankHeart',
          style: TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
