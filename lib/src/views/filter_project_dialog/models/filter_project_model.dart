import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class FilterProjectModel extends Equatable {
  FilterProjectModel({this.selectedStartDateInput, this.selectedEndDateInput}) {
    selectedStartDateInput = selectedStartDateInput ?? DateTime.now();
    selectedStartDateInput = selectedStartDateInput ?? DateTime.now();
  }

  DateTime? selectedStartDateInput;
  DateTime? selectedEndDateInput;

  FilterProjectModel copyWith({
    DateTime? selectedStartDateInput,
    DateTime? selectedEndDateInput,
  }) {
    return FilterProjectModel(
        selectedStartDateInput:
            selectedStartDateInput ?? this.selectedStartDateInput,
        selectedEndDateInput:
            selectedEndDateInput ?? this.selectedEndDateInput);
  }

  @override
  List<Object?> get props => [selectedStartDateInput, selectedEndDateInput];
}
