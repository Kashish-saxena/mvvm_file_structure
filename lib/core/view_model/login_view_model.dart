import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mvvm_file_structure/core/constants/string_constants.dart';
import 'package:mvvm_file_structure/core/enums/view_state.dart';
import 'package:mvvm_file_structure/core/models/signup_response_model.dart';
import 'package:mvvm_file_structure/core/utils/show_toast.dart';
import 'package:mvvm_file_structure/ui/views/login_screen.dart';

class LoginViewModel {
  SignUpResponseModel? _loginResponseModel;
  SignUpResponseModel? get loginResponse => _loginResponseModel;
  dynamic state;

  set loginResponse(SignUpResponseModel? value) {
    _loginResponseModel = value;
  }

  Future getData(BuildContext context) async {
    state = ViewState.busy;

    try {
      if (loginResponse?.status == "201") {
        state = ViewState.idle;
      } else if (loginResponse?.status == "401") {
        Toast.showToast(StringConstants.pageNotFound);
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const LoginScreen()),
            (Route<dynamic> route) => false);
      } else if (loginResponse?.status == "500") {
        Toast.showToast(StringConstants.somethingWentWrong);
        state = ViewState.idle;
      } else {
        Toast.showToast(StringConstants.somethingWentWrong);
        state = ViewState.idle;
      }
    } on DioException catch (e) {
      if (e.response != null) {
        if (e.response?.statusCode.toString().startsWith("5") == true) {
          state = ViewState.idle;
          Toast.showToast(e.response!.statusMessage.toString());
          return;
        }
      }
      e.response != null
          ? Toast.showToast(e.response!.data["message"].toString())
          : Toast.showToast(e.message ?? "");
      state = ViewState.idle;
    } catch (e) {
      Toast.showToast(StringConstants.somethingWentWrong);
      state = ViewState.idle;
    }
    state = ViewState.idle;
  }
}
