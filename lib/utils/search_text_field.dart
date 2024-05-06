import 'package:flutter/material.dart';
import 'package:simpan_pinjam/utils/global.colors.dart'; 

class SearchTextField extends StatelessWidget {
  const SearchTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            spreadRadius: 0.1,
          ),
        ],
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search',
          hintStyle: TextStyle(
            color: GlobalColors.textColor.withOpacity(0.5), // Gunakan warna teks dari GlobalColors
          ),
          border: InputBorder.none,
          icon: Icon(
            Icons.search,
            color: GlobalColors.textColor.withOpacity(0.5), // Gunakan warna teks dari GlobalColors
          ),
        ),
      ),
    );
  }
}
