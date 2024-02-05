import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:mvvm_file_structure/core/models/signup_response_model.dart';

class GetApiService {
  Future<List<SignUpResponseModel>> getData() async {
    List<SignUpResponseModel> userList = [];
    try {
      Response response = await http.get(
        Uri.parse("https://gorest.co.in/public/v2/users"),
        headers: {
          'Content-Type': "application/json",
          "Authorization":
              "Bearer a9a486e9e05ae8f3998761fba962fa5c8bdfd58b227d425373b4566717afd33c",
        },
      );

      if (response.statusCode == 200) {
        userList = signUpResponseModelFromJson(response.body);

        // if (response.statusCode == 200) {
        //   List<dynamic> userData = response.body ;
        //   for (var i = 0; i < userData.length; i++) {
        //     SignUpResponseModel signUpResponseModel = SignUpResponseModel(
        //       email: userData[i]['email'],
        //       gender: userData[i]['gender'],
        //       id: userData[i]['id'],
        //       name: userData[i]['name'],
        //       status: userData[i]['status'],
        //     );
        //     userList.add(signUpResponseModel);
        //   }
      } else {
        log('Error response: ${response.statusCode}');
      }
    } catch (e) {
      log('Error in fetching data $e');
    }
    return userList;
  }

  static Future<List<SignUpResponseModel>?> getUserDetails(int userId) async {
    try {
      Response response = await http.get(
        Uri.parse('https://gorest.co.in/public/v2/users/$userId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization':
              'Bearer 4886dfcfd3d0dd22cba3a9d2d0aac01a0c43e93259141dc48ba45a5c56f7272b',
        },
      );

      if (response.statusCode == 200) {
        return signUpResponseModelFromJson(response.body);
      } else {
        log('Error getting user details. Status code: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      log('Error getting user details: $e');
      return null;
    }
  }
}
