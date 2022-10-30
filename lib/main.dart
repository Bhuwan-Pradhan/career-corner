import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'package:tmc/decisions_tree.dart';

import 'package:tmc/providers/courseAd_provider.dart';
import 'package:tmc/providers/course_provider.dart';
import 'package:tmc/providers/job_provider.dart';
import 'package:tmc/providers/placedStudent_provider.dart';
import 'package:tmc/providers/score_provider.dart';
import 'package:tmc/providers/singleCourse_provider.dart';
import 'package:tmc/providers/testimonials_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isAuth = false;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<JobProvider>(
          create: (context) => JobProvider(),
        ),
        ChangeNotifierProvider<CourseProvider>(
          create: (context) => CourseProvider(),
        ),
        ChangeNotifierProvider<CourseAdProvider>(
          create: (context) => CourseAdProvider(),
        ),
        ChangeNotifierProvider<SingleCourseProvider>(
          create: (context) => SingleCourseProvider(),
        ),
        ChangeNotifierProvider<PlacedStudentProvider>(
          create: (context) => PlacedStudentProvider(),
        ),
        ChangeNotifierProvider<TestimonialsProvider>(
          create: (context) => TestimonialsProvider(),
        ),
        ChangeNotifierProvider<ScoreProvider>(
          create: (context) => ScoreProvider(),
        ),
      ],
      child: GetMaterialApp(
        title: 'TMC',
        themeMode: ThemeMode.light,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        darkTheme: ThemeData(
          brightness: Brightness.dark,
        ),
        routes: {"/": (context) => const DecisionsTree()},
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
