
import 'package:get_it/get_it.dart';
import 'package:workers/network.dart';

import 'database_helper.dart';

final locator = GetIt.instance;

void init() {




  // locator.registerLazySingleton<NetworkApi>(
  //   () => NetworkApi(databaseHelper: locator()),
  // );

  // helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  // network info

}