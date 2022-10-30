import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/cupertino.dart';



class CourseAdProvider with ChangeNotifier {
  List<CourseAdModel> CourseAdList = [];
  late CourseAdModel courseAdModel;

  fetchCourseAdData() async {
    List<CourseAdModel> newList = [];
    QuerySnapshot value =
        await FirebaseFirestore.instance.collection("courseAd").orderBy("index").get();

    for (var element in value.docs) {
      courseAdModel = CourseAdModel(
       
        image: element.get("image"),
      );
      newList.add(courseAdModel);
    }
    CourseAdList = newList;
    notifyListeners();
  }

  List<CourseAdModel> get getCourseAdList {
    return CourseAdList;
  }
}


class CourseAdModel {
  
  String image;
  
  CourseAdModel({ required this.image});
}
