import 'package:workers/bloc/progresscubit/progress_cubit.dart';
import 'package:workers/news.dart';
import 'package:workers/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    final blocValue = BlocProvider.of<ProgressCubit>(context);
    return Scaffold(
        body: Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const UserList()),
              );
            },
            child: const SizedBox(
              height: 34,
              width: 90,
              child: Center(
                child: Text("User List"),
              ),
            ),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const NewsList()),
              );
            },
            child: const SizedBox(
              height: 34,
              width: 90,
              child: Center(
                child: Text("News List"),
              ),
            ),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              blocValue.getlocal();
            },
            child: const SizedBox(
              height: 34,
              width: 90,
              child: Center(
                child: Text("Local List"),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
