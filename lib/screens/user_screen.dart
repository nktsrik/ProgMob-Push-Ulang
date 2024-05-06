import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:simpan_pinjam/view/login.view.dart';

class UserModel {
  String name;
  String address;
  String dateOfBirth;
  String phoneNumber;
  bool isActive;

  UserModel({
    required this.name,
    required this.address,
    required this.dateOfBirth,
    required this.phoneNumber,
    required this.isActive,
  });
}

class UserCardScreen extends StatefulWidget {
  const UserCardScreen({Key? key}) : super(key: key);

  @override
  _UserCardScreenState createState() => _UserCardScreenState();
}

class _UserCardScreenState extends State<UserCardScreen> {
  late List<UserModel> users = []; // Inisialisasi users dengan list kosong
  final Dio _dio = Dio();
  final _storage = GetStorage();

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final String? authToken = _storage.read('token');
    if (authToken == null) {
      throw Exception('Token not available');
    }

    try {
      final response = await _dio.get(
        'https://mobileapis.manpits.xyz/api/anggota',
        options: Options(
          headers: {'Authorization': 'Bearer $authToken'},
        ),
      );

      if (response.statusCode == 200) {
        List<dynamic> data = response.data;

        List<UserModel> userList = data.map((item) {
          return UserModel(
            name: item['nama'],
            address: item['alamat'],
            dateOfBirth: item['tgl_lahir'],
            phoneNumber: item['telepon'],
            isActive: item['status_aktif'],
          );
        }).toList();

        setState(() {
          users = userList;
        });
      } else {
        print('Failed to fetch data');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User List'),
      ),
      body: users.isNotEmpty // Memeriksa apakah users sudah diinisialisasi
          ? ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                return UserCard(user: users[index]);
              },
            )
          : Center(child: CircularProgressIndicator()),
    );
  }
}

class UserCard extends StatelessWidget {
  final UserModel user;

  const UserCard({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: ListTile(
        title: Text(user.name),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Address: ${user.address}'),
            Text('Date of Birth: ${user.dateOfBirth}'),
            Text('Phone Number: ${user.phoneNumber}'),
            Text('Active Status: ${user.isActive ? 'Active' : 'Inactive'}'),
          ],
        ),
        onTap: () {
          // Do something when card is tapped
        },
      ),
    );
  }
}
