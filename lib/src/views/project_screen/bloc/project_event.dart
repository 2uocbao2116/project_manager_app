import 'package:equatable/equatable.dart';

class ProjectEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchProjectEvent extends ProjectEvent {
  FetchProjectEvent();
  @override
  List<Object?> get props => [];
}

class FetchTasksEvent extends ProjectEvent {
  @override
  List<Object?> get props => [];
}

class FetchGDPTaskEvent extends ProjectEvent {
  FetchGDPTaskEvent();
  @override
  List<Object?> get props => [];
}
