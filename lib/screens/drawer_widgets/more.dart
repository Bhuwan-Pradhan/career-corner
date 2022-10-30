import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tmc/screens/drawer_widgets/more/pp.dart';
import 'package:tmc/screens/drawer_widgets/more/rc.dart';
import 'package:tmc/screens/drawer_widgets/more/t&c.dart';
import '../../utils/colors.dart' as color;

class More extends StatelessWidget {
  const More({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: color.AppColor.gradientSecond,
        leading: IconButton(
          onPressed: (() {
            Get.back();
          }),
          icon: Icon(Icons.arrow_back_ios),
        ),
        title: Text("Policy"),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () {
              Get.to(() => Terms());
            },
            child: Container(
              height: 50,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                      color: color.AppColor.homePageSubtitle, width: 1)),
              child: Row(
                children: [
                  Text("Terms and Conditions"),
                  Expanded(child: Container()),
                  Icon(Icons.arrow_forward_ios)
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () {
              Get.to(() => PP());
            },
            child: Container(
              height: 50,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                      color: color.AppColor.homePageSubtitle, width: 1)),
              child: Row(
                children: [
                  Text("Privacy policy"),
                  Expanded(child: Container()),
                  Icon(Icons.arrow_forward_ios)
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () {
              Get.to(() => RC());
            },
            child: Container(
              height: 50,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                      color: color.AppColor.homePageSubtitle, width: 1)),
              child: Row(
                children: [
                  Text("Refund and Cancellation policy"),
                  Expanded(child: Container()),
                  Icon(Icons.arrow_forward_ios)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
