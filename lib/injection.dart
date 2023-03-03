import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workers/sql/database_helper.dart';
import 'package:workers/sql/shared_prefs_helper.dart';

final injection = GetIt.instance;

void init() async{
  // helper
  injection.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  // network info
}

Future<void> setup() async {
  final prefs = await SharedPreferences.getInstance();
  injection.registerSingleton<SharedPreferenceHelper>(
    SharedPreferenceHelper(prefs: prefs),
  );
}
