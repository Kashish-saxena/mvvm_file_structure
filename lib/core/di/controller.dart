import 'package:mvvm_file_structure/core/di/locator.dart';
import 'package:mvvm_file_structure/core/models/signup_request_model.dart';
import 'package:mvvm_file_structure/core/models/signup_response_model.dart';
import 'package:mvvm_file_structure/core/services/delete_api_service.dart';
import 'package:mvvm_file_structure/core/services/get_api_service.dart';
import 'package:mvvm_file_structure/core/services/post_api_service.dart';
import 'package:mvvm_file_structure/core/services/update_api_service.dart';

class ApiController {
  static Future<List<SignUpResponseModel>> getData() async {
    return locator.get<GetApiService>().getData();
  }

  static Future<bool> updateUser(
      int userId, SignUpRequestModel signUpRequestModel) async {
    return locator
        .get<UpdateApiService>()
        .updateUser(userId, signUpRequestModel);
  }

  static Future<bool> postData(SignUpRequestModel signUpRequestModel) async {
    return locator.get<PostApiService>().postData(signUpRequestModel);
  }

  static Future<bool> deleteUser(int userId) async {
    return locator.get<DeleteApiService>().deleteUser(userId);
  }
}
