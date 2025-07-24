import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task/app/constants/app_colors.dart';
import 'package:task/app/constants/app_typography.dart';
import 'package:task/domain/models/onboarding_model.dart';

class OnBoardingCard extends StatelessWidget {
  final Onboarding onBoarding;
  final int index;
  const OnBoardingCard({
    required this.onBoarding,
    required this.index,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FadeInDown(
      duration: const Duration(milliseconds: 1400),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 30.w),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(onBoarding.image),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          children: [
            const Spacer(),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: onBoarding.title1,
                style: AppTypography.kLight36.copyWith(
                  color: AppColors.kSecondary,
                ),
                children: [
                  TextSpan(
                    text: onBoarding.title2,
                    style: AppTypography.kBold36,
                  ),
                ],
              ),
            ),
            SizedBox(height: AppSpacing.twentyVertical),
            Text(
              onBoarding.description,
              style: AppTypography.kLight16,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 40.h),
          ],
        ),
      ),
    );
  }
}

class AppSpacing {
  static double get fiveHorizontal => 5.w;
  static double get fiveVertical => 5.h;
  static double get radiusFive => 5.r;

  static double get tenHorizontal => 10.w;
  static double get tenVertical => 10.h;
  static double get radiusTen => 10.r;

  static double get twelveHorizontal => 12.w;
  static double get twelveVertical => 12.h;
  static double get radiusTwelve => 12.r;

  static double get fifteenHorizontal => 15.w;
  static double get fifteenVertical => 15.h;
  static double get radiusFifteen => 15.r;

  static double get twentyHorizontal => 20.w;
  static double get twentyVertical => 20.h;
  static double get radiusTwenty => 20.r;

  static double get twentyFiveHorizontal => 25.w;
  static double get twentyFiveVertical => 25.h;

  static double get thirtyHorizontal => 30.w;
  static double get thirtyVertical => 30.h;
  static double get radiusThirty => 30.r;

  static double get fortyHorizontal => 40.w;
  static double get fortyVertical => 40.h;
  static double get radiusForty => 40.r;

  static double get fiftyHorizontal => 50.w;
  static double get fiftyVertical => 50.h;
  static double get radiusFifty => 50.r;
}
