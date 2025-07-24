import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/app/constants/app_colors.dart';
import 'package:task/app/constants/app_typography.dart';
import 'package:task/app/constants/styels.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task/app/routing/routes.dart';
import 'package:task/presentation/auth/cubit/auth_cubit.dart';
import 'package:task/presentation/auth/cubit/auth_state.dart';
import 'package:task/app/di/injection.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>(); // New: Form key
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      final email = _emailController.text.trim();
      final password = _passwordController.text.trim();
      context.read<AuthCubit>().login(email, password);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => Injector.provideAuthCubit(),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Welcome back! You have logged in successfully!'),
                backgroundColor: Colors.green,
              ),
            );
            Future.delayed(const Duration(milliseconds: 500), () {
              Navigator.pushReplacementNamed(context, AppRoutes.home);
            });
          } else if (state is AuthFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  'Login failed, please check your email or password',
                ),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: AppColors.kBackground,
            body: SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    child: Form(
                      // NEW: Wrap with Form
                      key: _formKey,
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
                            'Restaurant ',
                            style: AppTypography.kBold36.copyWith(
                              color: Colors.black,
                              letterSpacing: 1.2,
                            ),
                          ),
                          SizedBox(height: 30.h),

                          /// Email Field
                          TextFormField(
                            controller: _emailController,
                            decoration: AppInputStyles.loginField('Your Email'),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Email is required';
                              }
                              final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
                              if (!emailRegex.hasMatch(value)) {
                                return 'Enter a valid email';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 12.h),

                          /// Password Field
                          TextFormField(
                            controller: _passwordController,
                            obscureText: true,
                            decoration: AppInputStyles.loginField(
                              'Your Password',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Password is required';
                              }
                              if (value.length < 6) {
                                return 'Password must be at least 6 characters';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 20.h),

                          /// Sign In Button
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              style: AppButtonStyles.loginButton,
                              onPressed: state is AuthLoading
                                  ? null
                                  : () => _login(context),
                              child: state is AuthLoading
                                  ? const SizedBox(
                                      width: 24,
                                      height: 24,
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                        strokeWidth: 2,
                                      ),
                                    )
                                  : Text(
                                      'Sign In',
                                      style: AppTypography.kBold18.copyWith(
                                        color: Colors.white,
                                      ),
                                    ),
                            ),
                          ),
                          SizedBox(height: 16.h),

                          /// Sign Up
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'New User? ',
                                style: AppTypography.kLight14.copyWith(
                                  color: Colors.black54,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    AppRoutes.signup,
                                  );
                                },
                                child: Text(
                                  'Sign Up',
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
            ),
          );
        },
      ),
    );
  }
}
