import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:mvvm_file_structure/core/constants/string_constants.dart';
import 'package:mvvm_file_structure/core/models/signup_request_model.dart';
import 'package:mvvm_file_structure/core/routing/routes.dart';
import 'package:mvvm_file_structure/core/utils/validation_utils.dart';
import 'package:mvvm_file_structure/core/view_model/register_view_model.dart';
import 'package:mvvm_file_structure/ui/widgets/back_button.dart';
import 'package:mvvm_file_structure/ui/widgets/link_buttons.dart';
import 'package:mvvm_file_structure/ui/widgets/radio_field.dart';
import 'package:mvvm_file_structure/ui/widgets/text_form_field.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<RegisterScreen> {
  final GlobalKey<FormState> _registerKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  String gender = "male";

  RegisterViewModel registerViewModel = RegisterViewModel();
  late SharedPreferences prefs;

  setEmailValues(SignUpRequestModel signUpRequestModel) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setString('name', signUpRequestModel.name ?? "");
    prefs.setString('email', signUpRequestModel.email ?? "");
    prefs.setString('gender', signUpRequestModel.gender ?? "");
    prefs.setString('status', "Active");
    log(signUpRequestModel.name ?? "");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        leading: BackButtonWidget(
          onTap: () {
            Navigator.popUntil(
                context, (Route<dynamic> route) => route.isFirst);
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
            key: _registerKey,
            child: Column(
              children: [
                const Text(
                  StringConstants.hello,
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormFieldWidget(
                  validator: (val) {
                    return Verification.isNameValid(val);
                  },
                  obscureText: false,
                  controller: nameController,
                  text: StringConstants.name,
                ),
                TextFormFieldWidget(
                  validator: (val) {
                    return Verification.isEmailValid(val);
                  },
                  obscureText: false,
                  controller: emailController,
                  text: StringConstants.email,
                ),
                RadioFieldWidget(
                  widget: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text(StringConstants.gender,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Color(0xff8391A1))),
                      Flexible(
                        child: ListTile(
                          contentPadding: EdgeInsets.zero,
                          textColor: const Color(0xff8391A1),
                          leading: Radio(
                              value: "male",
                              groupValue: gender,
                              onChanged: (value) {
                                setState(() {
                                  gender = value ?? "";
                                });
                              }),
                          title: const Text(StringConstants.male),
                        ),
                      ),
                      Flexible(
                        child: ListTile(
                          textColor: const Color(0xff8391A1),
                          contentPadding: EdgeInsets.zero,
                          leading: Radio(
                              value: "female",
                              groupValue: gender,
                              onChanged: (value) {
                                setState(() {
                                  gender = value ?? "";
                                });
                              }),
                          title: const Text(StringConstants.female),
                        ),
                      )
                    ],
                  ),
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
                  onPressed: () async {
                    if (_registerKey.currentState!.validate()) {
                      SignUpRequestModel signUpRequestModel =
                          SignUpRequestModel(
                              name: nameController.text,
                              email: emailController.text,
                              gender: gender,
                              status: "Active");
                      setEmailValues(signUpRequestModel);
                      // emailController.clear();
                      // nameController.clear();
                      // _registerKey.currentState?.reset();

                      registerViewModel.postData(context, signUpRequestModel);
                    }
                  },
                  child: const Text(StringConstants.register,
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
                      StringConstants.orRegister,
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
                      StringConstants.already,
                      style: TextStyle(fontSize: 18, color: Color(0xff032426)),
                    ),
                    InkWell(
                      child: const Text(
                        StringConstants.login,
                        style: TextStyle(
                            color: Colors.blueAccent,
                            fontWeight: FontWeight.w700,
                            fontSize: 18),
                      ),
                      onTap: () {
                        Navigator.pushNamed(context, Routes.loginScreen);
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
