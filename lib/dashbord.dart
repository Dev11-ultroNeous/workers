import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workers/home.dart';
import 'package:workers/sql/shared_prefs_helper.dart';
import 'package:workers/widget/progressbar.dart';

import 'bloc/progresscubit/progress_cubit.dart';
import 'injection.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final _currentTab = TabItem.home;
  final _navigatorKeys = {
    TabItem.home: GlobalKey<NavigatorState>(),
  };
  final sharedPrefLocator = injection.get<SharedPreferenceHelper>();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final progressCubit = BlocProvider.of<ProgressCubit>(context);
    ProgressCubit.databaseHelper.getCacheUser();
    return WillPopScope(
      onWillPop: () async {
        final isFirstRouteInCurrentTab =
            !await _navigatorKeys[_currentTab]!.currentState!.maybePop();
        return isFirstRouteInCurrentTab;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Dashboard"),
          bottom: PreferredSize(
            preferredSize: const Size(double.infinity, 2.0),
            child:
                BlocBuilder<ProgressCubit, ProgressState>(builder: (_, state) {
              if (state is ProgressRunState) {
                return ProgressLine(
                  percentage: (state.progress * 10),
                );
              }
              return Container();
            }),
          ),
          actions: [
            BlocBuilder<ProgressCubit, ProgressState>(builder: (_, state) {
              if (state is ProgressRunState) {
                return IconButton(
                    onPressed: () {
                      progressCubit.stopIsolate();
                    },
                    icon: const Icon(Icons.stop));
              } else {
                return IconButton(
                    onPressed: () {
                      progressCubit.startIsolate();
                    },
                    icon: const Icon(Icons.sync));
              }
            }),
          ],
        ),
        body: IndexedStack(children: [
          Navigator(
            key: _navigatorKeys[TabItem.home],
            onGenerateRoute: (route) => MaterialPageRoute(
              settings: route,
              builder: (context) => const HomePage(),
            ),
          ),
        ]),
      ),
    );
  }
}

enum TabItem { home }
