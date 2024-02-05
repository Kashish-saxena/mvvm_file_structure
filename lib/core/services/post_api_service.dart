import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:mvvm_file_structure/core/models/signup_request_model.dart';

class PostApiService {
  static Future<bool> postData(SignUpRequestModel signUpRequestModel) async {
    try {
      final response = await http.post(Uri.parse("https://gorest.co.in/public/v2/users"),
          body: signUpRequestModelToJson(signUpRequestModel),
          headers: {
            "Content-Type":"application/json",
            "Authorization":
                "Bearer a9a486e9e05ae8f3998761fba962fa5c8bdfd58b227d425373b4566717afd33c"
          });
      if (response.statusCode == 201) {
        log("Request data is: ${response.body}");
        return true;
      } else {
        return false;
      }
    } catch (e) {
      log("Exception $e");
      return false;
    }
  }
}
