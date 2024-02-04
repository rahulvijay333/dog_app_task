import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:machine_test/domain/hive_model/hive_db_model.dart';
import 'package:machine_test/infrastructure/cart/cart_service.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CartDbService cartDbService;
  CartBloc(this.cartDbService) : super(CartInitial()) {
    on<GetCartDetails>((event, emit) async {
      final list = await cartDbService.getCartDetails();

      emit(CartSuccess(cartlist: list));
    });

    on<AddtoCartEvent>((event, emit) async {
      final addStatus = await cartDbService.addToCart(imageUrl: event.imageUrl);
      if (addStatus) {
        emit(CartAddSucess());
      } else {
        emit(CartAddFailed());
      }
    });

    on<DeleteFromCartEvent>((event, emit) async {
      final deleteStatus = await cartDbService.deleteFromCart(key: event.key);
      if (deleteStatus) {
        add(GetCartDetails());
      }
    });
  }
}
