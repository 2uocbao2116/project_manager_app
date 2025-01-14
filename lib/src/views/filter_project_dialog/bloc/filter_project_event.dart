import 'package:equatable/equatable.dart';

class FilterProjectEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FilterProjectInitialEvent extends FilterProjectEvent {
  @override
  List<Object?> get props => [];
}

// ignore: must_be_immutable
class ChangeDateEvent extends FilterProjectEvent {
  ChangeDateEvent({required this.date});

  DateTime date;

  @override
  List<Object?> get props => [date];
}
