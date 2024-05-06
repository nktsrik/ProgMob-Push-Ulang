import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:simpan_pinjam/view/login.view.dart';

class UserModel {
  final String name;

  UserModel({required this.name});
}

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late Future<void> _userFuture;
  final Dio _dio = Dio();
  final _storage = GetStorage();
  final String _apiUrl = 'https://mobileapis.manpits.xyz/api/user';
  String name = "";

  @override
  void initState() {
    super.initState();
    _userFuture = fetchUser();
  }

  Future<void> fetchUser() async {
    // Periksa apakah token tersedia
    final String? authToken = _storage.read('token');
    if (authToken == null) {
      throw Exception('Token not available');
    }

    try {
      final response = await _dio.get(
        _apiUrl,
        options: Options(
          headers: {'Authorization': 'Bearer $authToken'},
        ),
      );

      print(response.data);
      final username = response.data['data']['user']['name'];

      setState(() {
        name = username;
      });

      // if (response.statusCode == 200) {
      //   return UserModel.fromJson(jsonDecode(response.data.toString()));
      // } else {
      //   throw Exception('Failed to load user');
      // }
    } on DioError catch (e) {
      print('${e.response} - ${e.response?.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder<void>(
          future: _userFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 20),
                  Text(
                    name, // Menggunakan variabel name yang sudah diupdate dari respons API
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      // Navigasi ke halaman login
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              LoginView(), // Ganti dengan nama halaman login yang benar
                        ),
                      );
                    },
                    child: Text('Logout'),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
