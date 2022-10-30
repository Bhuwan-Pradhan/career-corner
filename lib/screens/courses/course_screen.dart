import 'package:carousel_slider/carousel_slider.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tmc/providers/courseAd_provider.dart';
import 'package:tmc/providers/course_provider.dart';
import 'package:tmc/providers/singleCourse_provider.dart';

import 'package:tmc/screens/courses/course_details_GJ.dart';
import 'package:tmc/screens/courses/course_details_SJ.dart';

import 'package:tmc/widgets/drawer.dart';
import '../../utils/colors.dart' as color;

class Courses extends StatefulWidget {
  const Courses({Key? key}) : super(key: key);

  @override
  State<Courses> createState() => _CoursesState();
}

class _CoursesState extends State<Courses> {
  late CourseAdProvider courseAdProvider;
  late CourseProvider courseProvider;
  late SingleCourseProvider singleCourseProvider;

  final GlobalKey<ScaffoldState> _jobState = GlobalKey<ScaffoldState>();
  bool isloading = true;
  loading() async {
    await Future.delayed(Duration(seconds: 3));
    if (mounted) {
      setState(() {
        isloading = false;
      });
    }
  }

  @override
  void initState() {
    SingleCourseProvider singleCourseProvider =
        Provider.of(context, listen: false);
    singleCourseProvider.fetchCourseData();
    CourseAdProvider courseAdProvider = Provider.of(context, listen: false);
    courseAdProvider.fetchCourseAdData();
    CourseProvider courseProvider = Provider.of(context, listen: false);
    courseProvider.fetchCourseData();

    super.initState();
    loading();
  }

