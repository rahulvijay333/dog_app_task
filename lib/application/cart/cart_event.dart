part of 'cart_bloc.dart';

abstract class CartEvent {}

class AddtoCartEvent extends CartEvent {
  final String imageUrl;

  AddtoCartEvent({required this.imageUrl});
}

class DeleteFromCartEvent extends CartEvent {
  final String key;

  DeleteFromCartEvent({required this.key});
}

class GetCartDetails extends CartEvent {}
