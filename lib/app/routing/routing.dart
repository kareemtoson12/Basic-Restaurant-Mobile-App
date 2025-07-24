import 'package:flutter/material.dart';
import 'package:task/presentation/home/home_view.dart';
import 'package:task/presentation/onboarding/onboarding_view.dart';
import 'routes.dart';
import '../../presentation/auth/login/login_screen.dart';
import '../../presentation/auth/signup/signup_screen.dart';

Route<dynamic>? onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case AppRoutes.onboarding:
      return MaterialPageRoute(builder: (_) => OnboardingView());
    case AppRoutes.login:
      return MaterialPageRoute(builder: (_) => const LoginScreen());
    case AppRoutes.signup:
      return MaterialPageRoute(builder: (_) => SignUpScreen());
    case AppRoutes.home:
      return MaterialPageRoute(builder: (_) => HomeScreen());
    default:
      return MaterialPageRoute(
        builder: (_) => Scaffold(
          body: Center(
            child: Text('No route defined for \'${settings.name}\''),
          ),
        ),
      );
  }
}
