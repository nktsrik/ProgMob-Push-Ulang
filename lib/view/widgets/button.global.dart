import 'package:flutter/material.dart';
import 'package:simpan_pinjam/utils/global.colors.dart';
//import 'package:simpan_pinjam/view/dashboard.view.dart'; // Ganti 'dashboard.dart' dengan nama file yang sesuai

class ButtonGlobal extends StatelessWidget {
  final String text;
  final VoidCallback onPressed; // Tambahkan parameter onPressed

  const ButtonGlobal({
    required this.text,
    required this.onPressed, // Tambahkan parameter onPressed ke constructor
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed, // Gunakan callback onPressed di sini
      child: Container(
        alignment: Alignment.center,
        height: 55,
        decoration: BoxDecoration(
          color: GlobalColors.mainColor,
          borderRadius: BorderRadius.circular(6),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
            ),
          ],
        ),
        child: Text(
          text, // Gunakan text dari parameter
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w300,
          ),
        ),
      ),
    );
  }
}
