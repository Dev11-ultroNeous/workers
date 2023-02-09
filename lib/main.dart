import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:worker_manager/worker_manager.dart';
import 'package:workers/injection.dart';
import 'package:workers/network.dart';
import 'package:workers/news.dart';
import 'package:workers/progressbar.dart';
import 'package:workers/user.dart';
import 'database_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  init();
  runApp(const MyApp());
  await Executor().warmUp(log: true, isolatesCount: 3);
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int progress = 0;
  final DatabaseHelper databaseHelper = locator<DatabaseHelper>();
  late NetworkApi networkApi;
  @override
  void initState() {
    networkApi = NetworkApi();
    super.initState();
  }
  void callApi() async {
    isolateOne();
    isolateTwo();
    isolateThree();
    isolateFour();
    isolateFive();
    isolateSix();
    isolateSeven();
    isolateEight();
    isolateNine();
    isolateTen();
  }

  isolateOne() {
    Executor().execute(
      arg1: 3,
      fun1: networkApi.apiOne,
    ).then((value) {
      setState(() {
        if(value.isNotEmpty) {
          progress++;
          databaseHelper.insertUsers(value);
        }
      });
    });
  }

  isolateTwo() {
    Executor().execute(
          arg1: 2,
          fun1: networkApi.apiTwo,
        ).then((value) => setState(() {
          if(value.isNotEmpty){
            progress++;
            databaseHelper.insertBanks(value);
          }
        })
    );
  }

  Cancelable<void> isolateThree() {
    final execute = Executor().execute(
      arg1: 2,
      fun1: networkApi.apiThree,
    );
    execute.whenComplete(() => setState(() {
          progress++;
        }));
    return execute;
  }

  isolateFour() {
    Executor().execute(
      arg1: 1,
      fun1: networkApi.apiFour,
    ).then((value) {
      setState(() {
        if(value.isNotEmpty) {
          progress++;
          databaseHelper.insertUsers(value);
        }
      });
    });
  }
  Cancelable<void> isolateFive() {
    final execute = Executor().execute(
      arg1: 2,
      fun1: networkApi.apiFive,
    );
    execute.whenComplete(() => setState(() {
          progress++;
        }));
    return execute;
  }
  Cancelable<void> isolateSix() {
    final execute = Executor().execute(
      arg1: 2,
      fun1: networkApi.apiSix,
    );
    execute.whenComplete(() => setState(() {
          progress++;
        }));
    return execute;
  }
  isolateSeven() {
    Executor()
        .execute(
      arg1: 2,
      fun1: networkApi.apiSeven,
    )
        .then((value) {
      setState(() {
        if(value.isNotEmpty) {
          progress++;
          databaseHelper.insertArticles(value);
        }
      });
    });
  }
  Cancelable<void> isolateEight() {
    final execute = Executor().execute(
      arg1: 2,
      fun1: networkApi.apiEight,
    );
    execute.whenComplete(() => setState(() {
          progress++;
        }));
    return execute;
  }
  Cancelable<void> isolateNine() {
    final execute = Executor().execute(
      arg1: 2,
      fun1: networkApi.apiNine,
    );
    execute.whenComplete(() => setState(() {
          progress++;
        }));
    return execute;
  }

  isolateTen() {
    Executor().execute(
      arg1: 1,
      fun1: networkApi.apiTen,
    ).then((value) {
      databaseHelper.insertUsers(value);
      setState(() {
        if(value.isNotEmpty){
        progress++;

        }
      });

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: SizedBox(
              width: 300,
              child: ProgressLine(
                percentage: (progress * 10),
              ),
            ),
          ),
          const SizedBox(height: 20),
          CupertinoButton(
            color: Colors.cyan,
            child: const Text(" Pause  "),
            onPressed: () {
              Executor().pausePool();
            },
          ),
          const SizedBox(height: 20),
          CupertinoButton(
            color: Colors.green,
            child: const Text('sync data'),
            onPressed: () {
              setState(() {});
              callApi();
              databaseHelper.clearCacheUser();
              databaseHelper.clearCacheBank();
              databaseHelper.clearCacheNews();
              progress = 0;
              Executor().resumePool();
            },
          ),
          const SizedBox(height: 15),
          CupertinoButton(
            color: Colors.cyan,
            child: const Text('News List'),
            onPressed: () {
              databaseHelper.getCacheArticles().then(
                    (value) => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => NewsList(
                                newsList: value,
                              )
                      ),
                    ),
                  );
            },
          ),
          const SizedBox(height: 15),
          CupertinoButton(
            color: Colors.cyan,
            child: const Text('User List'),
            onPressed: () {
              databaseHelper.getCacheUser().then(
                    (value) => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => UserList(
                                userList: value,
                          )
                      ),
                    ),
              );
            },
          ),
        ],
      ),
    );
  }
}
