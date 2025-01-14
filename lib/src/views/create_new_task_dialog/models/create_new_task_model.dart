import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class CreateNewTaskModel extends Equatable {
  CreateNewTaskModel({this.selectedDueDateInput, this.dueDateInput = "\"\""}) {
    selectedDueDateInput = selectedDueDateInput ?? DateTime.now();
  }

  DateTime? selectedDueDateInput;

  String dueDateInput;

  CreateNewTaskModel copyWith({
    DateTime? selectedDueDateInput,
    String? dueDateInput,
  }) {
    return CreateNewTaskModel(
      selectedDueDateInput: selectedDueDateInput ?? this.selectedDueDateInput,
      dueDateInput: dueDateInput ?? this.dueDateInput,
    );
  }

  @override
  List<Object?> get props => [selectedDueDateInput, dueDateInput];
}
