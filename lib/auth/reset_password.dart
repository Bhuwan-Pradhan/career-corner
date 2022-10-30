import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tmc/auth/login_page.dart';

import 'package:tmc/widgets/reusable_widget.dart';
import '../../utils/colors.dart' as color;

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  TextEditingController _emailTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Reset Password",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            color.AppColor.gradientFirst,
            color.AppColor.gradientSecond,
            color.AppColor.card,
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
          child: SingleChildScrollView(
              child: Padding(
            padding: EdgeInsets.fromLTRB(20, 120, 20, 0),
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 20,
                ),
                reusableTextField("Enter Email Id", Icons.person_outline, false,
                    _emailTextController),
                const SizedBox(
                  height: 20,
                ),
                firebaseUIButton(context, "Reset Password", () {
                  FirebaseAuth.instance
                      .sendPasswordResetEmail(email: _emailTextController.text)
                      .then((value) => showDialog(
                            context: context,
                            builder: (ctx) => AlertDialog(
                              title: const Text(
                                "Reset Password",
                                style: TextStyle(fontSize: 25),
                              ),
                              content: const Text(
                                "The reset Password link has been sent to your registered email address. 👍",
                                style: TextStyle(fontSize: 20),
                              ),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Get.off(() => LoginScreen());
                                  },
                                  child: Center(
                                    child: Container(
                                      color: color.AppColor.gradientFirst,
                                      padding: const EdgeInsets.all(14),
                                      child: const Text(
                                        "okay",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ));
                })
              ],
            ),
          ))),
    );
  }
}
