import 'package:flutter/material.dart';

import 'package:tmc/screens/courses/course_screen.dart';
import 'package:tmc/screens/home/home_page.dart';
import 'package:tmc/screens/jobs/jobs.dart';
import 'package:tmc/screens/profile/profile_page.dart';
import 'package:line_icons/line_icons.dart';

class MainPage extends StatefulWidget {
  const MainPage({
    Key? key,
  }) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;
  final pages = [
    HomePage(),
    Courses(),
    Jobs(),
    Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: Colors.black54,
        selectedItemColor: Color(0xFF6985e8),
        selectedFontSize: 20,
        unselectedFontSize: 15,
        backgroundColor: Colors.white,
        items: [
          BottomNavigationBarItem(icon: Icon(LineIcons.home), label: "home"),
          BottomNavigationBarItem(icon: Icon(LineIcons.store), label: "course"),
          BottomNavigationBarItem(
              icon: Icon(LineIcons.certificate), label: "jobs"),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_2_outlined), label: "Profile")
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
