import 'package:workers/injection.dart';
import 'package:workers/sql/database_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewsCubit extends Cubit<NewsState> {
  NewsCubit() : super(NewsState(data: []));
  var progress = 0.0;
  final DatabaseHelper databaseHelper = injection<DatabaseHelper>();
  void getNewsdata() {
    databaseHelper
        .getCacheArticles()
        .then((value) => emit(NewsState(data: value)));
  }
}

class NewsState {
  final List<Map<String, dynamic>> data;
  NewsState({
    required this.data,
  });
}
