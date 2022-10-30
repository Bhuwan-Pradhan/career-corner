import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:provider/provider.dart';

import 'package:tmc/providers/singleCourse_provider.dart';
import 'package:tmc/screens/courses/payment.dart';

import 'package:tmc/screens/courses/videoInfo.dart';
import 'package:tmc/screens/quiz_screen/welcome/welcomeQiuzScreen.dart';

import '../../utils/colors.dart' as color;

class CourseDetailsSJ extends StatefulWidget {
  final String courseTitle;
  final String courseSubtitle;
  final String courseID;
  final int price;

  CourseDetailsSJ(
      {Key? key,
      required this.courseTitle,
      required this.courseSubtitle,
      required this.courseID,
      required this.price})
      : super(key: key);

  @override
  State<CourseDetailsSJ> createState() => _CourseDetailsSJState();
}

class _CourseDetailsSJState extends State<CourseDetailsSJ>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  late ScrollController _scrollController;

  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String courseName = widget.courseTitle;
    return Scaffold(
      body: NestedScrollView(
        controller: _scrollController,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              pinned: true,
              floating: true,
              centerTitle: false,
              backgroundColor: color.AppColor.gradientSecond,
              title: Text(courseName),
              bottom: TabBar(
                indicatorWeight: 5.0,
                indicatorColor: Colors.white,
                controller: _tabController,
                tabs: [
                  Tab(
                    text: "Details",
                  ),
                  Tab(
                    text: "Classes",
                  ),
                  Tab(
                    text: "Test",
                  ),
                ],
              ),
            )
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: [
            Details(
              courseDetails: widget.courseSubtitle,
              courseID: widget.courseID,
              price: widget.price,
            ),
            Classes(
              courseID: widget.courseID,
            ),
            Test(
              courseID: widget.courseID,
              courseType: 'singleCourse',
            ),
          ],
        ),
      ),
    );
  }
}

