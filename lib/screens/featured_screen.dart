import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:simpan_pinjam/models/category.dart';
import 'package:simpan_pinjam/models/course_screen.dart';
import 'package:simpan_pinjam/utils/global.colors.dart';
import 'package:simpan_pinjam/utils/search_text_field.dart';

class FeaturedScreen extends StatelessWidget {
  const FeaturedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        appBar: CustomAppBar(),
        body: Body(),
      ),
    );
  }
}

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  @override
  _CustomAppBarState createState() => _CustomAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(200);
}

class _CustomAppBarState extends State<CustomAppBar> {
  late String _username = ''; // State untuk menyimpan nama pengguna
  final _dio = Dio();
  final _storage = GetStorage();

  @override
  void initState() {
    super.initState();
    fetchUserData(); // Panggil fungsi untuk mengambil data pengguna
  }

  Future<void> fetchUserData() async {
    final String? authToken = _storage.read('token');
    if (authToken == null) {
      throw Exception('Token not available');
    }

    try {
      final response = await _dio.get(
        'https://mobileapis.manpits.xyz/api/user',
        options: Options(
          headers: {'Authorization': 'Bearer $authToken'},
        ),
      );

      print(response.data);
      final username = response.data['data']['user']['name'];
      setState(() {
        _username = username;
      });

      // if (response.statusCode == 200) {
      //   print(response.data);
      //   final username = response.data['data']['user']['name'];
      //   setState(() {
      //     _username = username['name'];
      //   });
      // } else {
      //   print('Failed to fetch user data');
      // }
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: [0.1, 0.5],
          colors: [
            GlobalColors.mainColor.withOpacity(0.8),
            GlobalColors.mainColor.withOpacity(0.6),
          ],
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Hello,\n$_username", // Tampilkan nama pengguna di sini
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.notifications,
                  color: Colors.white,
                  size: 24,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const SearchTextField(),
        ],
      ),
    );
  }
}

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Explore Categories",
                style: TextStyle(
                  color: GlobalColors.textColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  "See All",
                  style: TextStyle(
                    color: GlobalColors.mainColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            ],
          ),
        ),
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.8,
              crossAxisSpacing: 20,
              mainAxisSpacing: 24,
            ),
            itemBuilder: (context, index) {
              return CategoryCard(
                category: categoryList[index],
              );
            },
            itemCount: categoryList.length,
          ),
        ),
      ],
    );
  }
}

class CategoryCard extends StatelessWidget {
  final Category category;
  const CategoryCard({
    Key? key,
    required this.category,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CourseScreen(),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.1),
              blurRadius: 4.0,
              spreadRadius: .05,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Image.asset(
                category.thumbnail,
                height: 100,
              ),
            ),
            const SizedBox(height: 10),
            Text(category.name),
            Text(
              "${category.noOfCourses.toString()} courses",
              style: TextStyle(
                color: GlobalColors.textColor,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
