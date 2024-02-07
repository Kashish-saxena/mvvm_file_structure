import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:mvvm_file_structure/core/models/signup_request_model.dart';
import 'package:mvvm_file_structure/core/models/signup_response_model.dart';

class ApiRepository {
  static Dio dio = Dio();

  //post api service
  Future<bool> postData(SignUpRequestModel signUpRequestModel) async {
    try {
      final response = await dio.post(
        "https://gorest.co.in/public/v2/users",
        data: signUpRequestModelToJson(signUpRequestModel),
        options: Options(headers: {
          "Content-Type": "application/json",
          "Authorization":
              "Bearer a9a486e9e05ae8f3998761fba962fa5c8bdfd58b227d425373b4566717afd33c"
        }),
      );

      if (response.statusCode == 201) {
        log("Request data is: ${response.data}");
        return true;
      } else {
        return false;
      }
    } catch (e) {
      log("Exception $e");
      return false;
    }
  }

  //get api service
  Future<List<SignUpResponseModel>> getData() async {
    List<dynamic> userData = [];
    List<SignUpResponseModel> userList = [];
    try {
      final response = await dio.get(
        "https://gorest.co.in/public/v2/users",
        options: Options(
          headers: {
            'Content-Type': "application/json",
            "Authorization":
                "Bearer a9a486e9e05ae8f3998761fba962fa5c8bdfd58b227d425373b4566717afd33c",
          },
        ),
      );

      if (response.statusCode == 200) {
        userData = response.data;
        userList = userData.map((e) {
          return SignUpResponseModel.fromJson(e);
        }).toList();
      } else {
        log('Error response: ${response.statusCode}');
      }
    } catch (e) {
      log('Error in fetching data $e');
    }
    return userList;
  }

  //getSingleUser api service
  Future<List<SignUpResponseModel>?> getUserDetails(int userId) async {
    try {
      final response = await dio.get(
        'https://gorest.co.in/public/v2/users/$userId',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization':
                'Bearer a9a486e9e05ae8f3998761fba962fa5c8bdfd58b227d425373b4566717afd33c',
          },
        ),
      );
      if (response.statusCode == 200) {
        return signUpResponseModelFromJson(response.data);
      } else {
        log('Error getting user details. Status code: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      log('Error getting user details: $e');
      return null;
    }
  }

  //delete api service
  Future<bool> deleteUser(int userId) async {
    try {
      final response =
          await dio.delete('https://gorest.co.in/public/v2/users/$userId',
              options: Options(
                headers: {
                  'Content-Type': 'application/json',
                  'Authorization':
                      'Bearer a9a486e9e05ae8f3998761fba962fa5c8bdfd58b227d425373b4566717afd33c',
                },
              ));
      if (response.statusCode == 204) {
        log('User deleted successfully');
        return true;
      } else {
        log('Error response: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      log('Error in deleting user $e');
      return false;
    }
  }

  //update api service
  Future<bool> updateUser(int id, SignUpRequestModel signUpRequestModel) async {
    try {
      final response = await dio.put(
        "https://gorest.co.in/public/v2/users/$id",
        data: signUpRequestModelToJson(signUpRequestModel),
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            "Authorization":
                "Bearer a9a486e9e05ae8f3998761fba962fa5c8bdfd58b227d425373b4566717afd33c"
          },
        ),
      );
      if (response.statusCode == 200) {
        log("Updated user deatails: ${response.data}");
        return true;
      } else {
        log("Failed to load data is: ");
        return false;
      }
    } catch (e) {
      log("Exception $e");
      return false;
    }
  }
}
