import 'package:flutter/material.dart';
import '../pages/otp_verify_page.dart';
//import 'package:sms_autofill/sms_autofill.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';
import 'package:snippet_coder_utils/hex_color.dart';

import '../services/api_service.dart';


class LoginPageOtpSms extends StatefulWidget {
  @override
  _LoginPageOtpSmsState createState() => _LoginPageOtpSmsState();
}

class _LoginPageOtpSmsState extends State<LoginPageOtpSms> {
  String mobileNumber = '';
  bool enableBtn = false;
  bool isAPIcallProcess = false;

  @override
  void initState() {
    super.initState();
    mobileNumber = '';
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ProgressHUD(
          child: loginUI(),
          inAsyncCall: isAPIcallProcess,
          opacity: 0.3,
          key: UniqueKey(),
        ),
      ),
    );
  }

  Widget loginUI() {
    return Scaffold(
      body: Column(
        //mainAxisAlignment: MainAxisAlignment.center,
        //crossAxisAlignment: CrossAxisAlignment.center,
        children:<Widget> [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 5.2,
              decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.white,
                  Colors.white,
                ],
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(100),
                topRight: Radius.circular(150),
                bottomRight: Radius.circular(100),
                bottomLeft: Radius.circular(100),
              ),
            ),
              child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // Padding(
                //   padding: const EdgeInsets.only(top: 20),
                //   child: Center(
                //     child: Text(
                //       "Shopping App",
                //       style: TextStyle(
                //         fontWeight: FontWeight.bold,
                //         fontSize: 40,
                //         color: HexColor("#283B71"),
                //       ),
                //     ),
                //   ),
                //),
                Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                    "assets/otp.png",
                    fit: BoxFit.cover,
                    width: 100,
                  ),
                ),
              ],
            ),

          ),
          const Padding(
            padding: EdgeInsets.only(top: 50),
            child: Center(
              child: Text(
                "Login with a Mobile Number",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          const Center(
            child: Text(
              "Enter your mobile number we will send you OTP to verify",
              style: TextStyle(
                fontSize: 14,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  child: Container(
                    height: 47,
                    width: 50,
                    margin: const EdgeInsets.fromLTRB(10, 10, 5, 32),
                    //padding: EdgeInsets.fromLTRB(0, 10, 0, 50),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(
                        color: Colors.grey,
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        "+60",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                Flexible(
                  flex: 5,
                  child: TextFormField(
                    maxLines: 1,
                    maxLength: 10,
                    initialValue: "01234567",
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.all(6),
                      hintText: "Mobile Number",
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey,
                          width: 1,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey,
                          width: 1,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey,
                          width: 1,
                        ),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: (String value) {
                      if (value.length > 8) {
                        mobileNumber = value;
                        enableBtn = true;
                      }
                    },
                    validator: (value) {
                      return null;
                    },
                  ),
                ),
              ],
            ),
          ),
         // Center(
            Row(
            //child: 
            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
            child: FormHelper.submitButton(
              "SEND",
              () async {
                if (enableBtn && mobileNumber.length > 8) {
                  setState(() {
                    isAPIcallProcess = true;
                  });

                  APIService.otpLogin(mobileNumber).then((response) async {
                    setState(() {
                      isAPIcallProcess = false;
                    });

                    if (response.data != null) {
                      String otpHash = response.data.toString(); // Convert Data to String
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OTPVerifyPage(
                            otpHash: otpHash,
                            mobileNo: mobileNumber,
                          ),
                        ),
                        (route) => false,
                      );
                    }
                  });
                }
              },
              
              btnColor: HexColor("20A9E5"),
              borderColor: Colors.white,
              txtColor: Colors.white,
              borderRadius: 10,
            ),  
           ),

            // New Button
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(
                            context,
                            '/login',
                          );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,  // Customize the color as needed
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
               child: const Text("Back"),
            ),

          ],
          ),
        ],
 
      ),
    );
  }
}