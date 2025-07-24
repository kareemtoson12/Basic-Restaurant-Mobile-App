// screens/signup_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task/app/constants/app_colors.dart';
import 'package:task/app/constants/app_typography.dart';
import 'package:task/app/constants/styels.dart';
import 'package:task/app/di/injection.dart';
import 'package:task/app/routing/routes.dart';
import 'package:task/presentation/auth/cubit/auth_cubit.dart';
import 'package:task/presentation/auth/cubit/auth_state.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({Key? key}) : super(key: key);

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => Injector.provideAuthCubit(),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthFailure) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.errorMessage)));
          } else if (state is AuthSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Welcome ${state.user.userName}")),
            );
            Navigator.pushNamed(context, AppRoutes.home);
          }
        },
        builder: (context, state) {
          final isLoading = state is AuthLoading;

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
                        Hero(
                          tag: 'logo-hero',
                          child: Image.asset(
                            'assets/images/logo.png',
                            width: 120.w,
                            height: 120.w,
                          ),
                        ),
                        SizedBox(height: 16.h),
                        Text(
                          'Restaurant',
                          style: AppTypography.kBold36.copyWith(
                            color: Colors.black,
                            letterSpacing: 1.2,
                          ),
                        ),
                        SizedBox(height: 30.h),

                        // Fields
                        TextField(
                          controller: _nameController,
                          decoration: AppInputStyles.loginField('Your Name'),
                        ),
                        SizedBox(height: 12.h),

                        TextField(
                          controller: _emailController,
                          decoration: AppInputStyles.loginField('Your Email'),
                        ),
                        SizedBox(height: 12.h),

                        TextField(
                          controller: _passwordController,
                          obscureText: true,
                          decoration: AppInputStyles.loginField(
                            'Your Password',
                          ),
                        ),
                        SizedBox(height: 12.h),

                        TextField(
                          controller: _confirmPasswordController,
                          obscureText: true,
                          decoration: AppInputStyles.loginField(
                            'Confirm Password',
                          ),
                        ),
                        SizedBox(height: 20.h),

                        // Sign Up Button
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: AppButtonStyles.loginButton,
                            onPressed: isLoading
                                ? null
                                : () {
                                    final name = _nameController.text.trim();
                                    final email = _emailController.text.trim();
                                    final pass = _passwordController.text
                                        .trim();
                                    final confirm = _confirmPasswordController
                                        .text
                                        .trim();

                                    if (pass != confirm) {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                            "Passwords don't match",
                                          ),
                                        ),
                                      );
                                      return;
                                    }

                                    context.read<AuthCubit>().signUp(
                                      email,
                                      pass,
                                      name,
                                    );
                                  },
                            child: isLoading
                                ? const CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                : Text(
                                    'Sign Up',
                                    style: AppTypography.kBold18.copyWith(
                                      color: Colors.white,
                                    ),
                                  ),
                          ),
                        ),
                        SizedBox(height: 16.h),

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
        },
      ),
    );
  }
}
