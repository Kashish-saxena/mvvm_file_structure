import 'package:bloc/bloc.dart';
import 'package:mvvm_file_structure/core/bloc/bloc_event/update_event.dart';
import 'package:mvvm_file_structure/core/bloc/bloc_state/update_state.dart';
import 'package:mvvm_file_structure/core/di/controller.dart';

class UpdateBloc extends Bloc<UpdateEvent, UpdateState> {
  UpdateBloc() : super(UpdateInitial()) {
    on<PerformUpdateEvent>((event, emit) async {
      try {
        bool isSuccess = await ApiController.updateUser(
            event.userId, event.signUpRequestModel);
        if (isSuccess) {
          emit(UpdateSuccess());
        } else {
          emit(UpdateFailed());
        }
      } catch (e) {
        emit(UpdateFailed());
      }
    });
  }
}
