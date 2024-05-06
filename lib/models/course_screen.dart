import 'package:flutter/material.dart';

class CourseScreen extends StatelessWidget {
  const CourseScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Implementasi tampilan halaman CourseScreen
    return Scaffold(
      appBar: AppBar(
        title: const Text('Course Details'),
      ),
      body: const Center(
        child: Text('Course Screen Content'),
      ),
    );
  }
}
