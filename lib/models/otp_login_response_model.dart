import 'package:flutter/material.dart'; 
import 'dart:convert';

OtpLoginResponseModel otpLoginResponseModel(String str) =>
    OtpLoginResponseModel.fromJson(json.decode(str));

class OtpLoginResponseModel {
  OtpLoginResponseModel({
required this.message,
required this.data,
  });

  late final String message;
  late final String? data;

OtpLoginResponseModel.fromJson(Map<String, dynamic> json){
  message = json['message'];
  data = json['data'];
}


}