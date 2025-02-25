import 'package:cancer_shield/helpers/shared_preferences_utils.dart';
import 'package:cancer_shield/models/user_model.dart';
import 'package:cancer_shield/screens/auth/change_password/change_password_screen.dart';
import 'package:cancer_shield/screens/auth/login_screen/login_screen.dart';
import 'package:cancer_shield/screens/auth/sign_up_screen/sign_up_screen.dart';
import 'package:cancer_shield/screens/doctor_screens/doctor_screen.dart';
import 'package:cancer_shield/screens/home_screens/home_screen.dart';
import 'package:cancer_shield/screens/onboarding_screens/onboarding_screen.dart';
import 'package:cancer_shield/screens/profile_screen/profile_screen.dart';
import 'package:flutter/material.dart';

Future<void> main() async {WidgetsFlutterBinding.ensureInitialized();

  await SharedPreferencesUtils.init();
  runApp(const CancerShield());
}

class CancerShield extends StatelessWidget {
  const CancerShield({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: OnboardingScreen(),
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/login_screen':
            return MaterialPageRoute(builder: (context) => LoginScreen());
          case '/sign_up_screen':
            return MaterialPageRoute(builder: (context) => SignUpScreen());
          case '/home_screen':
            final user = settings.arguments as UserModel;
            return MaterialPageRoute(
                builder: (context) => HomeScreen(user: user));
          case '/doctor_screen':
            return MaterialPageRoute(builder: (context) => DoctorScreen());
          case '/profile_screen':
            final user = settings.arguments as UserModel;
            return MaterialPageRoute(
                builder: (context) => ProfileScreen(user: user));
          case '/change_password_screen':
            final user = settings.arguments as UserModel;
            return MaterialPageRoute(
                builder: (context) => ChangePasswordScreen(
                      user: user,
                    ));
          default:
            return MaterialPageRoute(builder: (context) => OnboardingScreen());
        }
      },
    );
  }
}
