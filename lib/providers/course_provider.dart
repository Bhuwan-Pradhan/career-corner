import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/cupertino.dart';

import 'package:tmc/models/model_course.dart';
import 'package:tmc/models/model_courseVideo.dart';

class CourseProvider with ChangeNotifier {
  List<CourseModel> CourseList = [];
  late CourseModel courseModel;
  List<CourseVideoModel> CourseVideoList = [];
  late CourseVideoModel courseVideoModel;
  List<ClassModel> ClassList = [];
  late ClassModel classModel;


  fetchCourseData() async {
    List<CourseModel> newList = [];
    QuerySnapshot value =
        await FirebaseFirestore.instance.collection("course").get();

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
        .collection("course")
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

  fetchCourseVideoData(String courseType ,String courseID, String classID) async {
    List<CourseVideoModel> newList = [];
    QuerySnapshot value = await FirebaseFirestore.instance
        .collection(courseType)
        .doc(courseID)
        .collection("classes")
        .doc(classID)
        .collection("videos")
        .get();
    value.docs.forEach((element) {
      courseVideoModel = CourseVideoModel(
        title: element.get("title"),
        description: element.get("description"),
        time: element.get("time"),
        thumbnail: element.get("thumbnail"),
        videoUrl: element.get("videoUrl"),
      );
      newList.add(courseVideoModel);
    });
    CourseVideoList = newList;
    notifyListeners();
  }

  List<CourseVideoModel> get getCourseVideoList {
    return CourseVideoList;
  }
}
