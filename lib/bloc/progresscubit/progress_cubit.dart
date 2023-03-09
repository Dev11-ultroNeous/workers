import 'dart:async';
import 'dart:isolate';

import 'package:bloc/bloc.dart';
import 'package:flutter_isolate/flutter_isolate.dart';
import 'package:workers/api/network.dart';
import 'package:workers/injection.dart';
import 'package:workers/sql/database_helper.dart';

part 'progress_state.dart';

class ProgressCubit extends Cubit<ProgressState> {
  ProgressCubit() : super(ProgressInitial());
  var progress = 0.0;
  static final DatabaseHelper databaseHelper = injection<DatabaseHelper>();

  //static final NetworkApi networkApi = NetworkApi();
  void updateProgress() {
    emit(ProgressRunState(progress: progress));
    if (progress == 10.0) {
      Future.delayed(const Duration(seconds: 1), () {
        emit(ProgressInitial());
        progress = 0.0;
      });
    }
  }

  void stopIsolate() {
    emit(ProgressStopState());
    FlutterIsolate.killAll();
  }

  void startIsolate() async {
    progress = 0;
    emit(ProgressRunState(progress: progress));
    clearUserCatch();
    clearNewsCatch();
    final receivePort = ReceivePort();
    FlutterIsolate.spawn(NetworkApi.apiOne, receivePort.sendPort);
    FlutterIsolate.spawn(NetworkApi.apiTwo, receivePort.sendPort);
    FlutterIsolate.spawn(NetworkApi.apiThree, receivePort.sendPort);
    FlutterIsolate.spawn(NetworkApi.apiFour, receivePort.sendPort);
    FlutterIsolate.spawn(NetworkApi.apiFive, receivePort.sendPort);
    FlutterIsolate.spawn(NetworkApi.apiSix, receivePort.sendPort);
    FlutterIsolate.spawn(NetworkApi.apiSeven, receivePort.sendPort);
    FlutterIsolate.spawn(NetworkApi.apiEight, receivePort.sendPort);
    FlutterIsolate.spawn(NetworkApi.apiNine, receivePort.sendPort);
    FlutterIsolate.spawn(NetworkApi.apiTen, receivePort.sendPort);
    receivePort.listen((dynamic response) async {
      if (response is String) {
        progress++;
        updateProgress();
      } else if (response is Error) {}
      if (progress == 10) {
        print("kill Isolate");
        FlutterIsolate.killAll();
        emit(ProgressInitial());
      }
    });
  }

  // @pragma('vm:entry-point')
  // static void apiCalling(SendPort sendPort) async {
  //   init();
  //   setup();
  //   NetworkApi.apiOne(sendPort);
  //   NetworkApi.apiTwo(sendPort);
  //   NetworkApi.apiThree(sendPort);
  //   NetworkApi.apiFour(sendPort);
  //   NetworkApi.apiFive(sendPort);
  //   NetworkApi.apiSix(sendPort);
  //   NetworkApi.apiSeven(sendPort);
  //   NetworkApi.apiEight(sendPort);
  //   NetworkApi.apiNine(sendPort);
  //   NetworkApi.apiTen(sendPort);
  // }

  void getlocal() {
    // syncData(DatabaseHelper.getdataintoLoacal);
    //databaseHelper.getdataintoLoacal(await databaseHelper.getCacheUser());
  }

  void clearUserCatch() {
    emit(ProgressRunState(progress: 0));
    databaseHelper.clearCacheUser();
  }

  void clearNewsCatch() {
    databaseHelper.clearCacheNews();
  }
}
