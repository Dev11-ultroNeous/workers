import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:workers/bloc/progresscubit/progress_cubit.dart';
import 'package:workers/injection.dart';
import 'package:workers/news.dart';
import 'package:workers/user.dart';

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
            onPressed: () async {
              AndroidNotificationDetails androidNotificationDetails =
                  AndroidNotificationDetails(
                      'your channel id', 'your channel name',
                      channelDescription: 'your channel description',
                      importance: Importance.max,
                      ticker: 'ticker',
                      showProgress: true,
                      maxProgress: 10,
                      progress: blocValue.progress.toInt());
              NotificationDetails notificationDetails =
                  NotificationDetails(android: androidNotificationDetails);
              await flutterLocalNotificationsPlugin.show(
                  0, 'Workers', 'Syncing...', notificationDetails,
                  payload: 'item');
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
