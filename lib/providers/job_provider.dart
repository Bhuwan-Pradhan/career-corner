import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/cupertino.dart';
import 'package:tmc/models/model_jobs.dart';

class JobProvider with ChangeNotifier {
  List<JobModel> JobDataList = [];
  late JobModel jobModel;
  List<JobRoleModel> JobRoleList = [];
  late JobRoleModel jobRoleModel;
  fetchJobData() async {
    List<JobModel> newList = [];
    QuerySnapshot value = await FirebaseFirestore.instance
        .collection("jobs")
        .orderBy("index")
        .get();

    value.docs.forEach((element) {
      jobModel = JobModel(
        name: element.get("name"),
        location: element.get("location"),
        logoText: element.get("logoText"),
        eligibility: element.get("eligibility"),
        id: element.get("id"),
        salary: element.get("salary"),
      );
      newList.add(jobModel);
    });
    JobDataList = newList;
    notifyListeners();
  }

  List<JobModel> get getJobDataList {
    return JobDataList;
  }

  fetchJobRoleData(String id) async {
    List<JobRoleModel> newList = [];
    QuerySnapshot value = await FirebaseFirestore.instance
        .collection("jobs")
        .doc(id)
        .collection("jobRole")
        .get();

    value.docs.forEach((element) {
      jobRoleModel = JobRoleModel(
        role: element.get("role"),
      );
      newList.add(jobRoleModel);
    });
    JobRoleList = newList;
    notifyListeners();
  }

  List<JobRoleModel> get getJobRoleList {
    return JobRoleList;
  }
}

class JobRoleModel {
  String role;
  JobRoleModel({required this.role});
}
