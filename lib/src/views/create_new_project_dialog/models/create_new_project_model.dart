import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class CreateNewProjectModel extends Equatable {
  CreateNewProjectModel(
      {this.selectedDueDateInput, this.dueDateInput = "\"\""}) {
    selectedDueDateInput = selectedDueDateInput ?? DateTime.now();
  }

  DateTime? selectedDueDateInput;

  String dueDateInput;

  CreateNewProjectModel copyWith({
    DateTime? selectedDueDateInput,
    String? dueDateInput,
  }) {
    return CreateNewProjectModel(
      selectedDueDateInput: selectedDueDateInput ?? this.selectedDueDateInput,
      dueDateInput: dueDateInput ?? this.dueDateInput,
    );
  }

  @override
  List<Object?> get props => [selectedDueDateInput, dueDateInput];
}
