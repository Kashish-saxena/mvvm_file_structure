import 'package:mvvm_file_structure/core/models/signup_request_model.dart';

abstract class UpdateEvent {}

class PerformUpdateEvent extends UpdateEvent {
  final int userId;
  final SignUpRequestModel signUpRequestModel;

  PerformUpdateEvent(this.userId, this.signUpRequestModel);
}
