import 'package:bloc/bloc.dart';
import 'package:workers/api/network.dart';
import 'package:workers/injection.dart';
import 'package:workers/sql/database_helper.dart';
import 'package:workers/worker_manager/worker_manager.dart';
import 'package:flutter/cupertino.dart';

part 'progress_state.dart';

class ProgressCubit extends Cubit<ProgressState> {
  ProgressCubit() : super(ProgressInitial());
  var progress = 0.0;
  final DatabaseHelper databaseHelper = injection<DatabaseHelper>();
  final NetworkApi networkApi = NetworkApi();
  void updateProgress() {
    emit(ProgressRunState(progress: progress));
    if (progress == 10.0) {
      Future.delayed(const Duration(seconds: 1), () {
        emit(ProgressInitial());
        progress = 0.0;
      });
    }
  }

  void pauseIsolate() {
    Executor().pausePool();
    emit(ProgressPausState());
  }

  void resumeIsolate() {
    Executor().resumePool();
    updateProgress();
  }

  void getlocal() {
    Executor()
        .execute(
          arg1: 3,
          fun1: databaseHelper.getdataintoLoacal,
        )
        .then((value) => debugPrint(value));
    //databaseHelper.getdataintoLoacal(await databaseHelper.getCacheUser());
  }

  void mainIsolate() {
    Executor()
        .execute(
      arg1: 3,
      fun1: networkApi.apiOne,
    )
        .then((value) {
      if (value.isNotEmpty) {
        databaseHelper.insertUsers(value);
        progress++;
        updateProgress();
      }
    });
    Executor()
        .execute(
      arg1: 2,
      fun1: networkApi.apiTwo,
    )
        .then((value) {
      if (value.isNotEmpty) {
        databaseHelper.insertBanks(value);
        progress++;
        updateProgress();
      }
    });
    Executor()
        .execute(
      arg1: 2,
      fun1: networkApi.apiThree,
    )
        .whenComplete(() {
      progress++;
      updateProgress();
    });
    Executor()
        .execute(
      arg1: 1,
      fun1: networkApi.apiFour,
    )
        .then((value) {
      if (value.isNotEmpty) {
        databaseHelper.insertUsers(value);
        progress++;
        updateProgress();
      }
    });
    Executor()
        .execute(
      arg1: 2,
      fun1: networkApi.apiFive,
    )
        .whenComplete(() {
      progress++;
      updateProgress();
    });
    Executor()
        .execute(
      arg1: 2,
      fun1: networkApi.apiSix,
    )
        .whenComplete(() {
      progress++;
      updateProgress();
    });
    Executor()
        .execute(
      arg1: 2,
      fun1: networkApi.apiSeven,
    )
        .then((value) {
      if (value.isNotEmpty) {
        databaseHelper.insertArticles(value);
        progress++;
        updateProgress();
      }
    });
    Executor()
        .execute(
      arg1: 2,
      fun1: networkApi.apiEight,
    )
        .whenComplete(() {
      progress++;
      updateProgress();
    });
    Executor()
        .execute(
      arg1: 2,
      fun1: networkApi.apiNine,
    )
        .whenComplete(() {
      progress++;
      updateProgress();
    });
    Executor()
        .execute(
      arg1: 1,
      fun1: networkApi.apiTen,
    )
        .then((value) {
      if (value.isNotEmpty) {
        databaseHelper.insertUsers(value);
        progress++;
        updateProgress();
      }
    });
  }

  void clearUserCatch() {
    emit(ProgressRunState(progress: 0));
    databaseHelper.clearCacheUser();
  }

  void clearNewsCatch() {
    databaseHelper.clearCacheNews();
  }
}
