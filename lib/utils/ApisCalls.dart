import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import '../view/widget/mySnackBar.dart';

class ApisCalls {
  static Future apiCall(
      String endpoint, String method, Object? apiBody,
      {bool isSnackBarShow = false,String snackTitle="Alert",isNoInterMsg=false}) async {
    var url = Uri.parse(endpoint);
    //internet check
    var response;
    Connectivity _connectivity = Connectivity();
    ConnectivityResult result = ConnectivityResult.none;
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print(e.toString());
    }
    switch (result) {
      case ConnectivityResult.none:
        print("--------no internet---------");
        if(isSnackBarShow){
        MySnackBar.snackBarRed(
            title:snackTitle, message:"Not internet connection found");}
        return {
          'isData': false,
          'message':"Not internet connection found"
        };
      case ConnectivityResult.wifi:
      case ConnectivityResult.mobile:
      //api call
        if (method == "post") {
          response = await http
              .post(
            url,
            body: apiBody,
          )
              .timeout(Duration(seconds: 30), onTimeout: () {
            return http.Response('Error', 500);
          });
        } else if (method == "get") {
          response = await http.get(
            url,
          );
        }
        // print("======response:${response.body}=======");
        if (response.statusCode == 500) {
          // print("======================");
          // print("====before==========${(json.decode(response.body)['message'])}");
          MySnackBar.snackBarRed(
              title:snackTitle, message:"Internal Server error or No Internet");
          return {
            'isData': false,
            'message':"Internal Server error or No Internet"
          };
        } else if (response.statusCode == 200) {


          if (json.decode(response.body)['status_code'] ==808) {


            MySnackBar.snackBarSessionOut(title: "Session Out",message: "You have session out please login again");
            return {
              'isData': false,
              'message': json.decode(response.body)['message']
            };
          }
          else if (json.decode(response.body)['status']) {
            if (isSnackBarShow){
              MySnackBar.snackBarPrimary(
                  title: snackTitle, message:json.decode(response.body)['message'] ?? "Successfully done");}

            return {
              'isData': true,
              'response': response.body,
              'message': json.decode(response.body)['message']
            };
          } else {
            if (isSnackBarShow){
              MySnackBar.snackBarRed(
                  title:snackTitle, message:json.decode(response.body)['message'] ?? "Error! ");}

            return {
              'isData': false,
              'response': response.body,
              'message': json.decode(response.body)['message']
            };
          }
        } else {
          MySnackBar.snackBarPrimary(title:snackTitle, message:"Some thing went wrong");
          return {'isData': false, 'message': "Some thing went wrong"};
        }

      case ConnectivityResult.none:
        if (isSnackBarShow){
          MySnackBar.snackBarRed(title:snackTitle, message:"No Internet");}
        return {'isData': false, 'message': "No Internet"};

      default:
        if (isSnackBarShow){
          MySnackBar.snackBarRed(title:snackTitle, message:"Some thing went wrong");}
        return {'isData': false, 'message': "Some thing went wrong"};
    }
  }
}