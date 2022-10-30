import 'package:flutter/material.dart';
import '../../utils/colors.dart' as color;

class SingleJob extends StatelessWidget {
  final String name;
  final String location;
  final String salary;
  final String logoText;

  const SingleJob({
    required this.name,
    required this.location,
    required this.salary,
    required this.logoText,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Color.fromARGB(255, 204, 213, 241),
                border: Border.all(color: color.AppColor.homePageSubtitle)),
            width: double.infinity,
            height: 110,
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 50,
                  height: 50,
                  margin: EdgeInsets.only(right: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(
                        width: 3, color: color.AppColor.homePageSubtitle),
                    image: DecorationImage(
                        image: NetworkImage(logoText), fit: BoxFit.fill),
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        name,
                        style: TextStyle(
                            color: color.AppColor.homePageTitle,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Row(
                        children: <Widget>[
                          Icon(
                            Icons.location_on,
                            color: color.AppColor.homePageIcons,
                            size: 20,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(location,
                              style: TextStyle(
                                  color: color.AppColor.gradientSecond,
                                  fontSize: 13,
                                  letterSpacing: .3)),
                        ],
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Row(
                        children: <Widget>[
                          Icon(
                            Icons.account_balance_wallet_rounded,
                            color: color.AppColor.homePageIcons,
                            size: 20,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          SizedBox(
                            child: Text(salary,
                                style: TextStyle(
                                    color: color.AppColor.gradientSecond,
                                    fontSize: 13,
                                    letterSpacing: .3)),
                          ),
                          Expanded(child: Container()),
                          SizedBox(
                            child: Row(
                              children: [
                                Text(
                                  "Details",
                                  style: TextStyle(
                                      color: color.AppColor.gradientFirst,
                                      fontSize: 18),
                                ),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  color: color.AppColor.gradientFirst,
                                  size: 20,
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
