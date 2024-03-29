import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mvvm_file_structure/core/routing/routes.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});
  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvoked: (didPop) {
        log("$didPop");
        SystemNavigator.pop();
      },
      child: Scaffold(
        body: buildBody(),
      ),
    );
  }

  Widget buildBody() {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(
          "assets/images/img.png",
          fit: BoxFit.cover,
        ),
        Positioned(
          bottom: 150,
          left: 15,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "WELCOME",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
              ),
              const SizedBox(
                height: 50,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 150, vertical: 15),
                  backgroundColor: const Color(0xff1E232C),
                  shape: RoundedRectangleBorder(
                      side: const BorderSide(width: 2),
                      borderRadius: BorderRadius.circular(8)),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, Routes.loginScreen);
                },
                child: const Text(
                  "Login Now",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 160, vertical: 15),
                  shape: RoundedRectangleBorder(
                      side: const BorderSide(width: 2),
                      borderRadius: BorderRadius.circular(8)),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, Routes.registerScreen);
                },
                child: const Text(
                  "Register",
                  style: TextStyle(color: Colors.black, fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
