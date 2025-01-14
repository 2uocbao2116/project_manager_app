import 'package:equatable/equatable.dart';

class FilterTaskEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FilterTaskInitialEvent extends FilterTaskEvent {
  @override
  List<Object?> get props => [];
}

// ignore: must_be_immutable
class ChangeDateEvent extends FilterTaskEvent {
  ChangeDateEvent({required this.date});

  DateTime date;

  @override
  List<Object?> get props => [date];
}
