import 'package:flutter/material.dart';
import '../pages/otp_login_page.dart';
import '../pages/otpsms_login_page.dart';

import 'pages/otp_verify_page.dart';
import 'pages/home_page.dart';
import 'pages/login_page.dart';
import 'pages/register_page.dart';
import 'services/shared_service.dart';

Widget _defaultHome = const LoginPage();
//Widget _defaultHome = const OTPVerifyPage();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Get result of the login function.
  bool _result = await SharedService.isLoggedIn();
  if (_result) {
    _defaultHome = const HomePage();
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      //home: const LoginPage(),
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => _defaultHome,
        '/home': (context) => const HomePage(),
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/loginOtp': (context) =>  LoginPageOtp(),
        '/loginOtpSms': (context) =>  LoginPageOtpSms(),
        '/VerifyOtp': (context) =>  const OTPVerifyPage(),
      },
    );
  }
}