import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mvvm_file_structure/core/bloc/bloc/update_bloc.dart';
import 'package:mvvm_file_structure/core/bloc/bloc_event/update_event.dart';
import 'package:mvvm_file_structure/core/bloc/bloc_state/update_state.dart';
import 'package:mvvm_file_structure/core/constants/string_constants.dart';
import 'package:mvvm_file_structure/core/models/signup_request_model.dart';
import 'package:mvvm_file_structure/core/utils/signup_verification.dart';
import 'package:mvvm_file_structure/ui/widgets/radio_field.dart';

class UpdateScreen extends StatefulWidget {
  const UpdateScreen({
    Key? key,
    required this.arguments,
    required this.id,
  }) : super(key: key);
  final int id;
  final SignUpRequestModel arguments;

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
    return BlocListener<UpdateBloc, UpdateState>(
      listener: (context, state) {
        if (state is UpdateSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(StringConstants.updatedDetails),
          ));
          Navigator.pop(context);
        } else if (state is UpdateFailed) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(StringConstants.failedToUpdate),
          ));
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            StringConstants.updateScreen,
            style: TextStyle(color: Colors.black),
          ),
          leading: BackButton(
            onPressed: () => Navigator.pop(context),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Form(
              key: _updateKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: nameController,
                    decoration:
                        const InputDecoration(labelText: StringConstants.name),
                    validator: (val) {
                      return Verification.isNameValid(val ?? "");
                    },
                  ),
                  TextFormField(
                    controller: emailController,
                    decoration:
                        const InputDecoration(labelText: StringConstants.email),
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
                    onPressed: () {
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
                          context.read<UpdateBloc>().add(
                                PerformUpdateEvent(
                                  widget.id,
                                  signUpRequestModel,
                                ),
                              );
                        }
                      }
                    },
                    child: const Text(StringConstants.update),
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
