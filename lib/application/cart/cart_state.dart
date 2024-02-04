part of 'cart_bloc.dart';

abstract class CartState {}

class CartInitial extends CartState {}

class CartSuccess extends CartState {
  final List<HiveCartDb> cartlist;

  CartSuccess({required this.cartlist});
}

class CartAddFailed extends CartState {}

class CartAddSucess extends CartState {}

class CartDeleteSuccess extends CartState {}

class CartDeleteFailed extends CartState {}
