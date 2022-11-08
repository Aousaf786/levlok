import 'package:flutter/material.dart';
import '../../utils/app_color.dart';


Widget myIndicator() {
  return const SizedBox(
    width: double.infinity,
    height: 40,
    child: Center(
      child: CircularProgressIndicator( color: AppColors.kPrimary,),
    ),
  );
}
