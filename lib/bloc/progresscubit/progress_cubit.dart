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

  void resumeIsolate() async {
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
    init();
    setup();
    // int i =1;
    // Timer.periodic(Duration(seconds:1),(timer){
    //   print("Timer Running From Isolate $i");
    //   i++;
    //   sendPort.send("Add succeed");
    // });
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

// import 'dart:async';
// import 'dart:isolate';
//
// import 'package:bloc/bloc.dart';
// import 'package:flutter_isolate/flutter_isolate.dart';
// import 'package:workers/api/network.dart';
// import 'package:workers/injection.dart';
// import 'package:workers/sql/database_helper.dart';
//
// part 'progress_state.dart';
//
// class ProgressCubit extends Cubit<ProgressState> {
//   ProgressCubit() : super(ProgressInitial());
//
//   double progress = 0.0;
//   late FlutterIsolate isolate;
//   late Completer<void> _completer;
//   bool _paused = false;
//   final DatabaseHelper databaseHelper = injection<DatabaseHelper>();
//   void mainIsolate() async {
//     // _isolates = List<FlutterIsolate>.empty(growable: true);
//     _completer = Completer<void>();
//
//     // spawn each isolate and listen for results
//     final apiCalls = [
//       NetworkApi.apiOne,
//       NetworkApi.apiTwo,
//       NetworkApi.apiThree,
//       NetworkApi.apiFour,
//       NetworkApi.apiFive,
//       NetworkApi.apiSix,
//       NetworkApi.apiSeven,
//       NetworkApi.apiEight,
//       NetworkApi.apiNine,
//       NetworkApi.apiTen,
//
//
//       // add more API calls as needed
//     ];
//     final futures = apiCalls.map((apiFunction) => syncData(apiFunction));
//
//     Future.wait(futures).then((_) {
//       progress = 10;
//      // updateProgress();
//     });
//     }
// Future<void> syncData(void Function(SendPort) entryPoint) async {
//   final receivePort = ReceivePort();
//    isolate = await FlutterIsolate.spawn(entryPoint, receivePort.sendPort);
//
//   receivePort.listen((dynamic response) {
//     if (response is String) {
//       print(response);
//     } else if (response is Error) {}
//
//     if (progress == 10) {
//       isolate.kill();
//     }
//   });
// }
//   void pauseIsolate()  {
//
//       isolate.pause();
//
//     emit(ProgressPausState());
//   }
//
//   void resumeIsolate() {
//
//       isolate.resume();
//     emit(ProgressRunState(progress: progress));
//   }
//
//   void cancelIsolates() {
//       isolate.kill();
//     _completer.complete();
//     emit(ProgressInitial());
//   }
//   void clearUserCache() {
//     emit(ProgressRunState(progress: 0));
//     databaseHelper.clearCacheUser();
//   }
//   void clearNewsCache() {
//     databaseHelper.clearCacheNews();
//   }
//
//   Future<void> waitCompletion() => _completer.future;
// }

// import 'dart:async';
// import 'dart:isolate';
//
// import 'package:bloc/bloc.dart';
// import 'package:flutter_isolate/flutter_isolate.dart';
// import 'package:workers/api/network.dart';
// import 'package:workers/injection.dart';
// import 'package:workers/sql/database_helper.dart';
//
// part 'progress_state.dart';
//
// class ProgressCubit extends Cubit<ProgressState> {
//   ProgressCubit() : super(ProgressInitial());
//
//   double progress = 0.0;
//   late List<FlutterIsolate> _isolates;
//   late Completer<void> _completer;
//   bool _paused = false;
//   final DatabaseHelper databaseHelper = injection<DatabaseHelper>();
//
//   void mainIsolate() async {
//     _isolates = List<FlutterIsolate>.empty(growable: true);
//     _completer = Completer<void>();
//     // spawn each isolate and listen for results
//     final apiCalls = [
//       NetworkApi.apiOne,
//       NetworkApi.apiTwo,
//       NetworkApi.apiThree,
//       NetworkApi.apiFour,
//       NetworkApi.apiFive,
//       NetworkApi.apiSix,
//       NetworkApi.apiSeven,
//       NetworkApi.apiEight,
//       NetworkApi.apiNine,
//       NetworkApi.apiTen,
//       // add more API calls as needed
//     ];
//     for (var apiFunction in apiCalls) {
//       await syncData(apiFunction);
//     }
//     emit(ProgressRunState(progress: progress));
//   }
//
//   Future<void> syncData(void Function(SendPort) entryPoint) async {
//     final receivePort = ReceivePort();
//     final isolate = await FlutterIsolate.spawn(entryPoint, receivePort.sendPort);
//     _isolates.add(isolate);
//     receivePort.listen((dynamic response) {
//       if (response is String) {
//         progress++;
//         print("$response  $progress");
//       } else if (response is Error) {}
//       // if (progress == 10) {
//       //   cancelIsolates();
//       //   emit(ProgressInitial());
//       // }
//     });
//
//   }
//
//   void pauseIsolate() {
//     if (!_completer!.isCompleted) {
//       emit(ProgressPausState());
//       _completer!.complete();
//       for (var isolate in _isolates) {
//         isolate.pause();
//       }
//
//     }
//   }
//
//   void resumeIsolate() {
//     if (_completer!.isCompleted) {
//       _completer = Completer<void>();
//       emit(ProgressRunState(progress: progress));
//       for (var isolate in _isolates) {
//         isolate.resume();
//       }
//     }
//   }
//
//   void cancelIsolates() {
//     for (var isolate in _isolates) {
//       isolate.kill();
//     }
//     emit(ProgressInitial());
//   }
//
//   void clearUserCache() {
//     emit(ProgressRunState(progress: 0));
//     databaseHelper.clearCacheUser();
//   }
//
//   void clearNewsCache() {
//     databaseHelper.clearCacheNews();
//   }
//   Future<void> waitCompletion() => _completer.future;
// }