class Details extends StatefulWidget {
  final String courseDetails;
  final String courseID;
  final int price;
  Details(
      {Key? key,
      required this.courseDetails,
      required this.courseID,
      required this.price})
      : super(key: key);

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
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
    super.initState();
    loading();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isloading
          ? Center(
              child: CircularProgressIndicator(
                  color: color.AppColor.gradientSecond),
            )
          : Stack(
              children: <Widget>[
                SafeArea(
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          color: color.AppColor.homePageBackground,
                          child: Column(
                            children: <Widget>[
                              const SizedBox(height: 30.0),
                              Expanded(
                                child: SingleChildScrollView(
                                  physics: BouncingScrollPhysics(),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      ListTile(
                                        title: Text(
                                          "About Us",
                                          style: TextStyle(
                                              color:
                                                  color.AppColor.homePageTitle,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 28.0),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16.0, vertical: 8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "WELCOME TO",
                                              style: TextStyle(
                                                color: color
                                                    .AppColor.gradientFirst,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 2,
                                            ),
                                            Text(
                                              "TALENT MANAGEMENT CENTER",
                                              style: TextStyle(
                                                color: color
                                                    .AppColor.gradientFirst,
                                                fontSize: 18,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 2,
                                            ),
                                            Text(
                                              "We build your talent for jobs. To give opportunity at big Multi National Companies.",
                                              style: TextStyle(
                                                  color: color
                                                      .AppColor.gradientFirst),
                                            ),
                                          ],
                                        ),
                                      ),
                                      ExpansionTile(
                                        title: Text(
                                          "Show Course Details",
                                          style: TextStyle(
                                              color:
                                                  color.AppColor.homePageTitle,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        children: <Widget>[
                                          Container(
                                            alignment: Alignment.topLeft,
                                            padding: const EdgeInsets.all(16.0),
                                            child: Text(
                                              widget.courseDetails,
                                              style: TextStyle(
                                                  color: color
                                                      .AppColor.gradientFirst),
                                            ),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Divider(
                                        height: 2,
                                        color: color.AppColor.gradientSecond,
                                      ),
                                      Container(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            ListTile(
                                              title: Text(
                                                "Meet Our Faculty",
                                                style: TextStyle(
                                                    color: color
                                                        .AppColor.homePageTitle,
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
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Color(
                                                                0xFF839fed),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        2),
                                                          ),
                                                        )
                                                      : Container(
                                                          width: 3,
                                                          height: 1,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        2),
                                                          ),
                                                        ),
                                              ],
                                            ),
                                            Container(
                                              padding: EdgeInsets.all(10),
                                              child: SingleChildScrollView(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                child: Row(
                                                  children: [
                                                    Column(
                                                      children: [
                                                        Container(
                                                          child: GFImageOverlay(
                                                            height: 150,
                                                            width: 150,
                                                            shape:
                                                                BoxShape.circle,
                                                            border: Border.all(
                                                                color: color
                                                                    .AppColor
                                                                    .gradientFirst,
                                                                width: 2),
                                                            image: AssetImage(
                                                                "assets/adity.jpg"),
                                                            boxFit:
                                                                BoxFit.cover,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 5,
                                                        ),
                                                        Container(
                                                          width: 180,
                                                          height: 30,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            gradient:
                                                                LinearGradient(
                                                              colors: [
                                                                color.AppColor
                                                                    .secondPageContainerGradient1stColor,
                                                                color.AppColor
                                                                    .secondPageContainerGradient2ndColor
                                                              ],
                                                              begin: Alignment
                                                                  .bottomLeft,
                                                              end: Alignment
                                                                  .topRight,
                                                            ),
                                                          ),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Icon(
                                                                Icons.person,
                                                                size: 20,
                                                                color: color
                                                                    .AppColor
                                                                    .secondPageIconColor,
                                                              ),
                                                              SizedBox(
                                                                width: 5,
                                                              ),
                                                              Text(
                                                                "Adity Sharma",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        16,
                                                                    color: color
                                                                        .AppColor
                                                                        .secondPageIconColor),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Column(
                                                      children: [
                                                        Container(
                                                          child: GFImageOverlay(
                                                            height: 150,
                                                            width: 150,
                                                            shape:
                                                                BoxShape.circle,
                                                            border: Border.all(
                                                                color: color
                                                                    .AppColor
                                                                    .gradientFirst,
                                                                width: 2),
                                                            image: AssetImage(
                                                                "assets/tanya.jpg"),
                                                            boxFit:
                                                                BoxFit.cover,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 5,
                                                        ),
                                                        Container(
                                                          width: 180,
                                                          height: 30,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            gradient:
                                                                LinearGradient(
                                                              colors: [
                                                                color.AppColor
                                                                    .secondPageContainerGradient1stColor,
                                                                color.AppColor
                                                                    .secondPageContainerGradient2ndColor
                                                              ],
                                                              begin: Alignment
                                                                  .bottomLeft,
                                                              end: Alignment
                                                                  .topRight,
                                                            ),
                                                          ),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Icon(
                                                                Icons.person,
                                                                size: 20,
                                                                color: color
                                                                    .AppColor
                                                                    .secondPageIconColor,
                                                              ),
                                                              SizedBox(
                                                                width: 5,
                                                              ),
                                                              Text(
                                                                "Tanya Sharma",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        16,
                                                                    color: color
                                                                        .AppColor
                                                                        .secondPageIconColor),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Column(
                                                      children: [
                                                        Container(
                                                          child: GFImageOverlay(
                                                            height: 150,
                                                            width: 150,
                                                            shape:
                                                                BoxShape.circle,
                                                            border: Border.all(
                                                                color: color
                                                                    .AppColor
                                                                    .gradientFirst,
                                                                width: 2),
                                                            image: AssetImage(
                                                                "assets/ranjan.jpg"),
                                                            boxFit:
                                                                BoxFit.cover,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 5,
                                                        ),
                                                        Container(
                                                          width: 180,
                                                          height: 30,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            gradient:
                                                                LinearGradient(
                                                              colors: [
                                                                color.AppColor
                                                                    .secondPageContainerGradient1stColor,
                                                                color.AppColor
                                                                    .secondPageContainerGradient2ndColor
                                                              ],
                                                              begin: Alignment
                                                                  .bottomLeft,
                                                              end: Alignment
                                                                  .topRight,
                                                            ),
                                                          ),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Icon(
                                                                Icons.person,
                                                                size: 20,
                                                                color: color
                                                                    .AppColor
                                                                    .secondPageIconColor,
                                                              ),
                                                              SizedBox(
                                                                width: 5,
                                                              ),
                                                              Text(
                                                                "Ranjan Pradhan",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        16,
                                                                    color: color
                                                                        .AppColor
                                                                        .secondPageIconColor),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Divider(
                                        height: 2,
                                        color: Colors.black,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Center(
                                          child: Text(
                                        "Steps for getting placed in your dream company",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      )),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          const Text(
                                            "• Step 1: ",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Expanded(
                                            child: Text(
                                              "Choose a course as per your preference and interest. ",
                                              style: TextStyle(
                                                  color: color.AppColor
                                                      .homePageSubtitle),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          const Text(
                                            "• Step 2: ",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Expanded(
                                            child: Text(
                                              "Complete all classes and tests.",
                                              style: TextStyle(
                                                  color: color.AppColor
                                                      .homePageSubtitle),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          const Text(
                                            "• Step 3: ",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Expanded(
                                            child: Text(
                                              "Our team will schedule a mock interview and prepare you for the job interview.",
                                              style: TextStyle(
                                                  color: color.AppColor
                                                      .homePageSubtitle),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          const Text(
                                            "• Step 4: ",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Expanded(
                                            child: Text(
                                              "Finally, you will get your dream job.",
                                              style: TextStyle(
                                                  color: color.AppColor
                                                      .homePageSubtitle),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Divider(
                                        height: 2,
                                        color: Colors.black,
                                      ),
                                      Divider(
                                        height: 2,
                                        color: color.AppColor.gradientSecond,
                                      ),
                                      SizedBox(
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              ListTile(
                                                title: Text(
                                                  "Contact Us",
                                                  style: TextStyle(
                                                      color: color.AppColor
                                                          .homePageTitle,
                                                      fontWeight:
                                                          FontWeight.bold,
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
                                                            decoration:
                                                                BoxDecoration(
                                                              color: Color(
                                                                  0xFF839fed),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          2),
                                                            ),
                                                          )
                                                        : Container(
                                                            width: 3,
                                                            height: 1,
                                                            decoration:
                                                                BoxDecoration(
                                                              color:
                                                                  Colors.white,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          2),
                                                            ),
                                                          ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 16.0,
                                                        vertical: 8.0),
                                                child: Text(
                                                  "Feel free to contact us if you have any problems.",
                                                  style: TextStyle(
                                                      color: color.AppColor
                                                          .gradientFirst),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: DottedBorder(
                                                  borderType: BorderType.RRect,
                                                  radius: Radius.circular(12),
                                                  padding: EdgeInsets.all(6),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                12)),
                                                    child: Container(
                                                      height: 280,
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                      color:
                                                          color.AppColor.card,
                                                      child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(10),
                                                              child: Row(
                                                                children: [
                                                                  Text(
                                                                    "Phone Number : ",
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            20,
                                                                        fontWeight:
                                                                            FontWeight.w500),
                                                                  ),
                                                                  SizedBox(
                                                                    width: 30,
                                                                  ),
                                                                  Text(
                                                                    "620-651-0351",
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            20),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(10),
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    "Email Address : ",
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            20,
                                                                        fontWeight:
                                                                            FontWeight.w500),
                                                                  ),
                                                                  SizedBox(
                                                                    height: 5,
                                                                  ),
                                                                  Text(
                                                                    "talentmanagementcenterjsr@gmail.com",
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            15),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(10),
                                                              child: Row(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    "Address : ",
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            20,
                                                                        fontWeight:
                                                                            FontWeight.w500),
                                                                  ),
                                                                  SizedBox(
                                                                    width: 30,
                                                                  ),
                                                                  Expanded(
                                                                    child: Text(
                                                                      "1st FLOOR , NEAR SHARDA BOOK STORE, GAMHARIA , JAMSHEDPUR , JHARKHAND , INDIA, PINCODE: 832108",
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              15),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(10),
                                                              child: Row(
                                                                children: [
                                                                  Text(
                                                                    "Website URL : ",
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            20,
                                                                        fontWeight:
                                                                            FontWeight.w500),
                                                                  ),
                                                                  SizedBox(
                                                                    width: 30,
                                                                  ),
                                                                  Text(
                                                                    "www.tmcjsr.com",
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            20),
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
                              Container(
                                padding: const EdgeInsets.all(20.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20.0),
                                      topRight: Radius.circular(20.0)),
                                  color: color.AppColor.gradientSecond,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      "\u20B9${widget.price}",
                                      style: TextStyle(
                                          color: color
                                              .AppColor.secondPageTitleColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18.0),
                                    ),
                                    const SizedBox(width: 15.0),
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => Payment(
                                                      courseID: widget.courseID,
                                                      courseType:
                                                          'singleCourse',
                                                      price: widget.price,
                                                    )));
                                      },
                                      style: ButtonStyle(
                                          padding: MaterialStateProperty.all<
                                                  EdgeInsets>(
                                              EdgeInsets.symmetric(
                                                  vertical: 8.0,
                                                  horizontal: 16.0)),
                                          shape: MaterialStateProperty.all<
                                                  RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            side: BorderSide(
                                                color: color
                                                    .AppColor.gradientFirst),
                                          ))),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Text(
                                            "START NOW",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16.0),
                                          ),
                                          const SizedBox(width: 15.0),
                                          Container(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Icon(
                                              Icons.arrow_forward_ios,
                                              color:
                                                  color.AppColor.gradientFirst,
                                              size: 16.0,
                                            ),
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        10.0)),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
    );
  }
}

class Classes extends StatefulWidget {
  final String courseID;
  Classes({Key? key, required this.courseID}) : super(key: key);

  @override
  State<Classes> createState() => _ClassesState();
}

class _ClassesState extends State<Classes> {
  late SingleCourseProvider singleCourseProvider;
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
    super.initState();
    SingleCourseProvider singleCourseProvider =
        Provider.of(context, listen: false);
    singleCourseProvider.fetchClassData(widget.courseID);
    loading();
  }

  @override
  Widget build(BuildContext context) {
    singleCourseProvider = Provider.of(context);
    return Consumer<SingleCourseProvider>(builder: (context, classData, index) {
      var classes = classData.getClassList;
      return Scaffold(
          body: isloading
              ? Center(
                  child: CircularProgressIndicator(
                      color: color.AppColor.gradientSecond),
                )
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: GridView.builder(
                      controller: new ScrollController(keepScrollOffset: false),
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      primary: false,
                      itemCount: classes.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 4.0,
                          mainAxisSpacing: 4.0,
                          childAspectRatio: MediaQuery.of(context).size.width /
                              (MediaQuery.of(context).size.height / 1.3)),
                      itemBuilder: (BuildContext context, int index) {
                        return DottedBorder(
                          borderType: BorderType.RRect,
                          radius: Radius.circular(12),
                          padding: EdgeInsets.all(6),
                          child: ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                            child: Container(
                              height: 240,
                              width: 155,
                              color: color.AppColor.card,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 130,
                                    width: 155,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10)),
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              classes[index].image),
                                          fit: BoxFit.cover),
                                      color: Colors.grey[300],
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            classes[index].title,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 13,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            "Total Videos : ${classes[index].videos}",
                                            style: TextStyle(
                                                color: color.AppColor
                                                    .homePageContainerTextBig,
                                                fontSize: 15),
                                          ),
                                          SizedBox(
                                            height: 3,
                                          ),
                                          Text(
                                            "Total Duration : ${classes[index].duration} Mint",
                                            style: TextStyle(
                                                color: color.AppColor
                                                    .homePageContainerTextBig,
                                                fontSize: 11),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          SizedBox(
                                            width: 100,
                                            height: 30,
                                            child: ElevatedButton(
                                              onPressed: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          VideoInfo(
                                                            courseID:
                                                                widget.courseID,
                                                            classID:
                                                                classes[index]
                                                                    .id,
                                                            mint: classes[index]
                                                                .duration,
                                                            title:
                                                                classes[index]
                                                                    .title,
                                                            subtitle:
                                                                classes[index]
                                                                    .subtitle,
                                                            totalvideo:
                                                                classes[index]
                                                                    .videos,
                                                            courseType:
                                                                "singleCourse",
                                                          )),
                                                );
                                              },
                                              style: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStateProperty.all(
                                                          color.AppColor
                                                              .gradientSecond)),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(5),
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
                          ),
                        );
                      },
                    ),
                  ),
                ));
    });
  }
}

class Test extends StatefulWidget {
  final String courseID;
  final String courseType;
  Test({Key? key, required this.courseID, required this.courseType})
      : super(key: key);

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
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
    super.initState();
    loading();
  }

  @override
  Widget build(BuildContext context) {
    return isloading
        ? Center(
            child:
                CircularProgressIndicator(color: color.AppColor.gradientSecond),
          )
        : WelcomeQuizScreen(
            courseID: widget.courseID,
            courseType: widget.courseType,
          );
  }
}
