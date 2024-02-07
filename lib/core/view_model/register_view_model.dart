import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mvvm_file_structure/core/constants/string_constants.dart';
import 'package:mvvm_file_structure/core/enums/view_state.dart';
import 'package:mvvm_file_structure/core/models/signup_request_model.dart';
import 'package:mvvm_file_structure/core/routing/routes.dart';
import 'package:mvvm_file_structure/core/repositories/api_repository.dart';
import 'package:mvvm_file_structure/core/utils/show_toast.dart';

class RegisterViewModel {
  ApiRepository apiRepository = ApiRepository();
  dynamic state;

  Future postData(
      BuildContext context, SignUpRequestModel signUpRequestModel) async {
    bool isSuccess = await apiRepository.postData(signUpRequestModel);

    state = ViewState.busy;
    try {
      if (isSuccess) {
        state = ViewState.idle;
        if (context.mounted) {
          Navigator.pushNamed(context, Routes.loginScreen);
        }
        Toast.showToast(StringConstants.userRegistered);
      } else if (!isSuccess) {
        Toast.showToast(StringConstants.userNotRegistered);
      } else {
        Toast.showToast(StringConstants.userNotRegistered);
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
      Toast.showToast(e.toString());
      state = ViewState.idle;
    }
    state = ViewState.idle;
  }
}
