part of 'history_bloc.dart';

abstract class HistoryEvent {}

class ShowHistoryEvent extends HistoryEvent {}

class ClearHistory extends HistoryEvent {}
