import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/cupertino.dart';



class TestimonialsProvider with ChangeNotifier {
  List<TestimonialsModel> TestimonialsList = [];
  late TestimonialsModel testimonialsModel;

  fetchTestimonialsData() async {
    List<TestimonialsModel> newList = [];
    QuerySnapshot value =
        await FirebaseFirestore.instance.collection("testimonials").orderBy("index").get();

    value.docs.forEach((element) {
      testimonialsModel = TestimonialsModel(
       
        userImage: element.get("userImage"),
        userName: element.get("userName"),
        testimonial: element.get("testimonial"),
      );
      newList.add(testimonialsModel);
    });
    TestimonialsList = newList;
    notifyListeners();
  }

  List<TestimonialsModel> get getTestimonialsList {
    return TestimonialsList;
  }
}


class TestimonialsModel {
  
  String userImage;
  String userName;
  String testimonial;
  
  TestimonialsModel({
    required this.userImage,
    required this.userName,
    required this.testimonial,
     });
}
