import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mvvm_file_structure/core/bloc/bloc/api_bloc.dart';
import 'package:mvvm_file_structure/core/bloc/bloc_event/api_event.dart';
import 'package:mvvm_file_structure/core/bloc/bloc_state/api_state.dart';
import 'package:mvvm_file_structure/core/constants/string_constants.dart';
import 'package:mvvm_file_structure/core/models/signup_response_model.dart';
import 'package:mvvm_file_structure/core/routing/routes.dart';
import 'package:mvvm_file_structure/core/services/delete_api_service.dart';
import 'package:mvvm_file_structure/ui/widgets/back_button.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint("Called build>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
    return Scaffold(
      appBar: AppBar(
        leading: BackButtonWidget(
          onTap: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.white,
        title: const Text(
          StringConstants.userDetail,
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: blockBody(context),
    );
  }
}

Widget blockBody(context) {
  debugPrint("Called>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
  final update = BlocProvider.of<ApiBloc>(context);
  return BlocBuilder<ApiBloc, ApiState>(
    builder: (context, state) {
      if (state is ApiLoading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      if (state is ApiError) {
        return const Center(child: Text(StringConstants.error));
      }
      if (state is ApiLoaded) {
        List<SignUpResponseModel> userList = state.signUpResponseModel;
        return ListView.builder(
          itemCount: userList.length,
          itemBuilder: (context, index) {
            SignUpResponseModel user = userList[index];
            return Container(
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              decoration: BoxDecoration(
                color: const Color(0xffF7F8F9),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: const Color(0xffE8ECF4)),
              ),
              child: ListTile(
                title: Text(
                  "Name: ${user.name}",
                  style: const TextStyle(color: Colors.black),
                ),
                subtitle: Text(
                  'Email: ${user.email}',
                  style: const TextStyle(color: Colors.black),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.black,
                      ),
                      onPressed: () async {
                        bool isSuccess =
                            await DeleteApiService.deleteUser(user.id ?? 0);
                        if (isSuccess) {
                          update.add(GetApiList());

                          const snackBar = SnackBar(
                            content: Text(StringConstants.userDeleted),
                            duration: Duration(seconds: 2),
                          );
                          if (context.mounted) {
                            //throwing the warning that buildcontext can't be used in async

                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }
                        } else {
                          log("Failed to Delete");
                          const snackBar = SnackBar(
                              content: Text(StringConstants.failedToDelete),
                              duration: Duration(seconds: 2));
                          if (context.mounted) {
                            //throwing the warning that buildcontext can't be used in async

                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }
                        }
                      },
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.edit,
                        color: Colors.black,
                      ),
                      onPressed: () async {
                        user.status = "Active";
                        await Navigator.pushNamed(context, Routes.updateScreen,
                            arguments: [user, user.id]);
                        update.add(GetApiList());
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        );
      } else {
        return Container();
      }
    },
  );
}
