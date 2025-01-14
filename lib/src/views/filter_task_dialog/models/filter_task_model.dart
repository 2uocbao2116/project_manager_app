import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class FilterTaskModel extends Equatable {
  FilterTaskModel({this.selectedDateInput, this.dateInput = "\"\""}) {
    selectedDateInput = selectedDateInput ?? DateTime.now();
  }

  DateTime? selectedDateInput;

  String dateInput;

  FilterTaskModel copyWith({
    DateTime? selectedDateInput,
    String? dateInput,
  }) {
    return FilterTaskModel(
      selectedDateInput: selectedDateInput ?? this.selectedDateInput,
      dateInput: dateInput ?? this.dateInput,
    );
  }

  @override
  List<Object?> get props => [selectedDateInput, dateInput];
}
