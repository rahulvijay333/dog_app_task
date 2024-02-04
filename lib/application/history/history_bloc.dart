import 'package:bloc/bloc.dart';
import 'package:machine_test/domain/hive_model/hive_db_model.dart';
import 'package:machine_test/infrastructure/history/history_db.dart';
import 'package:meta/meta.dart';

part 'history_event.dart';
part 'history_state.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  final HistoryDbOp historyDbOp;
  HistoryBloc(this.historyDbOp) : super(HistoryInitial()) {
    on<ShowHistoryEvent>((event, emit) async {
      emit(HistoryLoading());
      final savedHistory = await historyDbOp.getFromHistory();

      emit(HistorySuccess(history: savedHistory));
    });

    on<ClearHistory>((event, emit) async {
      await historyDbOp.clearHistory();

      emit(HistorySuccess(history: []));
    });
  }
}
