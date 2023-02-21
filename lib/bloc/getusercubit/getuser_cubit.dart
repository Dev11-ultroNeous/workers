import 'package:workers/injection.dart';
import 'package:workers/model/bankmodel.dart';
import 'package:workers/sql/database_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GetUserDataCubit extends Cubit<GetUserState> {
  GetUserDataCubit() : super(GetUserState(data: []));
  var progress = 0.0;
  final DatabaseHelper databaseHelper = injection<DatabaseHelper>();
  void getUserdata() {
    databaseHelper
        .getCacheUser()
        .then((value) => emit(GetUserState(data: value)));
  }
}

class GetUserState {
  final List<UserData> data;
  GetUserState({
    required this.data,
  });
}
