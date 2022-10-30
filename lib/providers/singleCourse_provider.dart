import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/cupertino.dart';

import 'package:tmc/models/model_course.dart';


class SingleCourseProvider with ChangeNotifier {
  List<CourseModel> CourseList = [];
  late CourseModel courseModel;

  List<ClassModel> ClassList = [];
  late ClassModel classModel;

  fetchCourseData() async {
    List<CourseModel> newList = [];
    QuerySnapshot value =
        await FirebaseFirestore.instance.collection("singleCourse").orderBy("index").get();

    value.docs.forEach((element) {
      courseModel = CourseModel(
        id: element.get("id"),
        title: element.get("title"),
        subtitle: element.get("subtitle"),
        highestQualification: element.get("highestQualification"),
        image: element.get("image"),
        price: element.get("price"),
      );
      newList.add(courseModel);
    });
    CourseList = newList;
    notifyListeners();
  }

  List<CourseModel> get getCourseList {
    return CourseList;
  }

  fetchClassData(String courseID) async {
    List<ClassModel> newList = [];
    QuerySnapshot value = await FirebaseFirestore.instance
        .collection("singleCourse")
        .doc(courseID)
        .collection("classes")
        .get();

    value.docs.forEach((element) {
      classModel = ClassModel(
        id: element.get("id"),
        title: element.get("title"),
        subtitle: element.get("subtitle"),
        duration: element.get("duration"),
        image: element.get("image"),
        videos: element.get("videos"),
      );
      newList.add(classModel);
    });
    ClassList = newList;
    notifyListeners();
  }

  List<ClassModel> get getClassList {
    return ClassList;
  }
}
