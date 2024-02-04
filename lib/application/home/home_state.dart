part of 'home_bloc.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {
  
}

class HomeImageSuccess extends HomeState {
  final String imageUrl;

  HomeImageSuccess({required this.imageUrl});
}

class HomeImageFailed extends HomeState {
  final String errorMessage;

  HomeImageFailed({required this.errorMessage});
}
