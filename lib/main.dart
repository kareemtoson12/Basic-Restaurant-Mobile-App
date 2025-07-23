import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'app/app.dart';

void main() {
  runApp(
    ScreenUtilInit(
      designSize: Size(375, 812), // iPhone X size, adjust as needed
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => const Restaurant(),
    ),
  );
}
