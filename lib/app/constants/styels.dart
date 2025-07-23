import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'app_colors.dart';

class AppInputStyles {
  static InputDecoration loginField(String hint) => InputDecoration(
    hintText: hint,
    filled: true,
    fillColor: Colors.white,
    contentPadding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.r),
      borderSide: BorderSide.none,
    ),
  );
}

class AppButtonStyles {
  static ButtonStyle loginButton = ElevatedButton.styleFrom(
    backgroundColor: const Color(0xFF7ED957),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
    padding: EdgeInsets.symmetric(vertical: 16.h),
  );
  static ButtonStyle googleButton = ElevatedButton.styleFrom(
    backgroundColor: AppColors.kOrange,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
    padding: EdgeInsets.symmetric(vertical: 12.h),
  );
}
