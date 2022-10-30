import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:tmc/providers/placedStudent_provider.dart';
import 'package:tmc/providers/testimonials_provider.dart';

import '../../utils/colors.dart' as color;

import 'package:tmc/widgets/drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    PlacedStudentProvider placedStudentProvider =
        Provider.of(context, listen: false);
    placedStudentProvider.fetchPlacedStudentData();
    TestimonialsProvider testimonialsProvider =
        Provider.of(context, listen: false);
    testimonialsProvider.fetchTestimonialsData();
    super.initState();
    getFullName();
  }

  late PlacedStudentProvider placedStudentProvider;
  late TestimonialsProvider testimonialsProvider;
  String _userName = "";

  void getFullName() async {
    var collection = FirebaseFirestore.instance.collection('users');
    var docSnapshot =
        await collection.doc(FirebaseAuth.instance.currentUser!.uid).get();
    if (docSnapshot.exists) {
      Map<String, dynamic>? data = docSnapshot.data();
      var userName = data?['userName']; // <-- The value you want to retrieve.
      // Call setState if needed.
      setState(() {
        _userName = userName;
      });
    }
  }

  final GlobalKey<ScaffoldState> _homeState = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    placedStudentProvider = Provider.of(context);
    testimonialsProvider = Provider.of(context);
    return Scaffold(
      key: _homeState,
      drawer: Mydrawer(),
      body: SingleChildScrollView(
        child: Container(
          color: color.AppColor.homePageBackground,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    SizedBox(
                      height: 50,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          IconButton(
                            onPressed: () {
                              _homeState.currentState!.openDrawer();
                            },
                            icon: Icon(
                              Icons.menu,
                              color: color.AppColor.homePageTitle,
                            ),
                          ),
                          SizedBox(
                            width: 50,
                          ),
                          Center(
                            child: Text(
                              "Home",
                              style: TextStyle(
                                  color: color.AppColor.homePageTitle,
                                  fontSize: 24),
                            ),
                          ),
                          Expanded(child: Container())
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(30),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  child: Text(
                                    "Hi, $_userName",

                                    // textAlign: TextAlign.start,
                                    style: TextStyle(
                                        color: color.AppColor.homePageTitle,
                                        fontSize: 26),
                                  ),
                                ),
                              ),
                              //Expanded(child: Container())
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "Welcome To Career Corner",
                                  //softWrap: false,
                                  // maxLines: 1,
                                  style: TextStyle(
                                      color: color.AppColor.homePageSubtitle,
                                      fontSize: 22),
                                ),
                              ),
                              //Expanded(child: Container())
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.all(10),
                height: 250,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        color.AppColor.gradientFirst.withOpacity(0.9),
                        color.AppColor.gradientSecond
                      ],
                      begin: const FractionalOffset(0.0, 0.4),
                      end: Alignment.topRight,
                    ),
                    borderRadius: BorderRadius.circular(30)),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Career Corner is the next step in your life...",
                        style: TextStyle(
                            color: color.AppColor.secondPageTitleColor,
                            fontSize: 20),
                      ),
                    ),
                    Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(20),
                          height: 180,
                          width: 100,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage("assets/founder.png"),
                                  fit: BoxFit.cover)),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        DottedBorder(
                            color: color.AppColor.secondPageIconColor,
                            borderType: BorderType.RRect,
                            radius: Radius.circular(12),
                            padding: EdgeInsets.all(6),
                            child: ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                              child: SizedBox(
                                height: 20,
                                child: Text(
                                  "Ranjan Pradhan",
                                  style: TextStyle(
                                      color:
                                          color.AppColor.secondPageTitleColor,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            )),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: Column(children: [
                  SizedBox(
                    height: 10,
                  ),
                  Text("About US",
                      style: TextStyle(
                          fontSize: 28,
                          color: color.AppColor.homePageTitle,
                          fontWeight: FontWeight.bold)),
                  Divider(
                    color: color.AppColor.homePageTitle,
                    indent: 80,
                    endIndent: 80,
                    height: 3,
                  ),
                ]),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.all(30),
                child: Text(
                  "We build your talent for jobs. To give opportunity at big MultiNationional Companies. Here, we connect students to employers by scheduling interviews, matching students with their relevant fields, providing Internships, and hooking them to companies.",
                  style: TextStyle(fontSize: 14),
                ),
              ),
              Container(
                height: 800,
                width: double.infinity,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/home_background.png"),
                      fit: BoxFit.cover),
                ),
                child: Container(
                  margin: EdgeInsets.only(left: 20),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 40,
                      ),
                      Text("Testimonials",
                          style: TextStyle(
                              fontSize: 28,
                              color: color.AppColor.homePageTitle,
                              fontWeight: FontWeight.bold)),
                      Divider(
                        color: color.AppColor.homePageTitle,
                        indent: 80,
                        endIndent: 80,
                        height: 3,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        child: CarouselSlider(
                          items: testimonialsProvider.getTestimonialsList.map(
                            (testimonialsData) {
                              return Container(
                                padding: EdgeInsets.all(20),
                                height: 380,
                                width: 200,
                                margin: EdgeInsets.all(6.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.0),
                                  image: DecorationImage(
                                    image: AssetImage("assets/testimonial.png"),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                child: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(left: 30),
                                        child: SingleChildScrollView(
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                testimonialsData.testimonial,
                                                style: TextStyle(
                                                    color: color.AppColor
                                                        .homePageSubtitle,
                                                    fontSize: 10),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Divider(
                                        color: color.AppColor.homePageSubtitle,
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Container(
                                        child: SingleChildScrollView(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Container(
                                                  child: CircleAvatar(
                                                radius: 20,
                                                backgroundImage: NetworkImage(
                                                    testimonialsData.userImage),
                                              )),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Expanded(
                                                child: Text(
                                                  testimonialsData.userName,
                                                  style: TextStyle(
                                                      color: color.AppColor
                                                          .homePageSubtitle,
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ).toList(),
                          options: CarouselOptions(
                            height: 220.0,
                            enlargeCenterPage: true,
                            autoPlay: true,
                            autoPlayInterval: Duration(seconds: 2),
                            aspectRatio: 16 / 9,
                            autoPlayCurve: Curves.fastOutSlowIn,
                            enableInfiniteScroll: true,
                            autoPlayAnimationDuration:
                                Duration(milliseconds: 800),
                            viewportFraction: 0.8,
                          ),
                        ),
                      ),
                      Expanded(child: Container()),
                      Text("Success Story",
                          style: TextStyle(
                              fontSize: 28,
                              color: color.AppColor.homePageTitle,
                              fontWeight: FontWeight.bold)),
                      Divider(
                        color: color.AppColor.homePageTitle,
                        indent: 80,
                        endIndent: 80,
                        height: 3,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        child: CarouselSlider(
                          items: placedStudentProvider.getPlacedStudentList.map(
                            (placedStudentData) {
                              return Container(
                                height: 300,
                                width: 200,
                                margin: EdgeInsets.all(6.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.0),
                                  border:
                                      Border.all(color: Colors.black, width: 2),
                                  image: DecorationImage(
                                    image:
                                        NetworkImage(placedStudentData.image),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              );
                            },
                          ).toList(),
                          options: CarouselOptions(
                            pauseAutoPlayOnTouch: true,
                            height: 300,
                            enlargeCenterPage: true,
                            autoPlay: true,
                            autoPlayInterval: Duration(seconds: 2),
                            aspectRatio: 3 / 4,
                            autoPlayCurve: Curves.fastOutSlowIn,
                            enableInfiniteScroll: true,
                            autoPlayAnimationDuration:
                                Duration(milliseconds: 800),
                            viewportFraction: 0.8,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 60,
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: Column(children: [
                  SizedBox(
                    height: 10,
                  ),
                  Text("FAQ",
                      style: TextStyle(
                          fontSize: 28,
                          color: color.AppColor.homePageTitle,
                          fontWeight: FontWeight.bold)),
                  Divider(
                    color: color.AppColor.homePageTitle,
                    indent: 120,
                    endIndent: 120,
                    height: 3,
                  ),
                ]),
              ),
              SizedBox(
                child: Column(
                  children: [
                    ExpansionTile(
                      title: Text(
                        "What is Career Corner ?",
                        style: TextStyle(
                            color: color.AppColor.homePageTitle,
                            fontWeight: FontWeight.bold),
                      ),
                      children: <Widget>[
                        Container(
                          alignment: Alignment.topLeft,
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            "We build your Skill for jobs. To give opportunity at big MultiNationional Companies. Here, we connect students to employers by scheduling interviews, matching students with their relevant fields, providing Internships, and hooking them to companies.",
                            style:
                                TextStyle(color: color.AppColor.gradientFirst),
                          ),
                        )
                      ],
                    ),
                    ExpansionTile(
                      title: Text(
                        "How can i get a job?",
                        style: TextStyle(
                            color: color.AppColor.homePageTitle,
                            fontWeight: FontWeight.bold),
                      ),
                      children: <Widget>[
                        Container(
                          alignment: Alignment.topLeft,
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            "Choose a course as per your preference and interest.Complete all classes and tests.Our team will schedule a mock interview and prepare you for the job interview.Finally, you will get your dream job.",
                            style:
                                TextStyle(color: color.AppColor.gradientFirst),
                          ),
                        )
                      ],
                    ),
                    ExpansionTile(
                      title: Text(
                        "How to apply for upcoming jobs ?",
                        style: TextStyle(
                            color: color.AppColor.homePageTitle,
                            fontWeight: FontWeight.bold),
                      ),
                      children: <Widget>[
                        Container(
                          alignment: Alignment.topLeft,
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            "Go to the Job section, \n select the job which you want go through the details and apply for job and upload your recent resume . ",
                            style:
                                TextStyle(color: color.AppColor.gradientFirst),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        title: Text(
                          "Contact Us",
                          style: TextStyle(
                              color: color.AppColor.homePageTitle,
                              fontWeight: FontWeight.bold,
                              fontSize: 28.0),
                        ),
                      ),
                      Row(
                        children: [
                          for (int i = 0; i < 120; i++)
                            i.isEven
                                ? Container(
                                    width: 3,
                                    height: 1,
                                    decoration: BoxDecoration(
                                      color: Color(0xFF839fed),
                                      borderRadius: BorderRadius.circular(2),
                                    ),
                                  )
                                : Container(
                                    width: 3,
                                    height: 1,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(2),
                                    ),
                                  ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8.0),
                        child: Text(
                          "Feel free to contact us if you have any problems.",
                          style: TextStyle(color: color.AppColor.gradientFirst),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DottedBorder(
                          borderType: BorderType.RRect,
                          radius: Radius.circular(12),
                          padding: EdgeInsets.all(6),
                          child: ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                            child: Container(
                              height: 280,
                              width: MediaQuery.of(context).size.width,
                              color: color.AppColor.card,
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(10),
                                      child: Row(
                                        children: [
                                          Text(
                                            "Phone Number : ",
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          SizedBox(
                                            width: 30,
                                          ),
                                          Text(
                                            "620-651-0351",
                                            style: TextStyle(fontSize: 20),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(10),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Email Address : ",
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            "talentmanagementcenterjsr@gmail.com",
                                            style: TextStyle(fontSize: 15),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(10),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Address : ",
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          SizedBox(
                                            width: 30,
                                          ),
                                          Expanded(
                                            child: Text(
                                              "1st FLOOR , NEAR SHARDA BOOK STORE, GAMHARIA , JAMSHEDPUR , JHARKHAND , INDIA, PINCODE: 832108",
                                              style: TextStyle(fontSize: 15),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(10),
                                      child: Row(
                                        children: [
                                          Text(
                                            "Website URL : ",
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          SizedBox(
                                            width: 30,
                                          ),
                                          Text(
                                            "www.tmcjsr.com",
                                            style: TextStyle(fontSize: 20),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ]),
                            ),
                          ),
                        ),
                      ),
                    ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
