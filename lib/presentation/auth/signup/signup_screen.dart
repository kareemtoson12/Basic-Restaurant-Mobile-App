import 'package:flutter/material.dart';
import 'package:task/app/constants/app_colors.dart';
import 'package:task/app/constants/app_typography.dart';
import 'package:task/app/constants/styels.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kBackground,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 32.h),
                  // Logo
                  Hero(
                    tag: 'logo-hero',
                    child: Image.asset(
                      'assets/images/logo.png',
                      width: 120.w,
                      height: 120.w,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  // Foochi Text
                  Text(
                    'Restaurant ',
                    style: AppTypography.kBold36.copyWith(
                      color: Colors.black,
                      letterSpacing: 1.2,
                    ),
                  ),
                  SizedBox(height: 30.h),
                  // Name Field
                  TextField(decoration: AppInputStyles.loginField('Your Name')),
                  SizedBox(height: 12.h),
                  // Email Field
                  TextField(
                    decoration: AppInputStyles.loginField('Your Email'),
                  ),
                  SizedBox(height: 12.h),
                  // Password Field
                  TextField(
                    obscureText: true,
                    decoration: AppInputStyles.loginField('Your Password'),
                  ),
                  SizedBox(height: 12.h),
                  // Confirm Password Field
                  TextField(
                    obscureText: true,
                    decoration: AppInputStyles.loginField('Confirm Password'),
                  ),
                  SizedBox(height: 20.h),
                  // Sign Up Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: AppButtonStyles.loginButton,
                      onPressed: () {},
                      child: Text(
                        'Sign Up',
                        style: AppTypography.kBold18.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  // Already have an account? Sign In
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an account? ',
                        style: AppTypography.kLight14.copyWith(
                          color: Colors.black54,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Sign In',
                          style: AppTypography.kBold14.copyWith(
                            color: AppColors.kPrimary,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 24.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
