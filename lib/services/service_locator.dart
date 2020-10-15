import 'package:badits/services/storage_service.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

/*
Implemented with reference to:
- https://medium.com/flutter-community/creating-services-to-do-the-work-in-your-flutter-app-93d6c4aa7697
*/
setupStorageService() {
  locator.registerLazySingleton<StorageService>(() => StorageService());
}
