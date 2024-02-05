import 'package:flutter/material.dart';
import 'package:mvvm_file_structure/core/models/signup_request_model.dart';
import 'package:mvvm_file_structure/core/models/signup_response_model.dart';
import 'package:mvvm_file_structure/core/routing/routes.dart';
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
      case Routes.updateScreen:
        SignUpResponseModel id = settings.arguments as SignUpResponseModel;
        SignUpRequestModel signUpRequestModel =
            settings.arguments as SignUpRequestModel;

        return MaterialPageRoute(
            builder: (context) => UpdateScreen(
                  arguments: signUpRequestModel,
                  id: id.id??0,
                ));
      default:
        return MaterialPageRoute(
            builder: (context) => const Text("No Page exists..."));
    }
  }
}
