import 'package:flutter/material.dart';
import 'package:simpan_pinjam/utils/global.colors.dart';
import 'package:simpan_pinjam/screens/featured_screen.dart';
import 'package:simpan_pinjam/screens/profile_screen.dart';
import 'package:simpan_pinjam/screens/user_screen.dart';

class BaseScreen extends StatefulWidget {
  const BaseScreen({Key? key}) : super(key: key);

  @override
  _BaseScreenState createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    FeaturedScreen(),
    FeaturedScreen(),
    UserCardScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor:
            GlobalColors.mainColor, // Gunakan warna utama dari GlobalColors
        backgroundColor: Colors.white,
        elevation: 0,
        items: [
          BottomNavigationBarItem(
            activeIcon: Image.asset(
              'assets/images/star.png',
              height: 24,
            ),
            icon: Image.asset(
              'assets/images/star_outlined.png',
              height: 24,
            ),
            label: "Home",
          ),
          BottomNavigationBarItem(
            activeIcon: Image.asset(
              'assets/images/play.png',
              height: 24,
            ),
            icon: Image.asset(
              'assets/images/play_outlined.png',
              height: 24,
            ),
            label: "My Learning",
          ),
          BottomNavigationBarItem(
            activeIcon: Image.asset(
              'assets/images/heart.png',
              height: 24,
            ),
            icon: Image.asset(
              'assets/images/heart_outlined.png',
              height: 24,
            ),
            label: "User List",
          ),
          BottomNavigationBarItem(
            activeIcon: Image.asset(
              'assets/images/settings.png',
              height: 24,
            ),
            icon: Image.asset(
              'assets/images/settings_outlined.png',
              height: 24,
            ),
            label: "Settings",
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
