import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

import 'package:tmc/screens/mainPage.dart';
import 'package:tmc/widgets/reusable_widget.dart';
import 'package:tmc/widgets/tmcTextField.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  String? userImage;
  String downloadUrl = '';
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _userNameTextController = TextEditingController();
  TextEditingController _userAddressTextController = TextEditingController();
  TextEditingController _userPhoneTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();
  // Initial Selected Value
  String dropdownvalueG = 'Select';
  String dropdownvalueHq = 'Select';
  String dropdownvalueEx = 'Select';
  var g = [
    'Select',
    'Female',
    'Male',
    'Other',
  ];
  var hq = [
    'Select',
    '10th',
    'ITI/Diploma/Polytechnic',
    'Graduation',
    'Post Graduation',
  ];
  var ex = [
    'Select',
    'Fresher',
    '6 Months +',
    '1 Year +',
    'Above 2 years',
  ];
  DateTime selectedDate = DateTime.now();
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1960, 8),
        lastDate: DateTime(2030));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  final formKey = GlobalKey<FormState>();
  bool isSaving = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () async {
                        final XFile? pickImage = await ImagePicker().pickImage(
                          source: ImageSource.gallery,
                          imageQuality: 50,
                        );
                        if (pickImage != null) {
                          setState(() {
                            userImage = pickImage.path;
                          });
                        }
                      },
                      child: Container(
                        child: userImage == null
                            ? CircleAvatar(
                                radius: 70,
                                backgroundColor: Colors.deepPurple,
                                child: Image.asset(
                                  'assets/add_pic.png',
                                  height: 80,
                                  width: 80,
                                ),
                              )
                            : CircleAvatar(
                                radius: 70,
                                backgroundImage: FileImage(File(userImage!)),
                              ),
                      ),
                    ),
                  ),
                ),
                TmcTextField(
                  hintText: "enter complete name",
                  controller: _userNameTextController,
                  validate: (v) {
                    if (v!.isEmpty) {
                      return "should not be empty";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TmcTextField(
                  hintText: "enter phoneNumber",
                  controller: _userPhoneTextController,
                  validate: (v) {
                    if (v!.isEmpty) {
                      return "should not be empty";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TmcTextField(
                  hintText: "enter your Email Id",
                  controller: _emailTextController,
                  validate: (v) {
                    if (v!.isEmpty) {
                      return "should not be empty";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  padding: EdgeInsets.all(5),
                  margin: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    children: [
                      Text("Date of Birth"),
                      SizedBox(
                        width: 100,
                      ),
                      ElevatedButton(
                        onPressed: () => _selectDate(context),
                        child: Text("${selectedDate.toLocal()}".split(' ')[0]),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(5),
                      margin: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Text("Gender :"),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: DropdownButton(
                              // Initial Value
                              value: dropdownvalueG,
                              iconEnabledColor: Colors.red,
                              dropdownColor: Colors.blue,
                              // Down Arrow Icon
                              icon: const Icon(Icons.keyboard_arrow_down),

                              // Array list of items
                              items: g.map((String g) {
                                return DropdownMenuItem(
                                  value: g,
                                  child: Text(g),
                                );
                              }).toList(),
                              // After selecting the desired option,it will
                              // change button value to selected value
                              onChanged: (String? newValue) {
                                setState(() {
                                  dropdownvalueG = newValue!;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Text("Experience :"),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: DropdownButton(
                              // Initial Value
                              value: dropdownvalueEx,
                              iconEnabledColor: Colors.red,
                              dropdownColor: Colors.blue,
                              // Down Arrow Icon
                              icon: const Icon(Icons.keyboard_arrow_down),

                              // Array list of items
                              items: ex.map((String ex) {
                                return DropdownMenuItem(
                                  value: ex,
                                  child: Text(ex),
                                );
                              }).toList(),
                              // After selecting the desired option,it will
                              // change button value to selected value
                              onChanged: (String? newValue) {
                                setState(() {
                                  dropdownvalueEx = newValue!;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(5),
                  margin:
                      const EdgeInsets.symmetric(horizontal: 17, vertical: 7),
                  decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Text("Highest Qualification :")),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: DropdownButton(
                          // Initial Value
                          value: dropdownvalueHq,
                          iconEnabledColor: Colors.red,
                          dropdownColor: Colors.blue,
                          // Down Arrow Icon
                          icon: const Icon(Icons.keyboard_arrow_down),

                          // Array list of items
                          items: hq.map((String hq) {
                            return DropdownMenuItem(
                              value: hq,
                              child: Text(hq),
                            );
                          }).toList(),
                          // After selecting the desired option,it will
                          // change button value to selected value
                          onChanged: (String? newValue) {
                            setState(() {
                              dropdownvalueHq = newValue!;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TmcTextField(
                  hintText: "enter complete address",
                  controller: _userAddressTextController,
                  validate: (v) {
                    if (v!.isEmpty) {
                      return "should not be empty";
                    }
                    return null;
                  },
                ),
                TmcTextField(
                  hintText: "enter your password",
                  controller: _passwordTextController,
                  validate: (v) {
                    if (v!.isEmpty) {
                      return "should not be empty";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: firebaseUIButton(
                    context,
                    "Sign Up",
                    () {
                      if (formKey.currentState!.validate()) {
                        SystemChannels.textInput.invokeMapMethod(
                            'TextInput.hide'); // hides keyboard
                        userImage == null
                            ? Fluttertoast.showToast(msg: 'select profile pic')
                            : selectedDate == DateTime.now()
                                ? Fluttertoast.showToast(
                                    msg: 'select your date of birth ')
                                : dropdownvalueG == 'Select'
                                    ? Fluttertoast.showToast(
                                        msg: 'select your gender')
                                    : dropdownvalueHq == 'Select'
                                        ? Fluttertoast.showToast(
                                            msg:
                                                'select your Highest qualification')
                                        : dropdownvalueEx == 'Select'
                                            ? Fluttertoast.showToast(
                                                msg: 'select your Experience')
                                            : FirebaseAuth.instance
                                                .createUserWithEmailAndPassword(
                                                    email: _emailTextController
                                                        .text,
                                                    password:
                                                        _passwordTextController
                                                            .text)
                                                .then((value) {
                                                final User? user = value.user;
                                                if (user != null) {
                                                  saveInfo();
                                                }

                                                Navigator.pushReplacement(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            const MainPage()));
                                              }).onError((error, stackTrace) {
                                                Fluttertoast.showToast(
                                                    msg:
                                                        "Error ${error.toString()}");
                                              });
                      }
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<String?> uploadImage(File filepath, String? reference) async {
    try {
      final finalName =
          '${FirebaseAuth.instance.currentUser!.uid}${DateTime.now().second}';
      final Reference fbStorage =
          FirebaseStorage.instance.ref(reference).child(finalName);
      final UploadTask uploadTask = fbStorage.putFile(filepath);
      await uploadTask.whenComplete(() async {
        downloadUrl = await fbStorage.getDownloadURL();
      });

      return downloadUrl;
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());

      return null;
    }
  }

  saveInfo() {
    uploadImage(File(userImage!), 'profile').whenComplete(() {
      Map<String, dynamic> data = {
        'userName': _userNameTextController.text,
        'address': _userAddressTextController.text,
        'email': _emailTextController.text,
        'phone': _userPhoneTextController.text,
        'image': downloadUrl,
        'dateOfBirth': "${selectedDate.toLocal()}".split(' ')[0],
        'highestQualification': dropdownvalueHq,
        'gender': dropdownvalueG,
        'experience': dropdownvalueEx,
        'password': _passwordTextController.text,
      };
      FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set(data);
    });
  }
}
