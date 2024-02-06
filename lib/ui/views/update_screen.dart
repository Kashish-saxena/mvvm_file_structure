import 'package:flutter/material.dart';
import 'package:mvvm_file_structure/core/constants/string_constants.dart';
import 'package:mvvm_file_structure/core/di/controller.dart';
import 'package:mvvm_file_structure/core/models/signup_request_model.dart';
import 'package:mvvm_file_structure/core/models/signup_response_model.dart';
import 'package:mvvm_file_structure/core/utils/validation_utils.dart';
import 'package:mvvm_file_structure/ui/widgets/radio_field.dart';
import 'package:mvvm_file_structure/ui/widgets/text_form_field.dart';

class UpdateScreen extends StatefulWidget {
  const UpdateScreen({
    Key? key,
    required this.arguments,
    required this.id,
  }) : super(key: key);
  final int id;
  final SignUpResponseModel arguments;

  @override
  UpdateScreenState createState() => UpdateScreenState();
}

class UpdateScreenState extends State<UpdateScreen> {
  final GlobalKey<FormState> _updateKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  String? gender;

  @override
  void initState() {
    super.initState();
    nameController.text = widget.arguments.name ?? "";
    emailController.text = widget.arguments.email ?? "";
    gender = widget.arguments.gender;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        title: const Text(
          StringConstants.updateScreen,
          style: TextStyle(color: Colors.black),
        ),
        leading: BackButton(
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
      ),
      body: buildBody(),
    );
  }

  Widget buildBody() {
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Form(
          key: _updateKey,
          child: Column(
            children: [
              TextFormFieldWidget(
                text: StringConstants.name,
                validator: (value) {
                  return Verification.isNameValid(value ?? "");
                },
                controller: nameController,
                obscureText: false,
              ),
              TextFormFieldWidget(
                text: StringConstants.email,
                obscureText: false,
                controller: emailController,
                validator: (val) {
                  return Verification.isEmailValid(val ?? "");
                },
              ),
              RadioFieldWidget(
                widget: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text(
                      "Gender",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Color(0xff8391A1),
                      ),
                    ),
                    Flexible(
                      child: ListTile(
                        textColor: const Color(0xff8391A1),
                        contentPadding: EdgeInsets.zero,
                        leading: Radio(
                          value: "male",
                          groupValue: gender,
                          onChanged: (value) {
                            setState(() {
                              gender = value.toString();
                            });
                          },
                        ),
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
                                gender = value.toString();
                              });
                            }),
                        title: const Text(StringConstants.female),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(370, 60),
                  backgroundColor: const Color(0xff1E232C),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                onPressed: () async {
                  if (_updateKey.currentState!.validate()) {
                    String updatedName = nameController.text;
                    String updatedEmail = emailController.text;
                    if (updatedName != widget.arguments.name ||
                        updatedEmail != widget.arguments.email ||
                        gender != widget.arguments.gender) {
                      SignUpRequestModel signUpRequestModel =
                          SignUpRequestModel(
                        name: updatedName,
                        email: updatedEmail,
                        gender: gender ?? "",
                        status: "Active",
                      );

                      bool isSuccess = await ApiController.updateUser(
                          widget.id, signUpRequestModel);
                      if (isSuccess && context.mounted) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text(StringConstants.updatedDetails),
                        ));
                        Navigator.pop(context);
                      } else if (!isSuccess && context.mounted) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text(StringConstants.failedToUpdate),
                        ));
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("No changes Detected"),
                      ));
                    }
                  }
                },
                child: const Text(StringConstants.update,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
