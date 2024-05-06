import 'package:flutter/material.dart';

class Category {
  final String name;
  final String thumbnail;
  final int noOfCourses;

  Category({
    required this.name,
    required this.thumbnail,
    required this.noOfCourses,
  });
}

final List<Category> categoryList = [
  Category(
    name: 'Laptop Gaming',
    thumbnail:
        'assets/images/laptop.jpg', // Ganti dengan path file thumbnail yang sesuai
    noOfCourses: 5,
  ),
  Category(
    name: 'Modul Node Js',
    thumbnail:
        'assets/images/node.png', // Ganti dengan path file thumbnail yang sesuai
    noOfCourses: 8,
  ),
  Category(
    name: 'Modul React Js',
    thumbnail:
        'assets/images/react.jpg', // Ganti dengan path file thumbnail yang sesuai
    noOfCourses: 8,
  ),
  // Tambahkan kategori lain jika diperlukan
];
