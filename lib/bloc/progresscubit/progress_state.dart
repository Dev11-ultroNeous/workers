part of 'progress_cubit.dart';

abstract class ProgressState {}

class ProgressInitial extends ProgressState {}

class ProgressRunState extends ProgressState {
  final double progress;

  ProgressRunState({
    required this.progress,
  });
}

class ProgressStopState extends ProgressState {}


