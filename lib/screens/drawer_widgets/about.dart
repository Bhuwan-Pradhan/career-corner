import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:tmc/providers/testimonials_provider.dart';
import '../../utils/colors.dart' as color;

class About extends StatefulWidget {
  const About({Key? key}) : super(key: key);

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {
  late TestimonialsProvider testimonialsProvider;

  @override
  void initState() {
    super.initState();
    TestimonialsProvider testimonialsProvider =
        Provider.of(context, listen: false);
    testimonialsProvider.fetchTestimonialsData();
  }

  @override
  Widget build(BuildContext context) {
    testimonialsProvider = Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: color.AppColor.gradientSecond,
        leading: IconButton(
          onPressed: (() {
            Get.back();
          }),
          icon: Icon(Icons.arrow_back_ios),
        ),
      ),
      body: SizedBox(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                title: Text(
                  "About Us",
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
                padding: EdgeInsets.all(10),
                child: SizedBox(
                  child: Column(
                    children: [
                      Center(
                        child: Container(
                          height: 200,
                          width: 220,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(
                                  image: AssetImage(
                                    "assets/logo.jpg",
                                  ),
                                  fit: BoxFit.cover)),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                          "We build your skill for jobs. To give opportunity at big MultiNationional Companies. Here, we connect students to employers by scheduling interviews, matching students with their relevant fields, providing Internships, and hooking them to companies."),
                      SizedBox(
                        height: 10,
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
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const Text(
                            "• Step 1: ",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          Expanded(
                            child: Text(
                              "Choose a course as per your preference and interest. ",
                              style: TextStyle(
                                  color: color.AppColor.homePageSubtitle),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const Text(
                            "• Step 2: ",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          Expanded(
                            child: Text(
                              "Complete all classes and tests.",
                              style: TextStyle(
                                  color: color.AppColor.homePageSubtitle),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const Text(
                            "• Step 3: ",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          Expanded(
                            child: Text(
                              "Our team will schedule a mock interview and prepare you for the job interview.",
                              style: TextStyle(
                                  color: color.AppColor.homePageSubtitle),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const Text(
                            "• Step 4: ",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          Expanded(
                            child: Text(
                              "Finally, you will get your dream job.",
                              style: TextStyle(
                                  color: color.AppColor.homePageSubtitle),
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
                      SizedBox(
                        height: 10,
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
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
