import 'package:flutter/material.dart';
import 'package:mvvm_file_structure/core/models/signup_response_model.dart';
import 'package:mvvm_file_structure/core/routing/routes.dart';
import 'package:mvvm_file_structure/ui/views/login_screen.dart';
import 'package:mvvm_file_structure/ui/views/register_screen.dart';
import 'package:mvvm_file_structure/ui/views/update_screen.dart';
import 'package:mvvm_file_structure/ui/views/user_screen.dart';
import 'package:mvvm_file_structure/ui/views/welcome_screen.dart';

class PageRoutes {
  static Route<dynamic> generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case Routes.welcomeScreen:
        return MaterialPageRoute(builder: (context) => const WelcomeScreen());
      case Routes.registerScreen:
        return MaterialPageRoute(builder: (context) => const RegisterScreen());
      case Routes.userScreen:
        return MaterialPageRoute(builder: (context) => const UserScreen());
      case Routes.loginScreen:
        return MaterialPageRoute(builder: (context) => const LoginScreen());
      case Routes.updateScreen:
        Map<String, dynamic> args = settings.arguments as Map<String, dynamic>;
        SignUpResponseModel signUpResponseModel = args['user'];
        return MaterialPageRoute(
            builder: (context) => UpdateScreen(
                  arguments: signUpResponseModel,
                  id: args['id'],
                ));
      default:
        return MaterialPageRoute(
            builder: (context) => const Text("No Page exists..."));
    }
  }
}
