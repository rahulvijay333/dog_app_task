import 'package:bloc/bloc.dart';
import 'package:machine_test/infrastructure/history/history_db.dart';
import 'package:machine_test/infrastructure/home/home_service.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeService homeService;
  final HistoryDbOp historyDbOp;

  HomeBloc(this.homeService, this.historyDbOp) : super(HomeInitial()) {
    on<ShowImageEvent>((event, emit) async {
      emit(HomeLoading());
      final response = await homeService.getImageFromServer();

      if (response.$1.isEmpty) {
        emit(HomeImageSuccess(imageUrl: response.$2!.imageUrl));
        await historyDbOp.addtoHistory(imageUrl: response.$2!.imageUrl);
      } else {
        emit(HomeImageFailed(errorMessage: response.$1));
      }
    });
  }
}
