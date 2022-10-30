import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:getwidget/components/avatar/gf_avatar.dart';
import 'package:getwidget/components/drawer/gf_drawer.dart';
import 'package:getwidget/components/drawer/gf_drawer_header.dart';

import 'package:tmc/screens/courses/course_screen.dart';
import 'package:tmc/screens/drawer_widgets/about.dart';
import 'package:tmc/screens/drawer_widgets/contact.dart';
import 'package:tmc/screens/drawer_widgets/more.dart';

import 'package:tmc/screens/jobs/jobs.dart';
import 'package:tmc/screens/mainPage.dart';
import 'package:tmc/screens/profile/profile_page.dart';
import '../../utils/colors.dart' as color;
import 'package:line_icons/line_icons.dart';

class Mydrawer extends StatefulWidget {
  const Mydrawer({super.key});

  @override
  State<Mydrawer> createState() => _MydrawerState();
}

class _MydrawerState extends State<Mydrawer> {
  String _userName = "";
  String _image = "";
  String _email = "";
  void getUserData() async {
    var collection = FirebaseFirestore.instance.collection('users');
    var docSnapshot =
        await collection.doc(FirebaseAuth.instance.currentUser!.uid).get();
    if (docSnapshot.exists) {
      Map<String, dynamic>? data = docSnapshot.data();
      var userName = data?['userName']; // <-- The value you want to retrieve.
      var image = data?['image']; // <-- The value you want to retrieve.
      var email = data?['email']; // <-- The value you want to retrieve.
      // Call setState if needed.
      setState(() {
        _userName = userName;
        _image = image;
        _email = email;
      });
    }
  }

  @override
  void initState() {
    getUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: OvalRightBorderClipper(),
      child: GFDrawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            GFDrawerHeader(
              decoration: BoxDecoration(
                color: color.AppColor.gradientSecond,
              ),
              currentAccountPicture: GFAvatar(
                radius: 80.0,
                backgroundImage: NetworkImage(_image),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    _userName,
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  Text(
                    _email,
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10.0),
            _buildRow(LineIcons.home, "Home", MainPage()),
            _buildDivider(),
            _buildRow(Icons.person_2_outlined, "My profile", Profile()),
            _buildDivider(),
            _buildRow(LineIcons.copy, "About Us", About()),
            _buildDivider(),
            _buildRow(LineIcons.store, "Courses", Courses()),
            _buildDivider(),
            _buildRow(LineIcons.certificate, "Upcoming Jobs", Jobs()),
            _buildDivider(),
            _buildRow(Icons.contact_mail_outlined, "Contact Us", Contact()),
            _buildDivider(),
            _buildRow(Icons.more_horiz_outlined, "More", More()),
            _buildDivider(),
          ],
        ),
      ),
    );
  }

  Divider _buildDivider() {
    return Divider(
      color: Colors.black,
    );
  }

  Widget _buildRow(IconData icon, String title, Widget widget) {
    final TextStyle tStyle = TextStyle(color: Colors.black, fontSize: 16.0);
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => widget),
        );
      },
      child: Container(
        padding: const EdgeInsets.only(top: 10, bottom: 10, left: 10),
        child: Row(children: [
          Icon(
            icon,
            color: Colors.black,
          ),
          SizedBox(width: 10.0),
          Text(
            title,
            style: tStyle,
          ),
          Spacer(),
        ]),
      ),
    );
  }
}
