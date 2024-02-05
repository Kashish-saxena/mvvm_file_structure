import 'package:bloc/bloc.dart';
import 'package:mvvm_file_structure/core/bloc/bloc_event/api_event.dart';
import 'package:mvvm_file_structure/core/bloc/bloc_state/api_state.dart';
import 'package:mvvm_file_structure/core/di/controller.dart';
import 'package:mvvm_file_structure/core/models/signup_response_model.dart';

class ApiBloc extends Bloc<ApiEvent, ApiState> {
  ApiBloc() : super(ApiInitial()) {
    on<GetApiList>((event, emit) async {
      try {
        emit(ApiLoading());
        List<SignUpResponseModel> mList = await ApiController.getData();
        emit(ApiLoaded(mList));
        if (mList.isEmpty) {
          emit(const ApiError("List is Empty"));
        }
      } catch (e) {
        emit(const ApiError("Failed to fetch data..."));
      }
    });
  }
}
