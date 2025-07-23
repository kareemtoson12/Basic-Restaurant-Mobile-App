import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task/app/constants/app_colors.dart';
import 'package:task/app/routing/routes.dart';
import 'package:task/data/models/onboarding_model.dart';
import 'package:task/presentation/onboarding/widgets/custom_button.dart';
import 'package:task/presentation/onboarding/widgets/custom_indicator.dart';
import 'package:task/presentation/onboarding/widgets/onboarding_card.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  PageController pageController = PageController();
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: AppColors.kBackground,
          child: Column(
            children: [
              SizedBox(height: 50.h),
              Expanded(
                flex: 3,
                child: PageView.builder(
                  itemCount: onboardingList.length,
                  controller: pageController,
                  onPageChanged: (value) {
                    setState(() {
                      currentIndex = value;
                    });
                  },
                  itemBuilder: (context, index) {
                    return OnBoardingCard(
                      index: index,
                      onBoarding: onboardingList[index],
                    );
                  },
                ),
              ),
              CustomIndicator(position: currentIndex),
              SizedBox(height: 83.h),
              CustomOutlinedButton(
                width: 130.w,
                onTap: () {
                  if (currentIndex == (onboardingList.length - 1)) {
                    Navigator.pushNamed(context, AppRoutes.login);
                  } else if (currentIndex == 0) {
                    pageController.jumpToPage(1);
                  } else {
                    pageController.nextPage(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.ease,
                    );
                  }
                },
                text: currentIndex == (onboardingList.length - 1)
                    ? 'Get Started'
                    : 'Next',
              ),
              SizedBox(height: AppSpacing.twentyVertical),
            ],
          ),
        ),
      ),
    );
  }
}
