import 'package:equatable/equatable.dart';

class HomeEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchDataEvent extends HomeEvent {
  FetchDataEvent();
}

class FetchGDPProjectEvent extends HomeEvent {
  FetchGDPProjectEvent();
}

class HomeInitial extends HomeEvent {}
