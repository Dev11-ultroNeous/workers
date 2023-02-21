import 'package:workers/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/getusercubit/getuser_cubit.dart';
import 'bloc/newscubit/news_cubit.dart';
import 'bloc/progresscubit/progress_cubit.dart';
import 'dashbord.dart';
import 'worker_manager/worker_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  init();
  setup();
  await Executor().warmUp(log: true);
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
