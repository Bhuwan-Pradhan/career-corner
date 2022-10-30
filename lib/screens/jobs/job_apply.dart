import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:tmc/screens/mainPage.dart';
import '../../utils/colors.dart' as color;

class JobApply extends StatefulWidget {
  final String job_name;
  final String id;
  const JobApply({Key? key, required this.job_name, required this.id})
      : super(key: key);

  @override
  State<JobApply> createState() => _JobApplyState();
}

class _JobApplyState extends State<JobApply> {
  String resume = "";
  String resumeUrl = "";
  bool isUploaded = false;
  String _userName = "";
  String _phone = "";
  String _email = "";
  void getUserData() async {
    var collection = FirebaseFirestore.instance.collection('users');
    var docSnapshot =
        await collection.doc(FirebaseAuth.instance.currentUser!.uid).get();
    if (docSnapshot.exists) {
      Map<String, dynamic>? data = docSnapshot.data();
      var userName = data?['userName']; // <-- The value you want to retrieve.
      var phone = data?['phone']; // <-- The value you want to retrieve.
      var email = data?['email']; // <-- The value you want to retrieve.
      // Call setState if needed.
      setState(() {
        _userName = userName;
        _phone = phone;
        _email = email;
      });
    }
  }

  @override
  void initState() {
    getUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          margin: EdgeInsets.all(30),
          padding: EdgeInsets.all(20),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: color.AppColor.card,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.black, width: 2)),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 50,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Name: ",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child: Text(
                        _userName,
                        style: TextStyle(
                            color: color.AppColor.homePageSubtitle,
                            fontSize: 20),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Phone No. : ",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child: Text(
                        _phone,
                        style: TextStyle(
                            color: color.AppColor.homePageSubtitle,
                            fontSize: 20),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Email Id: ",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  _email,
                  style: TextStyle(
                      color: color.AppColor.homePageSubtitle, fontSize: 20),
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Icon(Icons.upload_file),
                    SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child: Text(
                        "Upload your updated resume.",
                        style: TextStyle(
                            color: color.AppColor.homePageSubtitle,
                            fontSize: 17),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Center(
                  child: InkWell(
                    onTap: () async {
                      FilePickerResult? result =
                          await FilePicker.platform.pickFiles();

                      if (result != null) {
                        setState(() {
                          resume = result.files.single.path!;

                          isUploaded = true;
                        });
                        Get.snackbar(
                          "Resume",
                          "",
                          snackPosition: SnackPosition.TOP,
                          icon: Icon(
                            Icons.face,
                            size: 30,
                            color: Colors.white,
                          ),
                          backgroundColor: color.AppColor.gradientFirst,
                          colorText: Colors.white,
                          messageText: Text(
                            "Resume Uploaded",
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        );
                      } else {
                        Get.snackbar(
                          "Resume not uploaded",
                          "",
                          snackPosition: SnackPosition.TOP,
                          icon: Icon(
                            Icons.face,
                            size: 30,
                            color: Colors.white,
                          ),
                          backgroundColor: color.AppColor.gradientFirst,
                          colorText: Colors.white,
                          messageText: Text(
                            "Please Upload your resume",
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        );
                      }
                    },
                    child: Container(
                      height: 40,
                      width: 80,
                      decoration: BoxDecoration(
                          color: color.AppColor.gradientSecond,
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Colors.black54, width: 2)),
                      child: Center(
                        child: Text(
                          "Upload",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "You are applying for  ${widget.job_name}",
                  style: TextStyle(
                      color: color.AppColor.homePageSubtitle, fontSize: 20),
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: InkWell(
                    onTap: () {
                      isUploaded
                          ? apply(widget.id)
                          : Get.snackbar(
                              "Resume not uploaded",
                              "",
                              snackPosition: SnackPosition.TOP,
                              icon: Icon(
                                Icons.face,
                                size: 30,
                                color: Colors.white,
                              ),
                              backgroundColor: color.AppColor.gradientFirst,
                              colorText: Colors.white,
                              messageText: Text(
                                "Please Upload your resume",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                            );
                    },
                    child: Container(
                      height: 50,
                      width: 100,
                      decoration: BoxDecoration(
                          color: color.AppColor.gradientSecond,
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Colors.black54, width: 2)),
                      child: Center(
                        child: Text(
                          "Apply",
                          style: TextStyle(fontSize: 30),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<String?> uploadResume(File filepath, String? reference) async {
    try {
      final finalName =
          '${FirebaseAuth.instance.currentUser!.uid}${DateTime.now().day}';
      final Reference fbStorage =
          FirebaseStorage.instance.ref(reference).child(finalName);
      final UploadTask uploadTask = fbStorage.putFile(filepath);
      await uploadTask.whenComplete(() async {
        resumeUrl = await fbStorage.getDownloadURL();
      });

      return resumeUrl;
    } catch (e) {
       Fluttertoast.showToast(
                                                    msg:
                                                        e.toString());
      return null;
    }
  }

  apply(String id) {
    uploadResume(File(resume), 'resumes').whenComplete(() {
      Map<String, dynamic> data = {
        'resume': resumeUrl,
        'userName': _userName,
        'phone': _phone,
        'email': _email,
      };
      FirebaseFirestore.instance
          .collection('jobs')
          .doc(id)
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set(data);
    });
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text(
          "Thank You",
          style: TextStyle(fontSize: 25),
        ),
        content: const Text(
          "Successfully Registered for Job!\nFor Assured this job you can check out our guaranteed job courses. 😎",
          style: TextStyle(fontSize: 20),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Get.off(() => const MainPage());
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
    );
  }
}
