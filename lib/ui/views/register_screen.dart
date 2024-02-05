import 'package:flutter/material.dart';
import 'package:mvvm_file_structure/core/constants/string_constants.dart';
import 'package:mvvm_file_structure/core/models/signup_request_model.dart';
import 'package:mvvm_file_structure/core/services/post_api_service.dart';
import 'package:mvvm_file_structure/core/utils/signup_verification.dart';
import 'package:mvvm_file_structure/ui/views/user_screen.dart';
import 'package:mvvm_file_structure/ui/widgets/back_button.dart';
import 'package:mvvm_file_structure/ui/widgets/link_buttons.dart';
import 'package:mvvm_file_structure/ui/widgets/radio_field.dart';
import 'package:mvvm_file_structure/ui/widgets/text_form_field.dart';

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

  @override
  Widget build(BuildContext context) {
    return buildBody();
  }

  Widget buildBody() {
    return Scaffold(
      appBar: AppBar(
        leading: BackButtonWidget(
          onTap: () => Navigator.pop(context),
        ),
      ),
      body: Center(
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
                      SnackBar snackBar;
                      if (_registerKey.currentState!.validate()) {
                        snackBar =
                            const SnackBar(content: Text(StringConstants.userRegistered));
                        SignUpRequestModel signUpRequestModel =
                            SignUpRequestModel(
                                name: nameController.text,
                                email: emailController.text,
                                gender: gender,
                                status: "Active");
                        bool isSuccess =
                            await PostApiService.postData(signUpRequestModel);
                        if (isSuccess && context.mounted) {
                          
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const UserScreen(),
                              ));
                        } else {
                          snackBar = const SnackBar(
                              content: Text(StringConstants.userNotRegistered));
                        }

                        if (context.mounted) {
                          //throwing the warning that buildcontext can't be used in async
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
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
                  const Text(
                    StringConstants.or,
                    style: TextStyle(
                      fontSize: 18,
                    ),
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
                        style:
                            TextStyle(fontSize: 18, color: Color(0xff032426)),
                      ),
                      InkWell(
                        child: const Text(
                          StringConstants.already,
                          style: TextStyle(
                              color: Colors.blueAccent,
                              fontWeight: FontWeight.w700,
                              fontSize: 18),
                        ),
                        onTap: () {},
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
