import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:tmc/providers/job_provider.dart';

import 'package:tmc/screens/jobs/job_apply.dart';
import '../../utils/colors.dart' as color;

class JobsDetails extends StatefulWidget {
  final String job_name;
  final String logo_text;
  final String location;
  final String salary;
  final String eligibility;
  final String id;

  const JobsDetails(
      {required this.logo_text,
      required this.job_name,
      required this.eligibility,
      required this.id,
      required this.location,
      required this.salary});

  @override
  State<JobsDetails> createState() => _JobsDetailsState();
}

class _JobsDetailsState extends State<JobsDetails> {
  late JobProvider jobProvider;

  @override
  void initState() {
    JobProvider jobProvider = Provider.of(context, listen: false);
    jobProvider.fetchJobRoleData(widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    jobProvider = Provider.of(context);

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
              padding: const EdgeInsets.only(top: 50, left: 30, right: 30),
              width: MediaQuery.of(context).size.width,
              height: 240,
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
                      Icon(Icons.info_outline,
                          size: 20, color: color.AppColor.secondPageIconColor),
                    ],
                  ),
                  Center(
                    child: Container(
                      height: 130,
                      width: 130,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(200),
                        border: Border.all(
                            color: color.AppColor.secondPageIconColor),
                        image: DecorationImage(
                          image: NetworkImage(
                            widget.logo_text,
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(70),
                        topLeft: Radius.circular(70))),
                child: Column(
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 30,
                        ),
                        Text(
                          widget.job_name,
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: color.AppColor.gradientFirst),
                        ),
                        Expanded(child: Container()),
                        SizedBox(
                          width: 20,
                        ),
                      ],
                    ),
                    Divider(
                      indent: 20,
                      endIndent: 20,
                      color: color.AppColor.homePageTitle,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Expanded(
                      child: Container(
                          child: SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 30,
                                      ),
                                      Text(
                                        "Salary :",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color:
                                                color.AppColor.circuitsColor),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 20, horizontal: 30),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: SizedBox(
                                          child: Text(
                                        widget.salary,
                                        style: TextStyle(
                                            color: color
                                                .AppColor.homePageSubtitle),
                                      )),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 30,
                                      ),
                                      Text(
                                        "Location :",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color:
                                                color.AppColor.circuitsColor),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 20, horizontal: 30),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: SizedBox(
                                          child: Text(
                                        widget.location,
                                        style: TextStyle(
                                            color: color
                                                .AppColor.homePageSubtitle),
                                      )),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 30,
                                      ),
                                      Text(
                                        "Eligibility :",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color:
                                                color.AppColor.circuitsColor),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 20, horizontal: 30),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: SizedBox(
                                          child: Text(
                                        widget.eligibility,
                                        style: TextStyle(
                                            color: color
                                                .AppColor.homePageSubtitle),
                                      )),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 30,
                                      ),
                                      Text(
                                        "Job Role :",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color:
                                                color.AppColor.circuitsColor),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 20, horizontal: 30),
                                      child: SizedBox(
                                          child: Column(
                                              children: jobProvider
                                                  .getJobRoleList
                                                  .map((jobRoles) {
                                        return Column(
                                          children: [
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                const Text("• "),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    jobRoles.role,
                                                    style: TextStyle(
                                                        color: color.AppColor
                                                            .homePageSubtitle),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 8,
                                            )
                                          ],
                                        );
                                      }).toList()))),
                                ],
                              ),
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
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            2),
                                                  ),
                                                )
                                              : Container(
                                                  width: 3,
                                                  height: 1,
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            2),
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
                                        style: TextStyle(
                                            color:
                                                color.AppColor.gradientFirst),
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
                      )),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => JobApply(
                      job_name: widget.job_name,
                      id: widget.id,
                    )),
          );
        },
        label: const Text('Apply Now'),
        icon: const Icon(Icons.thumb_up),
        backgroundColor: color.AppColor.gradientFirst,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

class UnorderedList extends StatelessWidget {
  const UnorderedList(this.texts, {super.key});
  final List<String> texts;

  @override
  Widget build(BuildContext context) {
    var widgetList = <Widget>[];
    for (var text in texts) {
      // Add list item
      widgetList.add(UnorderedListItem(text));
      // Add space between items
      widgetList.add(const SizedBox(height: 5.0));
    }

    return Column(children: widgetList);
  }
}

class UnorderedListItem extends StatelessWidget {
  const UnorderedListItem(this.text, {super.key});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text("• "),
        Expanded(
          child: Text(
            text,
            style: TextStyle(color: color.AppColor.homePageSubtitle),
          ),
        ),
      ],
    );
  }
}
