import 'dart:io';
import 'dart:convert';
import 'package:dio/dio.dart' as dio;
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import '../../../utils/ApisCalls.dart';
import '../../../utils/api_url.dart';
import '../../../utils/app_color.dart';
import '../../../utils/app_constands.dart';
import '../../../view/widget/mySnackBar.dart';


class MyRepo {
  static var client = http.Client();


  //ClassList Val
  static RxString selectClassName = "Class *".obs;
  static RxString selectClassCode = "-1".obs;
  static RxBool isClassSearch = false.obs;
  static List randomColorList = [AppColors.lightGreen, AppColors.kLightBlue, AppColors.kHolidayDark,AppColors.kGreen,AppColors.kOrange];


  //Home Work
  static RxBool isLoadingHomeWork = true.obs;
  //Month
 static List<String> listOfMonthWithNO = <String>[
    '01 | January',
    '02 | February',
    '03 | March',
    '04 | April',
    "05 | May",
    "06 | June",
    "07 | July",
    "08 | August",
    "09 | September",
    "10 | October",
    "11 | November",
    "12 | December"
  ];
  static List<String> listOfMonth = <String>[
    'January',
    'February',
    'March',
    'April',
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December"
  ];

  //Leave Management
  static RxBool isLeaveType = false.obs;
  static RxString leaveName = "Select Leave type".obs;
  static RxString leaveID = "-1".obs;
  static RxBool isShortLeave=true.obs;




  static RxList<String> reportList = [
    "Good Work",
    "Not Good",
    "Excellent",
    "Satisfied",
    "Average",
    "poor"
  ].obs;

  static late TabController tabController;

  static Future<void> getNotiCon() async {


    String apiToken = GetStorage().read(kApiTokenID).toString();
    ApisCalls.apiCall(
        "https://lyceumgroupofschools.com/api/v2/teacher/notification-counter?api_token=$apiToken",
        "get",
        {
        },
        isSnackBarShow: false)
        .then((value) {
      print("=======getNotiCon:$value=======");
      // print("===distance:$distance==api_token:${GetStorage().read(kApiTokenID)}===barcodeScanRes:$barcodeScanRes===device_token:${ GetStorage().read(kDeviceTokenID)}=====lat:${_position.latitude.toString()}===lng:${_position.longitude.toString()}=======================");
      if (value['isData']) {


      }
    });
  }

  static Future<bool> getDeleteTransition({ required String transitionId}) async {

   RxBool loading = false.obs;
    String apiToken = GetStorage().read(kApiTokenID);
     print("======transitionId:$transitionId=======");
    try{
      await ApisCalls.apiCall(
        ApiUrl.baseUrlV2+"account/reject-transaction",
        "post",
        {
          "api_token": apiToken,
          "transaction_id": transitionId,
        },isSnackBarShow: true,
      )
          .then((value) {
        if (value['isData']) {
          loading.value =true;
          // print("======value: $value===");
        } else {
          loading.value =false;
        }
      });
    }
    catch(e){
      MySnackBar.snackBarRed(title: "Alert", message: " Error $e");
      loading.value =false;
    }
    return loading.value;
  }
  static Future<void> hitCashReceipt({required String accountId,required String amount ,required String description}) async {

    String apiToken = GetStorage().read(kApiTokenID);

    ApisCalls.apiCall(
        ApiUrl.baseUrlV2+"account/cash-reciept",
        "post",
        {
          "api_token": apiToken,
          "account_id": accountId,
          "amount": amount,
          "description": description,
        },
        isSnackBarShow: false)
        .then((value) {
      if (value['isData']) {

      } else {

      }

    });

  }
  static Future<bool> logoutApi() async {
    RxBool result=false.obs;

    String apiToken = GetStorage().read(kApiTokenID);

   await ApisCalls.apiCall(
        "https://lyceumgroupofschools.com/api/v2/teacher/logout?api_token=$apiToken",
        // ApiUrl.baseUrlV2+"teacher/logout"+"?api_token=$apiToken",
        "get",
        {},
        isSnackBarShow: false)
        .then((value) {
      if (value['isData']) {

        result.value =true;
      }

    });
   return result.value;

  }

