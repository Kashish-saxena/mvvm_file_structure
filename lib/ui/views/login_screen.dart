import 'package:flutter/material.dart';
import 'package:mvvm_file_structure/core/constants/string_constants.dart';
import 'package:mvvm_file_structure/core/routing/routes.dart';
import 'package:mvvm_file_structure/core/utils/validation_utils.dart';
import 'package:mvvm_file_structure/ui/widgets/back_button.dart';
import 'package:mvvm_file_structure/ui/widgets/link_buttons.dart';
import 'package:mvvm_file_structure/ui/widgets/text_form_field.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _loginKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  late SharedPreferences prefs;

  Future<String> getEmailValues() async {
    prefs = await SharedPreferences.getInstance();
    String email = prefs.getString('email') ?? "";
    return email;
  }

  String? email;

  init() async {
    email = await getEmailValues();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        leading: BackButtonWidget(
          onTap: () {
            Navigator.pushNamedAndRemoveUntil(
                context, Routes.welcomeScreen, (route) => false);
          },
        ),
      ),
      body: buildBody(),
    );
  }

  Widget buildBody() {
    return Center(
      child: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Form(
            key: _loginKey,
            child: Column(
              children: [
                const Text(
                  StringConstants.loginHello,
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormFieldWidget(
                  validator: (val) {
                    return Verification.isEmailValid(val);
                  },
                  obscureText: false,
                  controller: emailController,
                  text: StringConstants.email,
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(370, 60),
                    backgroundColor: const Color(0xff1E232C),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                  onPressed: () {
                    if (emailController.text == email) {
                      emailController.clear();

                      _loginKey.currentState?.reset();
                      Navigator.pushNamed(context, Routes.userScreen);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Incorrect Email"),
                      ));
                    }
                  },
                  child: const Text(StringConstants.login,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600)),
                ),
                const SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 1,
                      width: MediaQuery.of(context).size.width * .25,
                      color: const Color(0xffA2A2A2),
                    ),
                    const Text(
                      StringConstants.orLogin,
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    Container(
                      height: 1,
                      width: MediaQuery.of(context).size.width * .25,
                      color: const Color(0xffA2A2A2),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                const LinkButtonWidget(),
                const SizedBox(
                  height: 100,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      StringConstants.noAccount,
                      style: TextStyle(fontSize: 18, color: Color(0xff032426)),
                    ),
                    InkWell(
                      child: const Text(
                        StringConstants.register,
                        style: TextStyle(
                            color: Colors.blueAccent,
                            fontWeight: FontWeight.w700,
                            fontSize: 18),
                      ),
                      onTap: () {
                        Navigator.pushNamed(context, Routes.registerScreen);
                      },
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
