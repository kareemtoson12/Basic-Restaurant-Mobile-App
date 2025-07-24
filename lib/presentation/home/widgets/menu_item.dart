import 'package:flutter/material.dart';
import 'package:task/app/constants/app_typography.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MenuItem extends StatelessWidget {
  final String image;
  final String title;
  final bool isSelected;
  final VoidCallback? onTap;
  const MenuItem({
    required this.image,
    required this.title,
    this.isSelected = false,
    this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 70.w,
            height: 56.w,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.all(8.w),
              child: Image.asset(image, fit: BoxFit.contain),
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            title,
            style: isSelected
                ? AppTypography.kBold16.copyWith(color: Colors.black)
                : AppTypography.kLight14.copyWith(color: Colors.black87),
          ),
        ],
      ),
    );
  }
}
