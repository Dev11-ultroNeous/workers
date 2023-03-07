import 'package:workers/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/getusercubit/getuser_cubit.dart';
import 'bloc/newscubit/news_cubit.dart';
import 'bloc/progresscubit/progress_cubit.dart';
import 'dashbord.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  init();
  await setup();
  runApp(const FlutterBlueApp());
}

class FlutterBlueApp extends StatelessWidget {
  const FlutterBlueApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      color: Colors.lightBlue,
      home: MultiBlocProvider(
        providers: [
          BlocProvider<ProgressCubit>(
            create: (BuildContext context) => ProgressCubit(),
          ),
          BlocProvider<GetUserDataCubit>(
            create: (BuildContext context) => GetUserDataCubit(),
          ),
          BlocProvider<NewsCubit>(
            create: (BuildContext context) => NewsCubit(),
          )
        ],
        child: const Dashboard(),
      ),
    );
  }
}


// import 'dart:async';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_isolate/flutter_isolate.dart';
// import 'package:path_provider/path_provider.dart';
//
// @pragma('vm:entry-point')
// void isolate2(String arg) {
//   getTemporaryDirectory().then((dir) async {
//     print("isolate2 temporary directory: $dir");
//
//
//   });
//   Timer.periodic(
//       Duration(seconds: 1), (timer) => print("Timer Running From Isolate 2"));
// }
// @pragma('vm:entry-point')
// void isolate1(String arg) async {
//   await FlutterIsolate.spawn(isolate2, "hello2");
//
//   getTemporaryDirectory().then((dir) {
//     print("isolate1 temporary directory: $dir");
//   });
//   Timer.periodic(
//       Duration(seconds: 1), (timer) => print("Timer Running From Isolate 1"));
// }
// @pragma('vm:entry-point')
// void computeFunction(String arg) async {
//   getTemporaryDirectory().then((dir) {
//     print("Temporary directory in compute function : $dir with arg $arg");
//   });
// }
//
// void main() async {
//   runApp(MyApp());
// }
//
// class MyApp extends StatefulWidget {
//   @override
//   _MyAppState createState() => _MyAppState();
// }
//
// class _MyAppState extends State<MyApp> {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//         home: Scaffold(
//             appBar: AppBar(
//               title: const Text('Plugin example app'),
//             ),
//             body: AppWidget()));
//   }
// }
//
// class AppWidget extends StatelessWidget {
//
//
//   Future<void> _run() async {
//     print(
//         "Temp directory in main isolate : ${(await getTemporaryDirectory()).path}");
//     final isolate = await FlutterIsolate.spawn(isolate1, "hello");
//     Timer(Duration(seconds: 5), () {
//       print("Pausing Isolate 1");
//       isolate.pause();
//     });
//     Timer(Duration(seconds: 10), () {
//       print("Resuming Isolate 1");
//       isolate.resume();
//     });
//     Timer(Duration(seconds: 20), () {
//       print("Killing Isolate 1");
//       isolate.kill();
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
//       ElevatedButton(
//         child: Text('Spawn isolates'),
//         onPressed: _run,
//       ),
//       ElevatedButton(
//         child: Text('Check running isolates'),
//         onPressed: () async {
//           final isolates = await FlutterIsolate.runningIsolates;
//           await showDialog(
//               builder: (ctx) {
//                 return Center(child:Container(color:Colors.white, padding:EdgeInsets.all(5), child:Column(
//                     children:
//                     isolates.map((i) => Text(i)).cast<Widget>().toList() +
//                         [
//                           ElevatedButton(
//                               child: Text("Close"),
//                               onPressed: () {
//                                 Navigator.of(ctx).pop();
//                               })
//                         ])));
//               },
//               context: context);
//         },
//       ),
//       ElevatedButton(
//         child: Text('Kill all running isolates'),
//         onPressed: () async {
//           await FlutterIsolate.killAll();
//         },),
//       ElevatedButton(
//         child: Text('Run in compute function'),
//         onPressed: () async {
//           await flutterCompute(computeFunction, "foo");
//         },),
//     ]);
//   }
// }

