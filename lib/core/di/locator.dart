import 'package:get_it/get_it.dart';
import 'package:mvvm_file_structure/core/repositories/api_repository.dart';

final locator = GetIt.instance;

void setUpLocator() {
  locator.registerLazySingleton(() => ApiRepository());
}
