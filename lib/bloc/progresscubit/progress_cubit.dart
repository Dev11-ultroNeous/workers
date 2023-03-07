import 'dart:convert';
import 'dart:isolate';

import 'package:bloc/bloc.dart';
import 'package:flutter_isolate/flutter_isolate.dart';
import 'package:workers/api/network.dart';
import 'package:workers/injection.dart';
import 'package:workers/sql/database_helper.dart';
import 'package:http/http.dart' as http;
part 'progress_state.dart';

// class ProgressCubit extends Cubit<ProgressState> {
//   ProgressCubit() : super(ProgressInitial());
//   var progress = 0.0;
//   final DatabaseHelper databaseHelper = injection<DatabaseHelper>();

//   //static final NetworkApi networkApi = NetworkApi();
//   void updateProgress() {
//     emit(ProgressRunState(progress: progress));
//     if (progress == 10.0) {
//       Future.delayed(const Duration(seconds: 1), () {
//         emit(ProgressInitial());
//         progress = 0.0;
//       });
//     }
//   }

//   void pauseIsolate() {
//     FlutterIsolate.current.pause();
//     emit(ProgressPausState());
//   }

//   void resumeIsolate() {
//     FlutterIsolate.current.resume();
//     updateProgress();
//   }

//   void getlocal() {
//     syncData(DatabaseHelper.getdataintoLoacal);
//     //databaseHelper.getdataintoLoacal(await databaseHelper.getCacheUser());
//   }

//   void mainIsolate() {
//     syncData(NetworkApi.apiOne).then((value) {
//       progress++;
//       updateProgress();
//     });
//     syncData(NetworkApi.apiTwo).then((value) {
//       progress++;
//       updateProgress();
//     });
//     syncData(NetworkApi.apiThree).then((value) {
//       progress++;
//       updateProgress();
//     });
//     syncData(NetworkApi.apiFour).then((value) {
//       progress++;
//       updateProgress();
//     });
//     syncData(NetworkApi.apiFive).then((value) {
//       progress++;
//       updateProgress();
//     });
//     syncData(NetworkApi.apiSix).then((value) {
//       progress++;
//       updateProgress();
//     });
//     syncData(NetworkApi.apiSeven).then((value) {
//       progress++;
//       updateProgress();
//     });
//     syncData(NetworkApi.apiEight).then((value) {
//       progress++;
//       updateProgress();
//     });
//     syncData(NetworkApi.apiNine).then((value) {
//       progress++;
//       updateProgress();
//     });
//     syncData(NetworkApi.apiTen).then((value) {
//       progress++;
//       updateProgress();
//     });
//   }

//   Future<void> syncData(void Function(SendPort) entryPoint) async {
//     final receivePort = ReceivePort();
//     final isolate =
//         await FlutterIsolate.spawn(entryPoint, receivePort.sendPort);
//     receivePort.listen((dynamic response) async {
//       if (response is String) {
//         print(response);
//       } else if (response is Error) {}
//       isolate.kill();

//       print("Kill Isolate");
//     });
//   }

//   void clearUserCatch() {
//     emit(ProgressRunState(progress: 0));
//     databaseHelper.clearCacheUser();
//   }

//   void clearNewsCatch() {
//     databaseHelper.clearCacheNews();
//   }
// }

class ProgressCubit extends Cubit<ProgressState> {
  ProgressCubit() : super(ProgressInitial());
  var progress = 0.0;
  final DatabaseHelper databaseHelper = injection<DatabaseHelper>();
  final Set<FlutterIsolate> _isolates = {};
  late FlutterIsolate isolate;
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

  void pauseIsolate() {
    isolate.pause();
    emit(ProgressPausState());
  }

  void resumeIsolate() {
    isolate.resume();
    updateProgress();
  }

  void mainIsolate() async {
    final receivePort = ReceivePort();
    isolate = await FlutterIsolate.spawn(apiCalling, receivePort.sendPort);
    receivePort.listen((dynamic response) async {
      if (response is String) {
        progress++;
        updateProgress();
      } else if (response is Error) {}
      if (progress == 10) {
        isolate.kill();
        print("Kill Isolate");
        emit(ProgressInitial());
      }
    });
  }

  @pragma('vm:entry-point')
  static void apiCalling(SendPort sendPort) async {
    // int i =1;
    // Timer.periodic(Duration(seconds:1),(timer){
    //   print("Timer Running From Isolate $i");
    //   i++;
    //   sendPort.send("Add succeed");
    // });
    print("Call API Four");
    for (int i = 0; i < 10; i++) {
      final data = await http
          .get(Uri.parse('https://random-data-api.com/api/v2/users?size=$i'));
      final dataList = jsonDecode(data.body);
      print(dataList);
      sendPort.send("Add succeed");
    }
    // sendPort.send("Add succeed");
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