  // static Future<String> showIOS_timePicker(BuildContext context,)async {
  //   // maximumDate=DateTime.now();
  //   // String date=DateFormat('dd-MM-yyyy').format(DateTime.parse(DateTime.now().toString()));
  //   // DateTime date = DateTime(2016, 5, 10, 22, 35);
  //   String date="";
  //   await  showGeneralDialog(
  //     context: context,
  //     barrierLabel: "Barrier",
  //     barrierDismissible: true,
  //     barrierColor: Colors.black.withOpacity(0.5),
  //     transitionDuration: Duration(milliseconds: 700),
  //     pageBuilder: (_, __, ___) {
  //       return StatefulBuilder(builder: (context, setState){
  //         return Center(
  //           child:Column(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             children: [
  //               Container(
  //                 decoration: BoxDecoration(
  //                     color:AppColors.kWhite,
  //                     borderRadius: BorderRadius.circular(AppSizes.appVerticalMd * 1)
  //                 ),
  //
  //                 height: AppSizes.appVerticalMd * 5,
  //                 child: CupertinoDatePicker(
  //                     use24hFormat: true,
  //                     mode: CupertinoDatePickerMode.time,
  //                     onDateTimeChanged: (val) {
  //                       setState(() {
  //                           date= "${val.hour}:${val.minute}";
  //                       });
  //                     }),
  //               ),
  //               SizedBox(height: AppSizes.appVerticalMd *0.3,),
  //               MaterialButton(
  //                 shape: RoundedRectangleBorder(
  //                   borderRadius: BorderRadius.circular(AppSizes.appVerticalMd * 0.4),
  //                 ),
  //                 onPressed: () {
  //                   Navigator.pop(context);
  //                   // updateDateOfBirth(date:"${CustomRepository.selectDate.value}" );
  //
  //                 },
  //                 color: AppColors.kAppTheme,
  //                 child: const Text(
  //                   "Done",
  //                   style: TextStyle(color: AppColors.kWhite),
  //                 ),
  //               ),
  //               SizedBox(height: AppSizes.appVerticalMd * 1,),
  //             ],
  //           ),
  //         );
  //       });
  //     },
  //     transitionBuilder: (_, anim, __, child) {
  //       Tween<Offset> tween;
  //       if (anim.status == AnimationStatus.reverse) {
  //         tween = Tween(begin: Offset(-1, 0), end: Offset.zero);
  //       } else {
  //         tween = Tween(begin: Offset(1, 0), end: Offset.zero);
  //       }
  //
  //       return SlideTransition(
  //         position: tween.animate(anim),
  //         child: FadeTransition(
  //           opacity: anim,
  //           child: child,
  //         ),
  //       );
  //     },
  //   );
  //   return date;
  // }
  static Future<String> show_timePicker(BuildContext context,)async {
    String date="";
    final TimeOfDay? result =
    await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (result != null) {
      // date = result.format(context);
      final now = new DateTime.now();
      var time=DateTime( now.year, now.month, now.day,result.hour, result.minute);
     // date= DateFormat.Hm().format(time);
    }
    return date;

  }
  static Future<String> show_DatePicker({required BuildContext context,  DateTime? initialDate,DateTime? firstDate,DateTime? lastDate})async {
    String date=DateFormat('dd-MM-yyyy').format(DateTime.parse(DateTime.now().toString()));
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: initialDate??DateTime.now(),
        firstDate: firstDate??DateTime.now(),
        lastDate: lastDate??DateTime(DateTime.now().year+2));
    // ignore: unrelated_type_equality_checks
    if (picked != null && picked != date) {
      date = DateFormat('dd-MM-yyyy').format(DateTime.parse(picked.toString()));
    }
    return date;

  }
  // static Future<String> showIOS_DatePicker(BuildContext context,)async {
  //   // maximumDate=DateTime.now();
  //   String date=DateFormat('dd-MM-yyyy').format(DateTime.parse(DateTime.now().toString()));
  //   // final DateTime? picked = await showDatePicker(
  //   //     context: context,
  //   //     initialDate: DateTime.now(),
  //   //     firstDate: DateTime(2015, 8),
  //   //     lastDate: DateTime(2101));
  //   // if (picked != null && picked != date) {
  //   //   date = DateFormat('dd-MM-yyyy').format(DateTime.parse(picked.toString()));
  //   // }
  //   await  showGeneralDialog(
  //       context: context,
  //       barrierLabel: "Barrier",
  //       barrierDismissible: true,
  //       barrierColor: Colors.black.withOpacity(0.5),
  //       transitionDuration: Duration(milliseconds: 700),
  //       pageBuilder: (_, __, ___) {
  //         return StatefulBuilder(builder: (context, setState){
  //           return Center(
  //             child:Column(
  //               mainAxisAlignment: MainAxisAlignment.center,
  //               children: [
  //                 Container(
  //                   decoration: BoxDecoration(
  //                       color:AppColors.kWhite,
  //                       borderRadius: BorderRadius.circular(AppSizes.appVerticalMd * 1)
  //                   ),
  //
  //                   height: AppSizes.appVerticalMd * 5,
  //                   child: CupertinoDatePicker(
  //                       // initialDateTime: DateTime.now(),
  //                       //  initialDateTime:widget.dateOfBirth.isEmpty?  DateTime.now():DateTime.parse(DateFormat('yyyy-mm-dd').format(DateTime.parse(widget.dateOfBirth))),
  //                       maximumDate:DateTime(DateTime.now().year+1,DateTime.now().month,DateTime.now().day),
  //                       minimumDate: DateTime.now() ,
  //                       // DateTime.now(),//DateTime(DateTime.now().day,DateTime.now().month,DateTime.now().year-10,),
  //                       mode: CupertinoDatePickerMode.date,
  //                       onDateTimeChanged: (val) {
  //                         setState(() {
  //                           date= DateFormat('dd-MM-yyyy').format(DateTime.parse(val.toString()));
  //
  //
  //                         });
  //                       }),
  //                 ),
  //                 SizedBox(height: AppSizes.appVerticalMd *0.3,),
  //                 MaterialButton(
  //                   shape: RoundedRectangleBorder(
  //                     borderRadius: BorderRadius.circular(AppSizes.appVerticalMd * 0.4),
  //                   ),
  //
  //                   onPressed: () {
  //
  //                     Navigator.pop(context);
  //
  //
  //                     // updateDateOfBirth(date:"${CustomRepository.selectDate.value}" );
  //
  //                   },
  //                   color: AppColors.kAppTheme,
  //                   child: const Text(
  //                     "Done",
  //                     style: TextStyle(color: AppColors.kWhite),
  //                   ),
  //                 ),
  //                 SizedBox(height: AppSizes.appVerticalMd * 1,),
  //               ],
  //             ),
  //
  //
  //           );
  //         });
  //       },
  //       transitionBuilder: (_, anim, __, child) {
  //         Tween<Offset> tween;
  //         if (anim.status == AnimationStatus.reverse) {
  //           tween = Tween(begin: Offset(-1, 0), end: Offset.zero);
  //         } else {
  //           tween = Tween(begin: Offset(1, 0), end: Offset.zero);
  //         }
  //
  //         return SlideTransition(
  //           position: tween.animate(anim),
  //           child: FadeTransition(
  //             opacity: anim,
  //             child: child,
  //           ),
  //         );
  //       },
  //     );
  //   return date;
  //
  // }


  static Future<bool> updateCnic({ required String cnic}) async {


    RxBool loading = false.obs;
    String apiToken = GetStorage().read(kApiTokenID);
    // print("====accountTO: $accountTO ,accountFrom: $accountFrom ,date: $date ,narration: narration =========");
    try{
      await ApisCalls.apiCall(
        ApiUrl.baseUrlV2+"cnic-update",
        "post",
        {
          "api_token": apiToken,
          "cnic": cnic,
        },isSnackBarShow: true,
      )
          .then((value) {
        print("value333 $value");
        if (value['isData']) {

          loading.value =true;
          ;
          // print("======value: $value===");
        } else {
          loading.value =false;
        }
      });
    }
    catch(e){
      MySnackBar.snackBarRed(title: "Alert", message: " Error $e");
      loading.value =false;
    }
    return loading.value;
  }

  // static showImagePicker({required BuildContext context}) {
  //   showModalBottomSheet(
  //       context: context,
  //       builder: (BuildContext bc) {
  //         return SafeArea(
  //           child: Wrap(
  //             children: <Widget>[
  //               ListTile(
  //                   leading: const Icon(Icons.photo_library),
  //                   title: const Text('Photo Library'),
  //                   onTap: () {
  //                     // getGalleryImage();
  //                     Navigator.of(context).pop();
  //                   }),
  //               ListTile(
  //                 leading: const Icon(Icons.photo_camera),
  //                 title: const Text('Camera'),
  //                 onTap: () {
  //                   // getCameraImage();
  //                   Navigator.of(context).pop();
  //                 },
  //               ),
  //             ],
  //           ),
  //         );
  //       });
  // }
 static Future<File?> showImagePicker({required BuildContext context,required File? file}) async {
    await showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Wrap(
              children: <Widget>[
                ListTile(
                    leading: const Icon(Icons.photo_library),
                    title: const Text('Photo Library'),
                    onTap: () async {
                      // final XFile? pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery,imageQuality: 73);
                      final XFile? pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery,);
                      File? comressImage =await compressFile(File(pickedFile!.path));
                        if (comressImage != null) {
                            file = File(comressImage.path);
                            double sizeInMb = await file!.length() / (1024 * 1024);
                            print("=====sizeInMb:${sizeInMb.toStringAsFixed(2)}=======");
                        } else {
                          print('No image selected.');
                        }
                      Navigator.of(context).pop();
                    }),
                ListTile(
                  leading: const Icon(Icons.photo_camera),
                  title: const Text('Camera'),
                  onTap: () async {
                    final XFile? pickedFile = await ImagePicker().pickImage(source: ImageSource.camera,imageQuality: 10);
                    File? comressImage =await compressFile(File(pickedFile!.path));
                      if (comressImage != null) {
                          file = File(comressImage.path);
                      } else {
                        print('No image selected.');
                      }
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        });
    return file;
  }

  static Future<File?> compressFile(File file) async {
    double compressSize = 0.5;
    double sizeInMb = file.lengthSync() / (1024 * 1024);
    if( sizeInMb > compressSize){
      final filePath = file.absolute.path;
      final lastIndex = filePath.lastIndexOf(RegExp(r'.jp'));
      final splitted = filePath.substring(0, (lastIndex));
      final outPath = "${splitted}_out${filePath.substring(lastIndex)}";
      double compressImagePercentage =await (sizeInMb ) * (28.33);
      File? result = await FlutterImageCompress.compressAndGetFile(
        file.absolute.path, outPath,
        quality: compressImagePercentage.toInt(),
        // quality: 85,

      );
      // print("========sizeInMb:${sizeInMb.toStringAsFixed(2)}==compressImagePercentage: ${compressImagePercentage.toStringAsFixed(2)}====result: ${(result!.lengthSync() / (1024 * 1024)).toStringAsFixed(2)}==");

      return result;
    }
    else{
      return file;
    }}
  //
  //
  //
  //
  // }



  // static Future<File> getGalleryImage(File image) async {
  //   final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);
  //   if (pickedFile != null) {
  //     image = File(pickedFile.path);
  //   } else {
  //     print('No ');
  //   }
  //   return image;
  // }



}
String spaceRemove({required String text}){
  return text.replaceAll( RegExp(r"\s+\b|\b\s"), " ");

}
String flagEmoji({required String iosName}){
  return iosName.toUpperCase().replaceAllMapped(RegExp(r'[A-Z]'), (match) => String.fromCharCode(match.group(0)!.codeUnitAt(0) + 127397));

}
// String roundOf({required String text,required int roundOfNumber}){
//   return text.replaceAll( RegExp(r"\s+\b|\b\s"), " ");
//   return (double.parse(MyRepo.feeDepositData.value.data!.feeThisMonth.toString();
//
// }
 bool emailValidate(String email) {
if (!emailExp.hasMatch(email)) {
return false;
}
return true;
}





