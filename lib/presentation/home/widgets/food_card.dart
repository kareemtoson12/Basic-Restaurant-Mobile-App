import 'package:flutter/material.dart';
import 'package:task/app/constants/app_typography.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task/presentation/home/widgets/food_item.dart';

class FoodCard extends StatelessWidget {
  final FoodItem item;
  final VoidCallback onAdd;
  const FoodCard({required this.item, required this.onAdd, Key? key})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: const Color(0xFFF8DCC6),
        borderRadius: BorderRadius.circular(24.r),
      ),
      child: Row(
        children: [
          // Circular image
          Container(
            width: 56.w,
            height: 56.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            child: Padding(
              padding: EdgeInsets.all(8.w),
              child: Image.asset(item.image, fit: BoxFit.contain),
            ),
          ),
          SizedBox(width: 16.w),
          // Name, price, rating
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: AppTypography.kMedium16.copyWith(color: Colors.black),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 6.h),
                Row(
                  children: [
                    Icon(Icons.attach_money, color: Colors.green, size: 16.sp),
                    Text(
                      item.price.toStringAsFixed(1),
                      style: AppTypography.kLight14.copyWith(
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Icon(Icons.star, color: Colors.orange, size: 16.sp),
                    SizedBox(width: 2.w),
                    Text(
                      item.rating.toStringAsFixed(1),
                      style: AppTypography.kLight14.copyWith(
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(width: 12.w),
          // Plus button
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: IconButton(
              icon: Icon(Icons.add, color: Colors.black, size: 22.sp),
              onPressed: onAdd,
            ),
          ),
        ],
      ),
    );
  }
}
