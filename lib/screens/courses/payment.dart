import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:tmc/screens/courses/course_screen.dart';
import '../../utils/colors.dart' as color;

class Payment extends StatefulWidget {
  Payment(
      {Key? key,
      required this.courseID,
      required this.courseType,
      required this.price})
      : super(key: key);
  final String courseID;
  final String courseType;
  final int price;
  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  static const platform = const MethodChannel("razorpay_flutter");

  late Razorpay _razorpay;
  bool _isPurchased = false;

  String _userName = "";
  String _phone = "";
  String _email = "";
  String _paymentId = "";

  void getUserData() async {
    var collection = FirebaseFirestore.instance.collection('users');
    var docSnapshot =
        await collection.doc(FirebaseAuth.instance.currentUser!.uid).get();
    if (docSnapshot.exists) {
      Map<String, dynamic>? data = docSnapshot.data();
      var userName = data?['userName']; // <-- The value you want to retrieve.
      var phone = data?['phone']; // <-- The value you want to retrieve.
      var email = data?['email']; // <-- The value you want to retrieve.
      // Call setState if needed.
      setState(() {
        _userName = userName;
        _phone = phone;
        _email = email;
      });
    }
  }

  @override
  void initState() {
    getUserData();
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    isPurchased();
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  void openCheckout() async {
    var options = {
      'key': 'rzp_test_O6M91ECvFZu3XW',
      'amount': widget.price * 100,
      'name': 'Talent Management Cneter',
      'description': 'Payment',
      'retry': {'enabled': true, 'max_count': 1},
      'send_sms_hash': true,
      'prefill': {'contact': _phone, 'email': _email},
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
 
    setState(() {
      _isPurchased = true;
      _paymentId = response.paymentId!;
      purchased();
    });

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text(
          "Thank You",
          style: TextStyle(fontSize: 25),
        ),
        content: const Text(
          "Payment Successfully. Congrats! \n Complete the course and get a place in your dream company.",
          style: TextStyle(fontSize: 20),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Get.off(() => Courses());
            },
            child: Center(
              child: Container(
                color: color.AppColor.gradientFirst,
                padding: const EdgeInsets.all(14),
                child: const Text(
                  "okay",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _handlePaymentError(PaymentFailureResponse response) {
     
    Fluttertoast.showToast(
        msg: "ERROR: " + response.code.toString() + " - " + response.message!,
        toastLength: Toast.LENGTH_SHORT);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    
    Fluttertoast.showToast(
        msg: "EXTERNAL_WALLET: " + response.walletName!,
        toastLength: Toast.LENGTH_SHORT);
  }

  void isPurchased() async {
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
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isPurchased
          ? Center(
              child: Container(
                  margin: EdgeInsets.all(30),
                  padding: EdgeInsets.all(20),
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: color.AppColor.card,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.black, width: 2)),
                  child: Center(
                    child: Text(
                      "You Already Paid !",
                      style: TextStyle(fontSize: 20),
                    ),
                  )),
            )
          : Center(
              child: Container(
                margin: EdgeInsets.all(30),
                padding: EdgeInsets.all(20),
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: color.AppColor.card,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.black, width: 2)),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 50,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Name: ",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            child: Text(
                              _userName,
                              style: TextStyle(
                                  color: color.AppColor.homePageSubtitle,
                                  fontSize: 20),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Phone No. : ",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            child: Text(
                              _phone,
                              style: TextStyle(
                                  color: color.AppColor.homePageSubtitle,
                                  fontSize: 20),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Email Id: ",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        _email,
                        style: TextStyle(
                            color: color.AppColor.homePageSubtitle,
                            fontSize: 20),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Total Price:  \u20B9${widget.price}",
                        style: TextStyle(
                            color: color.AppColor.homePageSubtitle,
                            fontSize: 20,
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: InkWell(
                          onTap: openCheckout,
                          child: Container(
                            height: 50,
                            width: 200,
                            decoration: BoxDecoration(
                                color: color.AppColor.gradientSecond,
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                    color: Colors.black54, width: 2)),
                            child: Center(
                              child: Text(
                                "Buy Now",
                                style: TextStyle(fontSize: 30),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  purchased() {
    Map<String, dynamic> data = {
      'isPurchased': _isPurchased,
      'userName': _userName,
      'phone': _phone,
      'email': _email,
      'paymentId': _paymentId,
    };
    FirebaseFirestore.instance
        .collection(widget.courseType)
        .doc(widget.courseID)
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set(data);
  }
}
