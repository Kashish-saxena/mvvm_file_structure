import 'package:get_it/get_it.dart';
import 'package:mvvm_file_structure/core/services/delete_api_service.dart';
import 'package:mvvm_file_structure/core/services/get_api_service.dart';
import 'package:mvvm_file_structure/core/services/post_api_service.dart';
import 'package:mvvm_file_structure/core/services/update_api_service.dart';

final locator = GetIt.instance;

void setUpLocator() {
  locator.registerLazySingleton(() => GetApiService());
  locator.registerLazySingleton(() => PostApiService());
  locator.registerLazySingleton(() => UpdateApiService());
  locator.registerLazySingleton(() => DeleteApiService());
}
