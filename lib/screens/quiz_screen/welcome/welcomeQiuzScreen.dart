import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:tmc/providers/score_provider.dart';
import 'package:tmc/utils/constants.dart';
import 'package:tmc/screens/quiz_screen/quiz/quiz_screen.dart';
import '../../../utils/colors.dart' as color;

class WelcomeQuizScreen extends StatefulWidget {
  final String courseID;
  final String courseType;

  const WelcomeQuizScreen(
      {super.key, required this.courseID, required this.courseType});
  @override
  State<WelcomeQuizScreen> createState() => _WelcomeQuizScreenState();
}

class _WelcomeQuizScreenState extends State<WelcomeQuizScreen> {
  bool _isPurchased = false;

  late ScoreProvider scoreProvider;
  void getUserData() async {
    var collection = FirebaseFirestore.instance.collection(widget.courseType);
    var docSnapshot = await collection
        .doc(widget.courseID)
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    if (docSnapshot.exists) {
      Map<String, dynamic>? data = docSnapshot.data();

      var isPurchased =
          data?['isPurchased']; // <-- The value you want to retrieve.
      // Call setState if needed.
      setState(() {
        _isPurchased = isPurchased;
      });
    }
  }

  @override
  void initState() {
    getUserData();
    ScoreProvider scoreProvider = Provider.of(context, listen: false);
    scoreProvider.fetchScoreData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    scoreProvider = Provider.of(context);
    return Consumer<ScoreProvider>(builder: (context, scoreData, index) {
      var scores = scoreData.getScoreList;
      return Scaffold(
        body: Stack(
          children: [
            SvgPicture.asset("assets/icons/bg.svg", fit: BoxFit.fill),
            ListView.builder(
                itemCount: scores.length,
                itemBuilder: ((context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 80),
                    child: Center(
                      child: Text(
                        "Highest Score: ${scores[index].score}/200",
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall
                            ?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                      ),
                    ),
                  );
                })),
            SafeArea(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Spacer(flex: 2), //2/6

                    Spacer(), // 1/6
                    InkWell(
                      onTap: () {
                        _isPurchased
                            ? Get.off(() => QuizScreen())
                            : showDialog(
                                context: context,
                                builder: (ctx) => AlertDialog(
                                  title: const Text(
                                    "Alert",
                                    style: TextStyle(fontSize: 25),
                                  ),
                                  content: const Text(
                                    "Purchase the course to access class videos, and tests and get an assured job after the course.",
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(ctx).pop();
                                      },
                                      child: Center(
                                        child: Container(
                                          color: color.AppColor.gradientFirst,
                                          padding: const EdgeInsets.all(14),
                                          child: const Text(
                                            "okay",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                      },
                      child: Container(
                        width: double.infinity,
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(kDefaultPadding * 0.75), // 15
                        decoration: BoxDecoration(
                          gradient: kPrimaryGradient,
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                        child: Text(
                          "Let's Start Quiz",
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge
                              ?.copyWith(color: Colors.black),
                        ),
                      ),
                    ),
                    Spacer(flex: 2), // it will take 2/6 spaces
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
