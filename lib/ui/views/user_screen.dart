import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:mvvm_file_structure/core/di/controller.dart';
import 'package:mvvm_file_structure/core/models/signup_response_model.dart';
import 'package:mvvm_file_structure/core/routing/routes.dart';
import 'package:mvvm_file_structure/ui/widgets/back_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({Key? key}) : super(key: key);
  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  late Future<List<SignUpResponseModel>> _userDataFuture;
  late SharedPreferences prefs;
  removeData() async {
    prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  @override
  void initState() {
    super.initState();
    _userDataFuture = ApiController.getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        leading: BackButtonWidget(
          onTap: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.white,
        title: const Text(
          'User Details',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(width: 1, color: const Color(0xffE8ECF4)),
            ),
            child: TextButton(
              onPressed: () {
                removeData();
                ScaffoldMessenger.of(context)
                    .showSnackBar(const SnackBar(content: Text("Logged Out")));
                Navigator.pushNamed(context, Routes.welcomeScreen);
              },
              child: const Text(
                "Logout",
                style: TextStyle(color: Colors.black, fontSize: 15),
              ),
            ),
          )
        ],
      ),
      body:buildBody(),
    );

  }
  Widget buildBody(){
    return FutureBuilder<List<SignUpResponseModel>>(
        future: _userDataFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error occured: ${snapshot.error}'),
            );
          } else if (!snapshot.hasData) {
            return const Center(
              child: Text('No data available'),
            );
          }
          List<SignUpResponseModel> userList = snapshot.data!;
          return ListView.builder(
            itemCount: userList.length,
            itemBuilder: (context, index) {
              SignUpResponseModel user = userList[index];
              return Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
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
                              await ApiController.deleteUser(user.id ?? 0);
                          if (isSuccess) {
                            setState(() {
                              _userDataFuture = ApiController.getData();
                            });
                            const snackBar = SnackBar(
                              content: Text("User Deleted"),
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
                                content: Text("Failed to Delete"),
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
                          await Navigator.pushNamed(
                              context, Routes.updateScreen,
                              arguments: {'user': user, 'id': user.id});

                          setState(() {
                            _userDataFuture = ApiController.getData();
                          });
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      );
  }
}
