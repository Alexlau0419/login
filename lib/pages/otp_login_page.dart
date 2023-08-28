import 'package:flutter/material.dart';
import '../pages/otp_verify_page.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';
import 'package:snippet_coder_utils/hex_color.dart';

import '../services/api_service.dart';

class LoginPageOtp extends StatefulWidget {
  @override
  _LoginPageOtpState createState() => _LoginPageOtpState();
}

class _LoginPageOtpState extends State<LoginPageOtp> {
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
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.network(
            "https://i.imgur.com/bOCEVJg.png",
            height: 180,
            fit: BoxFit.contain,
          ),
          const Padding(
            padding: EdgeInsets.only(top: 20),
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
                    margin: const EdgeInsets.fromLTRB(0, 10, 3, 32),
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
                    initialValue: "",
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
          Center(
            child: FormHelper.submitButton(
              "Continue",
              () async {
                if (enableBtn && mobileNumber.length > 8) {
                  print('mobileNumber.length > 8');
                  setState(() {
                    isAPIcallProcess = true;
                    print('isAPIcallProcess = true');
                  });
              print('isAPIcallProcess = true::' + mobileNumber);
                  APIService.otpLogin(mobileNumber).then((response) async {
                    print('otpLogin');
                    setState(() {
                      isAPIcallProcess = false;
                      print('isAPIcallProcess = false');
                    });

                    print(response.message);
                    print(response.data);
                    if (response.data != null) {
                      print('response.data != null');
                      String otpHash = response.data.toString();
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
              btnColor: HexColor("#20A9E5"),
              borderColor: HexColor("#20A9E5"),
              txtColor: HexColor(
                "#000000",
              ),
              borderRadius: 20,
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
    );
  }
}