import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:tmc/auth/login_page.dart';
import 'package:tmc/widgets/tmcTextField.dart';
import 'package:tmc/widgets/tmc_button.dart';
import 'package:tmc/widgets/drawer.dart';
import '../../utils/colors.dart' as color;

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  // const ProfileScreen({Key? key}) : super(key: key);
  String _userImage = '';
  TextEditingController _userName = TextEditingController();
  TextEditingController _phone = TextEditingController();
  TextEditingController _address = TextEditingController();
  final GlobalKey<ScaffoldState> _jobState = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();
  String? downloadUrl;
  bool selection = false;

  // String? buttonText;
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
    'Above 2 Years',
  ];
  @override
  void initState() {
    getUserData();
    super.initState();
    loading();
  }

  void getUserData() async {
    var collection = FirebaseFirestore.instance.collection('users');
    var docSnapshot =
        await collection.doc(FirebaseAuth.instance.currentUser!.uid).get();
    if (docSnapshot.exists) {
      Map<String, dynamic>? data = docSnapshot.data();
      var userName = data?['userName']; // <-- The value you want to retrieve.
      var phone = data?['phone']; // <-- The value you want to retrieve.
      var gender = data?['gender']; // <-- The value you want to retrieve.
      var highestQualification =
          data?['highestQualification']; // <-- The value you want to retrieve.
      var experience =
          data?['experience']; // <-- The value you want to retrieve.
      var address = data?['address']; // <-- The value you want to retrieve.
      var image = data?['image']; // <-- The value you want to retrieve.

      // Call setState if needed.
      setState(() {
        _userName.text = userName;
        _phone.text = phone;

        dropdownvalueG = gender;

        dropdownvalueHq = highestQualification;
        dropdownvalueEx = experience;

        _address.text = address;

        _userImage = image;
      });
    }
  }

  bool isloading = true;
  loading() async {
    await Future.delayed(Duration(seconds: 3));
    if (mounted) {
      setState(() {
        isloading = false;
      });
    }
  }

  bool isSaving = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _jobState,
      drawer: Mydrawer(),
      body: isloading
          ? Center(
              child: CircularProgressIndicator(
                  color: color.AppColor.gradientSecond),
            )
          : Center(
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 100,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                color.AppColor
                                    .secondPageContainerGradient1stColor,
                                color.AppColor
                                    .secondPageContainerGradient2ndColor
                              ],
                              begin: Alignment.bottomLeft,
                              end: Alignment.topRight,
                            ),
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(30),
                                bottomRight: Radius.circular(30))),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 30,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 30),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  IconButton(
                                    onPressed: () {
                                      _jobState.currentState!.openDrawer();
                                    },
                                    icon: Icon(
                                      Icons.menu,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    "Profile",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 24),
                                  ),
                                  Tooltip(
                                    message: 'Log Out',
                                    child: IconButton(
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (ctx) => AlertDialog(
                                            title: const Text(
                                              "Log Out ",
                                              style: TextStyle(fontSize: 25),
                                            ),
                                            content: const Text(
                                              "You want to log out from the application. 😢",
                                              style: TextStyle(fontSize: 20),
                                            ),
                                            actions: <Widget>[
                                              TextButton(
                                                onPressed: () {
                                                  FirebaseAuth.instance
                                                      .signOut();
                                                  Navigator.of(context)
                                                      .pushAndRemoveUntil(
                                                          new MaterialPageRoute(
                                                              builder: (context) =>
                                                                  new LoginScreen()),
                                                          (route) => false);
                                                },
                                                child: Center(
                                                  child: Container(
                                                    color: color
                                                        .AppColor.gradientFirst,
                                                    padding:
                                                        const EdgeInsets.all(
                                                            14),
                                                    child: const Text(
                                                      "Confirm",
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                      icon: Icon(
                                        Icons.logout_outlined,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                              child: CircleAvatar(
                            radius: 70,
                            backgroundImage: NetworkImage(
                              _userImage,
                            ),
                            backgroundColor: Colors.transparent,
                          )),
                        ),
                      ),
                      TmcTextField(
                        hintText: "enter complete name",
                        controller: _userName,
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
                        controller: _phone,
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
                        margin: const EdgeInsets.symmetric(
                            horizontal: 17, vertical: 7),
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
                        controller: _address,
                        validate: (v) {
                          if (v!.isEmpty) {
                            return "should not be empty";
                          }
                          return null;
                        },
                      ),
                      TmcButton(
                        title: 'Update',
                        isLoginButton: true,
                        isLoading: isSaving,
                        onPress: () {
                          if (formKey.currentState!.validate()) {
                            SystemChannels.textInput.invokeMapMethod(
                                'TextInput.hide'); // hides keyboard

                            dropdownvalueG == 'Select'
                                ? Fluttertoast.showToast(
                                    msg: 'select your gender')
                                : dropdownvalueHq == 'Select'
                                    ? Fluttertoast.showToast(
                                        msg:
                                            'select your Highest qualification')
                                    : dropdownvalueEx == 'Select'
                                        ? Fluttertoast.showToast(
                                            msg: 'select your Experience')
                                        : saveInfo();
                          }
                        },
                      ),
                      TmcButton(
                        onPress: () {
                          showDialog(
                            context: context,
                            builder: (ctx) => AlertDialog(
                              title: const Text(
                                "Log Out ",
                                style: TextStyle(fontSize: 25),
                              ),
                              content: const Text(
                                "You want to log out from the application. 😢",
                                style: TextStyle(fontSize: 20),
                              ),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    FirebaseAuth.instance.signOut();
                                    Navigator.of(context).pushAndRemoveUntil(
                                        new MaterialPageRoute(
                                            builder: (context) =>
                                                new LoginScreen()),
                                        (route) => false);
                                  },
                                  child: Center(
                                    child: Container(
                                      color: color.AppColor.gradientFirst,
                                      padding: const EdgeInsets.all(14),
                                      child: const Text(
                                        "Confirm",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                        title: 'SING OUT',
                      )
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  saveInfo() {
    Map<String, dynamic> data = {
      'userName': _userName.text,
      'address': _address.text,
      'phone': _phone.text,
      'highestQualification': dropdownvalueHq,
      'gender': dropdownvalueG,
      'experience': dropdownvalueEx,
    };
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update(data)
        .whenComplete(() {
      Fluttertoast.showToast(msg: 'Updated Successfully');
    });
  }
}
