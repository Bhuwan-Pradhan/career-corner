import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/cupertino.dart';



class PlacedStudentProvider with ChangeNotifier {
  List<PlacedStudentModel> PlacedStudentList = [];
  late PlacedStudentModel placedStudentModel;

  fetchPlacedStudentData() async {
    List<PlacedStudentModel> newList = [];
    QuerySnapshot value =
        await FirebaseFirestore.instance.collection("placedStudent").orderBy("index").get();

    value.docs.forEach((element) {
      placedStudentModel = PlacedStudentModel(
       
        image: element.get("image"),
      );
      newList.add(placedStudentModel);
    });
    PlacedStudentList = newList;
    notifyListeners();
  }

  List<PlacedStudentModel> get getPlacedStudentList {
    return PlacedStudentList;
  }
}


class PlacedStudentModel {
  
  String image;
  
  PlacedStudentModel({ required this.image});
}