  @override
  Widget build(BuildContext context) {
    courseAdProvider = Provider.of(context);
    courseProvider = Provider.of(context);
    singleCourseProvider = Provider.of(context);
    return Scaffold(
      key: _jobState,
      drawer: Mydrawer(),
      body: isloading
          ? Center(
              child: CircularProgressIndicator(
                  color: color.AppColor.gradientSecond),
            )
          : Container(
              color: color.AppColor.homePageBackground,
              child: Column(
                children: [
                  Container(
                    height: 100,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            color.AppColor.secondPageContainerGradient1stColor,
                            color.AppColor.secondPageContainerGradient2ndColor
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
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
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
                              SizedBox(
                                width: 30,
                              ),
                              Text(
                                "Course Store",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 24),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      color: color.AppColor.homePageBackground,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              color: color.AppColor.homePageBackground,
                              child: CarouselSlider(
                                items: courseAdProvider.getCourseAdList.map(
                                  (courseAdData) {
                                    return Container(
                                      margin: EdgeInsets.all(6.0),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        image: DecorationImage(
                                          image:
                                              NetworkImage(courseAdData.image),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    );
                                  },
                                ).toList(),
                                options: CarouselOptions(
                                  height: 150.0,
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
                            SizedBox(
                              height: 8,
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
                                            borderRadius:
                                                BorderRadius.circular(2),
                                          ),
                                        )
                                      : Container(
                                          width: 3,
                                          height: 1,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(2),
                                          ),
                                        ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: 300,
                                    height: 40,
                                    decoration: BoxDecoration(
                                        color: Color(0xFFeaeefc),
                                        borderRadius: BorderRadius.circular(30),
                                        border: Border.all(
                                          color: color.AppColor.gradientFirst,
                                          width: 2,
                                        )),
                                    child: Center(
                                      child: Text(
                                        "100% Guarantee Job Courses",
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: color.AppColor.homePageTitle,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding:
                                        EdgeInsets.only(top: 15, bottom: 10),
                                    height: 340,
                                    color: color.AppColor.homePageBackground,
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        children: courseProvider.getCourseList
                                            .map((courseData) {
                                          return Container(
                                            child: _courseCard(
                                                courseData.id,
                                                courseData.title,
                                                courseData.subtitle,
                                                courseData.image,
                                                courseData.price,
                                                courseData
                                                    .highestQualification),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 8,
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
                                            borderRadius:
                                                BorderRadius.circular(2),
                                          ),
                                        )
                                      : Container(
                                          width: 3,
                                          height: 1,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(2),
                                          ),
                                        ),
                              ],
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: 300,
                                    height: 50,
                                    decoration: BoxDecoration(
                                        color: Color(0xFFeaeefc),
                                        borderRadius: BorderRadius.circular(30),
                                        border: Border.all(
                                          color: color.AppColor.gradientFirst,
                                          width: 2,
                                        )),
                                    child: Center(
                                      child: Text(
                                        "Our Other Popular Courses",
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: color.AppColor.homePageTitle,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding:
                                        EdgeInsets.only(top: 10, bottom: 10),
                                    height: 300,
                                    color: color.AppColor.homePageBackground,
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        children: singleCourseProvider
                                            .getCourseList
                                            .map((singleCourseData) {
                                          return Container(
                                            child: _skillCard(
                                                singleCourseData.id,
                                                singleCourseData.title,
                                                singleCourseData.subtitle,
                                                singleCourseData.image,
                                                singleCourseData.price,
                                                singleCourseData
                                                    .highestQualification),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  _courseCard(String id, String title, String subtitle, String image, int price,
      String highestQualification) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.symmetric(horizontal: 15),
      elevation: 30,
      shadowColor: color.AppColor.circuitsColor,
      color: color.AppColor.card,
      child: SizedBox(
        width: 205,
        height: 280,
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Column(
            children: [
              CircleAvatar(
                backgroundColor: color.AppColor.gradientFirst,
                radius: 54,
                child: CircleAvatar(
                  backgroundImage: NetworkImage(image),
                  radius: 50,
                ), //CircleAvatar
              ), //CircleAvatar
              SizedBox(
                height: 10,
              ), //SizedBox
              Text(
                title,
                style: TextStyle(
                  fontSize: 20,
                  color: color.AppColor.homePageContainerTextBig,
                  fontWeight: FontWeight.w500,
                ), //Textstyle
              ), //Text
              SizedBox(
                height: 10,
              ), //SizedBox
              Text(
                highestQualification,
                style: TextStyle(
                  fontSize: 10,
                  color: Color(0xFFf4f5fd),
                ), //Textstyle
              ), //Text
              SizedBox(
                height: 10,
              ), //SizedBox
              SizedBox(
                width: 120,
                height: 40,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CourseDetailsGJ(
                                courseTitle: title,
                                courseSubtitle: subtitle,
                                courseID: id,
                                price: price,
                              )),
                    );
                  },
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          color.AppColor.gradientSecond)),
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      children: [Icon(Icons.touch_app), Text('Visit')],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _skillCard(String id, String title, String subtitle, String image, int price,
      String highestQualification) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(width: 2, color: color.AppColor.homePageTitle)),
      margin: EdgeInsets.symmetric(horizontal: 10),
      elevation: 30,
      shadowColor: color.AppColor.circuitsColor,
      color: color.AppColor.card,
      child: SizedBox(
        width: 160,
        height: 230,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 130,
              width: 160,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)),
                image: DecorationImage(
                    image: NetworkImage(image), fit: BoxFit.cover),
                color: color.AppColor.homePageBackground,
              ),
            ),
            Divider(
              color: color.AppColor.homePageTitle,
              height: 2,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: 100,
                      height: 30,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CourseDetailsSJ(
                                      courseTitle: title,
                                      courseSubtitle: subtitle,
                                      courseID: id,
                                      price: price,
                                    )),
                          );
                        },
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                color.AppColor.gradientSecond)),
                        child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: Row(
                            children: const [
                              Icon(Icons.touch_app),
                              Text('Visit')
                            ],
                          ),
                        ),
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
  }
}
