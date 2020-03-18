


import 'package:fdm_expenses_app/screens/services/database_service.dart';
import 'package:get_it/get_it.dart';

import 'screens/services/auth.dart';

GetIt locator = GetIt.instance;

void setupLocator(){
  locator.registerLazySingleton(() => AuthService());
  locator.registerLazySingleton(() => DatabaseService());
}