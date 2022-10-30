import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:tmc/providers/course_provider.dart';
import 'package:tmc/screens/courses/video.dart';
import '../../utils/colors.dart' as color;

class VideoInfo extends StatefulWidget {
  final String courseType;
  final String classID;
  final String courseID;
  final String title;
  final String subtitle;

  final int mint;
  final int totalvideo;

  const VideoInfo(
      {Key? key,
      required this.title,
      required this.subtitle,
      required this.mint,
      required this.totalvideo,
      required this.classID,
      required this.courseID,
      required this.courseType})
      : super(key: key);

  @override
  State<VideoInfo> createState() => _VideoInfoState();
}

class _VideoInfoState extends State<VideoInfo> {
  late CourseProvider courseProvider;
  bool isloading = true;
  loading() async {
    await Future.delayed(Duration(seconds: 3));
    if (mounted) {
      setState(() {
        isloading = false;
      });
    }
  }

  bool _isPurchased = false;
  void getUserData() async {
    var collection = FirebaseFirestore.instance.collection(widget.courseType);
    var docSnapshot = await collection
        .doc(widget.courseID)
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    if (docSnapshot.exists) {
      Map<String, dynamic>? data = docSnapshot.data();

      var isPurchased =
          data?['isPurchased']; // <-- The value you want to retrieve.
      // Call setState if needed.
      setState(() {
        _isPurchased = isPurchased;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    CourseProvider courseProvider = Provider.of(context, listen: false);
    courseProvider.fetchCourseVideoData(
        widget.courseType, widget.courseID, widget.classID);
    getUserData();
    loading();
  }

  @override
  Widget build(BuildContext context) {
    courseProvider = Provider.of(context);
    return Consumer<CourseProvider>(builder: (context, videoData, index) {
      var videos = videoData.getCourseVideoList;
      return Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                color.AppColor.gradientFirst.withOpacity(0.9),
                color.AppColor.gradientSecond
              ],
              begin: const FractionalOffset(0.0, 0.4),
              end: Alignment.topRight,
            ),
          ),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(top: 70, left: 30, right: 30),
                width: MediaQuery.of(context).size.width,
                height: 300,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: Icon(Icons.arrow_back_ios,
                              size: 20,
                              color: color.AppColor.secondPageIconColor),
                        ),
                        Expanded(child: Container()),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      widget.title,
                      style: TextStyle(
                          fontSize: 25,
                          color: color.AppColor.secondPageTitleColor),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      widget.subtitle,
                      style: TextStyle(
                          fontSize: 25,
                          color: color.AppColor.secondPageTitleColor),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Container(
                      width: 200,
                      height: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: LinearGradient(
                          colors: [
                            color.AppColor.secondPageContainerGradient1stColor,
                            color.AppColor.secondPageContainerGradient2ndColor
                          ],
                          begin: Alignment.bottomLeft,
                          end: Alignment.topRight,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.timer,
                            size: 20,
                            color: color.AppColor.secondPageIconColor,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            " Total Duration : ${widget.mint} mint",
                            style: TextStyle(
                                fontSize: 16,
                                color: color.AppColor.secondPageIconColor),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              isloading
                  ? Center(
                      child: CircularProgressIndicator(
                          color: Colors.white),
                    )
                  : Expanded(
                      child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.only(topRight: Radius.circular(70))),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 30,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                widget.title +
                                    ": Watch all ${widget.totalvideo} videos",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: color.AppColor.circuitsColor),
                              ),
                              Expanded(child: Container()),
                              SizedBox(
                                width: 20,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Expanded(
                            child: ListView.builder(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 8),
                              itemCount: videos.length,
                              itemBuilder: ((context, index) {
                                return GestureDetector(
                                    onTap: () {
                                      _isPurchased
                                          ? Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => Video(
                                                        videoUrl: videos[index]
                                                            .videoUrl,
                                                        title:
                                                            videos[index].title,
                                                        description:
                                                            videos[index]
                                                                .description,
                                                      )))
                                          : showDialog(
                                              context: context,
                                              builder: (ctx) => AlertDialog(
                                                title: const Text(
                                                  "Alert",
                                                  style:
                                                      TextStyle(fontSize: 25),
                                                ),
                                                content: const Text(
                                                  "Purchase the course to access class videos, and tests and get an assured job after the course.",
                                                  style:
                                                      TextStyle(fontSize: 20),
                                                ),
                                                actions: <Widget>[
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.of(ctx).pop();
                                                    },
                                                    child: Center(
                                                      child: Container(
                                                        color: color.AppColor
                                                            .gradientFirst,
                                                        padding:
                                                            const EdgeInsets
                                                                .all(14),
                                                        child: const Text(
                                                          "okay",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                    },
                                    child: _buildCard(
                                        videos[index].thumbnail,
                                        videos[index].title,
                                        videos[index].time));
                              }),
                            ),
                          )
                        ],
                      ),
                    ))
            ],
          ),
        ),
      );
    });
  }

  _buildCard(String thumbnail, String title, String time) {
    return Container(
      height: 135,
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                      image: NetworkImage(thumbnail), fit: BoxFit.cover),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 3),
                    child: Text(
                      time,
                      style: TextStyle(
                        color: Colors.grey[500],
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
          SizedBox(
            height: 18,
          ),
          Row(
            children: [
              Container(
                width: 80,
                height: 20,
                decoration: BoxDecoration(
                  color: Color(0xFFeaeefc),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    "Career Corner",
                    style: TextStyle(
                      color: Color(0xFF839fed),
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  for (int i = 0; i < 70; i++)
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
            ],
          ),
        ],
      ),
    );
  }
}
