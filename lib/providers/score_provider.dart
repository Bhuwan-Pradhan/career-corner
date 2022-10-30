import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ScoreModel {
  int score;

  ScoreModel({required this.score});
}

class ScoreProvider with ChangeNotifier {
  List<ScoreModel> ScoreList = [];
  late ScoreModel scoreModel;

  fetchScoreData() async {
    List<ScoreModel> newList = [];
    QuerySnapshot value = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('testResult')
        .orderBy('score' , descending: true)
        .limit(1)
        .get();

    for (var element in value.docs) {
      scoreModel = ScoreModel(
        score: element.get("score"),
      );
      newList.add(scoreModel);
    }
    ScoreList = newList;
    notifyListeners();
  }

  List<ScoreModel> get getScoreList {
    return ScoreList;
  }
}
