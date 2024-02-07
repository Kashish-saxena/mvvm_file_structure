import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mvvm_file_structure/core/constants/string_constants.dart';
import 'package:mvvm_file_structure/core/enums/view_state.dart';
import 'package:mvvm_file_structure/core/models/signup_response_model.dart';
import 'package:mvvm_file_structure/core/repositories/api_repository.dart';
import 'package:mvvm_file_structure/core/utils/show_toast.dart';

class UserListViewModel {
  ApiRepository apiRepository = ApiRepository();
  dynamic state;

  Future<List<SignUpResponseModel>> getData(BuildContext context) async {
    state = ViewState.busy;
    List<SignUpResponseModel> response = await apiRepository.getData();
    try {
      if (response.isNotEmpty) {
        state = ViewState.idle;
        return response;
      } else if (response.isEmpty) {
        Toast.showToast("No Data Found...");
      } else {
        Toast.showToast(StringConstants.somethingWentWrong);
        state = ViewState.idle;
      }
    } on DioException catch (e) {
      if (e.response != null) {
        if (e.response?.statusCode.toString().startsWith("5") == true) {
          state = ViewState.idle;
          Toast.showToast(e.response!.statusMessage.toString());
          return response;
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
    return response;
  }

  Future deleteUser(BuildContext context, int id) async {
    state = ViewState.busy;
    bool isSuccess = await apiRepository.deleteUser(id);
    try {
      if (isSuccess) {
        state = ViewState.idle;
        Toast.showToast("User Deleted");
      } else if (!isSuccess) {
        Toast.showToast("Failed to Delete");
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
      state = ViewState.idle;
    } catch (e) {
      Toast.showToast(e.toString());
      state = ViewState.idle;
    }
    state = ViewState.idle;
  }
}
