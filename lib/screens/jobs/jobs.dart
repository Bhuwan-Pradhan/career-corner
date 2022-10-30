import 'package:flutter/material.dart';


import 'package:provider/provider.dart';


import 'package:tmc/screens/jobs/jobs_details.dart';
import 'package:tmc/screens/jobs/single_job.dart';
import 'package:tmc/providers/job_provider.dart';


import 'package:tmc/widgets/drawer.dart';
import '../../utils/colors.dart' as color;

class Jobs extends StatefulWidget {
  Jobs({Key? key}) : super(key: key);

  _JobsState createState() => _JobsState();
}

class _JobsState extends State<Jobs> {
  late JobProvider jobProvider;
  bool isloading = true;
  int _selectedIndex = 3;
  final GlobalKey<ScaffoldState> _jobState = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    JobProvider jobProvider = Provider.of(context, listen: false);
    jobProvider.fetchJobData();
    super.initState();
    loading();
  }

  loading() async {
    await Future.delayed(Duration(seconds: 3));
    if (mounted) {
      setState(() {
        isloading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    jobProvider = Provider.of(context);

    return Scaffold(
      key: _jobState,
      drawer: Mydrawer(),
      backgroundColor: color.AppColor.homePageBackground,
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: <Widget>[
              isloading
                  ? Center(
                      child: CircularProgressIndicator(
                        color: color.AppColor.gradientSecond,
                      ),
                    )
                  : Container(
                      padding: EdgeInsets.only(top: 150),
                      height: MediaQuery.of(context).size.height,
                      width: double.infinity,
                      child: Column(
                        children: jobProvider.getJobDataList.map(
                          (jobData) {
                            return InkWell(
                                onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => JobsDetails(
                                              job_name: jobData.name,
                                              logo_text: jobData.logoText,
                                              eligibility: jobData.eligibility,
                                              id: jobData.id,
                                              location: jobData.location,
                                              salary: jobData.salary,
                                            ))),
                                child: SingleJob(
                                  location: jobData.location,
                                  name: jobData.name,
                                  salary: jobData.salary,
                                  logoText: jobData.logoText,
                                ));
                          },
                        ).toList(),
                      ),
                    ),
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            "Jobs",
                            style: TextStyle(color: Colors.white, fontSize: 24),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.filter_list,
                              color: Colors.white,
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
            ],
          ),
        ),
      ),
      
    );
  }
}
