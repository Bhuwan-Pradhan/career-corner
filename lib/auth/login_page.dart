import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:tmc/auth/reset_password.dart';
import 'package:tmc/auth/signUp_page.dart';

import 'package:tmc/screens/mainPage.dart';

import '../../utils/colors.dart' as color;

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();
  User? user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
  }

  Widget _buildPageContent(BuildContext context) {
    return Container(
      color: color.AppColor.card,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 50.0,
            ),
            Container(
              height: 200,
              width: 220,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                      image: AssetImage(
                        "assets/logo.jpg",
                      ),
                      fit: BoxFit.cover)),
            ),
            SizedBox(
              height: 20.0,
            ),
            _buildLoginForm(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => SignUpScreen()));
                  },
                  child: Text("New User? Create New Account",
                      style: TextStyle(
                          color: color.AppColor.gradientFirst, fontSize: 18.0)),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Container _buildLoginForm() {
    return Container(
      padding: EdgeInsets.all(20.0),
      child: Stack(
        children: <Widget>[
          ClipPath(
            clipper: RoundedDiagonalPathClipper(),
            child: Container(
              height: 400,
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(40.0)),
                color: Colors.white,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 90.0,
                  ),
                  Container(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: TextField(
                        controller: _emailTextController,
                        style: TextStyle(color: color.AppColor.gradientFirst),
                        decoration: InputDecoration(
                            hintText: "Email address",
                            hintStyle: TextStyle(color: color.AppColor.card),
                            border: InputBorder.none,
                            icon: Icon(
                              Icons.email,
                              color: color.AppColor.gradientFirst,
                            )),
                      )),
                  Container(
                    child: Divider(
                      color: color.AppColor.card,
                    ),
                    padding:
                        EdgeInsets.only(left: 20.0, right: 20.0, bottom: 10.0),
                  ),
                  Container(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: TextField(
                        obscureText: true,
                        enableSuggestions: false,
                        autocorrect: false,
                        keyboardType: TextInputType.visiblePassword,
                        controller: _passwordTextController,
                        style: TextStyle(color: color.AppColor.gradientFirst),
                        decoration: InputDecoration(
                            hintText: "Password",
                            hintStyle: TextStyle(color: color.AppColor.card),
                            border: InputBorder.none,
                            icon: Icon(
                              Icons.lock,
                              color: color.AppColor.gradientFirst,
                            )),
                      )),
                  Container(
                    child: Divider(
                      color: color.AppColor.card,
                    ),
                    padding:
                        EdgeInsets.only(left: 20.0, right: 20.0, bottom: 10.0),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      ResetPassword()));
                        },
                        child: Container(
                            padding: EdgeInsets.only(right: 20.0),
                            child: Text(
                              "Forgot Password ?",
                              style: TextStyle(
                                  color: color.AppColor.gradientFirst,
                                  fontSize: 15),
                            )),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(
                radius: 40.0,
                backgroundColor: color.AppColor.gradientSecond,
                child: Icon(Icons.person),
              ),
            ],
          ),
          Container(
            height: 420,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: ElevatedButton(
                onPressed: () async {
                  try {
                    await FirebaseAuth.instance.signInWithEmailAndPassword(
                        email: _emailTextController.text,
                        password: _passwordTextController.text);
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => MainPage()));
                  } on FirebaseAuthException catch (e) {
                    if (e.code == 'user-not-found') {
                      Fluttertoast.showToast(
                        msg: 'No user found for that email.',
                      );
                    } else if (e.code == 'wrong-password') {
                      Fluttertoast.showToast(
                          msg: 'Wrong password provided for that user.');
                    }
                  }
                },
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(color.AppColor.gradientFirst),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40.0)),
                    )),
                child: Text("Login", style: TextStyle(color: Colors.white70)),
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildPageContent(context),
    );
  }
}

enum authProblems { UserNotFound, PasswordNotValid, NetworkError }
