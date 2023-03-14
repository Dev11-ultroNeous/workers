import 'dart:async';
import 'dart:io';
import 'dart:isolate';

import 'package:bloc/bloc.dart';
import 'package:flutter_isolate/flutter_isolate.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
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
    if (Platform.isAndroid) {
      createNotification(progress.toInt());
    }
    if (progress == 10.0) {
      Future.delayed(const Duration(seconds: 1), () {
        _stopForegroundService();
        emit(ProgressInitial());
        progress = 0.0;
      });
    }
  }

  void stopIsolate() {
    emit(ProgressStopState());
    FlutterIsolate.killAll();
  }

  Future createNotification(int i) async {
    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails('your channel id', 'your channel name',
            channelDescription: 'your channel description',
            importance: Importance.max,
            ticker: 'ticker',
            showProgress: true,
            onlyAlertOnce:true,
            maxProgress: 10,
            progress: i);
    NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails, iOS: null);
    await flutterLocalNotificationsPlugin
        .show(0, 'Workers', 'Syncing...', notificationDetails, payload: 'item');
    // if(Platform.isAndroid){
    //   await flutterLocalNotificationsPlugin
    //       .resolvePlatformSpecificImplementation<
    //       AndroidFlutterLocalNotificationsPlugin>()
    //       ?.startForegroundService(1, 'plain title', 'plain body',
    //       notificationDetails: androidNotificationDetails, payload: 'item');
    // }else{

    //  }
  }

  Future<void> _stopForegroundService() async {
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.stopForegroundService();
  }

  void startIsolate() async {
    await notificationInit();
    progress = 0;
    emit(ProgressRunState(progress: progress));
    clearUserCatch();
    clearNewsCatch();
    final receivePort = ReceivePort();
    await createNotification(progress.toInt());
    await FlutterIsolate.spawn(apiCalling, receivePort.sendPort);
    receivePort.listen((dynamic response) async {
      if (response is String) {
        progress++;
        updateProgress();
      } else if (response is Error) {}
      if (progress == 10) {
        print("Kill Isolate");
        emit(ProgressInitial());
      }
    });
  }

  @pragma('vm:entry-point')
  static void apiCalling(SendPort sendPort) async {
    init();
    setup();
    NetworkApi.apiOne(sendPort);
    NetworkApi.apiTwo(sendPort);
    NetworkApi.apiThree(sendPort);
    NetworkApi.apiFour(sendPort);
    NetworkApi.apiFive(sendPort);
    NetworkApi.apiSix(sendPort);
    NetworkApi.apiSeven(sendPort);
    NetworkApi.apiEight(sendPort);
    NetworkApi.apiNine(sendPort);
    NetworkApi.apiTen(sendPort);
  }

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
