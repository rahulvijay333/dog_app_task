part of 'history_bloc.dart';

abstract class HistoryState {}

class HistoryInitial extends HistoryState {}

class HistoryLoading extends HistoryState {
  
}

class HistorySuccess extends HistoryState {
  final List<HiveHistoryDb> history;

  HistorySuccess({required this.history});
}

class HistoryFailed extends HistoryState {}