// import 'dart:async';
//
// import 'package:workers/injection.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'bloc/getusercubit/getuser_cubit.dart';
// import 'bloc/newscubit/news_cubit.dart';
// import 'bloc/progresscubit/progress_cubit.dart';
// import 'dashbord.dart';
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   init();
//   await setup();
//   runApp(const FlutterBlueApp());
// }
//
// class FlutterBlueApp extends StatelessWidget {
//   const FlutterBlueApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       color: Colors.lightBlue,
//       home: MultiBlocProvider(
//         providers: [
//           BlocProvider<ProgressCubit>(
//             create: (BuildContext context) => ProgressCubit(),
//           ),
//           BlocProvider<GetUserDataCubit>(
//             create: (BuildContext context) => GetUserDataCubit(),
//           ),
//           BlocProvider<NewsCubit>(
//             create: (BuildContext context) => NewsCubit(),
//           ),
//         ],
//         child:const Dashboard(),
//       ),
//     );
//   }
// }


// class AsyncTaskWidget extends StatelessWidget {
//   AsyncTaskWidget({Key? key,}) : super(key: key);
//   final AsyncTaskCubit cubit = AsyncTaskCubit();
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<AsyncTaskCubit, AsyncTaskState>(
//       bloc: cubit,
//       builder: (context, state) {
//         if (state is AsyncTaskInitial) {
//           return ElevatedButton(
//             onPressed: () {
//               cubit.startAsyncTask();
//             },
//             child: Text('Start Task'),
//           );
//         } else if (state is AsyncTaskInProgress) {
//           return Column(
//             children: [
//               LinearProgressIndicator(value: state.progress / 100),
//               ElevatedButton(
//                 onPressed: () {
//                   cubit.pauseAsyncTask();
//                 },
//                 child: Text('Pause Task'),
//               ),
//             ],
//           );
//         } else if (state is AsyncTaskPaused) {
//           return ElevatedButton(
//             onPressed: () {
//               cubit.resumeAsyncTask();
//             },
//             child: Text('Resume Task'),
//           );
//         } else if (state is AsyncTaskCompleted) {
//           return ElevatedButton(
//             onPressed: () {
//               cubit.startAsyncTask();
//             },
//             child: Text('Restart Task'),
//           );
//         } else {
//           return Container();
//         }
//       },
//     );
//   }
// }
// class AsyncTaskCubit extends Cubit<AsyncTaskState> {
//   AsyncTaskCubit() : super(AsyncTaskInitial());
//
//   Completer<void>? _completer;
//   double pro =0;
//   Future<void> _asyncTask() async {
//     _completer = Completer<void>();
//     for (int i = 0; i < 100; i++) {
//       if (_completer!.isCompleted) {
//         // exit the loop if completer is completed
//         break;
//       }
//       await Future.delayed(Duration(milliseconds: 100));
//       pro= i.toDouble();
//       emit(AsyncTaskInProgress(progress: i + 1));
//     }
//    // emit(AsyncTaskCompleted());
//   }
//
//   void startAsyncTask() {
//     _asyncTask();
//   }
//
//   void pauseAsyncTask() {
//     if (_completer != null && !_completer!.isCompleted) {
//       _completer!.complete();
//       emit(AsyncTaskPaused());
//     }
//   }
//
//   void resumeAsyncTask() {
//     if (_completer != null && _completer!.isCompleted) {
//       _completer = Completer<void>();
//       _asyncTask();
//       emit(AsyncTaskInProgress(progress:pro));
//     }
//   }
// }
// abstract class AsyncTaskState {}
//
// class AsyncTaskInitial extends AsyncTaskState {}
//
// class AsyncTaskInProgress extends AsyncTaskState {
//   final double progress;
//
//   AsyncTaskInProgress({
//     required this.progress,
//   });
// }
//
// class AsyncTaskCompleted extends AsyncTaskState {}
//
// class AsyncTaskPaused extends AsyncTaskState {}



