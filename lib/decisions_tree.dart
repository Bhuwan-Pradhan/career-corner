import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tmc/auth/login_page.dart';
import 'package:tmc/screens/mainPage.dart';
import '../../utils/colors.dart' as color;

class DecisionsTree extends StatefulWidget {
  const DecisionsTree({Key? key}) : super(key: key);

  @override
  State<DecisionsTree> createState() => _DecisionsTreeState();
}

class _DecisionsTreeState extends State<DecisionsTree> {
  User? user = FirebaseAuth.instance.currentUser;

  onRefresh(userCred) {
    setState(() {
      user = userCred;
    });
  }

  bool activeConnection = false;

  Future checkUserConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        setState(() {
          activeConnection = true;
        });
      }
    } on SocketException catch (_) {
      setState(() {
        activeConnection = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    checkUserConnection();
    onRefresh(FirebaseAuth.instance.currentUser);
    loading();
  }

  bool isloading = true;
  loading() async {
    await Future.delayed(Duration(seconds: 2));
    if (mounted) {
      setState(() {
        isloading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (activeConnection == true) {
      if (user == null) {
        return LoginScreen();
      }
      return MainPage();
    }
    return isloading
        ? Scaffold(
            body: Center(
            child:
                CircularProgressIndicator(color: color.AppColor.gradientSecond),
          ))
        : Scaffold(
            appBar: AppBar(
              title: const Text("Career Corner"),
            ),
            body: isloading
                ? Center(
                    child: CircularProgressIndicator(
                        color: color.AppColor.gradientSecond),
                  )
                : Center(
                    child: SizedBox(
                      child: Padding(
                        padding: const EdgeInsets.all(50.0),
                        child: Column(
                          children: [
                            Center(
                              child: Text(
                                "Please Turn on your \nInternet Connection",
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            OutlinedButton(
                                onPressed: () {
                                  checkUserConnection();
                                  setState(() {
                                    isloading = true;
                                  });
                                  loading();
                                },
                                child: const Text("Try Again"))
                          ],
                        ),
                      ),
                    ),
                  ),
          );
  }
}
