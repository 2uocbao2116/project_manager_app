import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class UpdateTaskModel extends Equatable {
  UpdateTaskModel({this.selectedDueDateInput, this.dueDateInput = "\"\""}) {
    selectedDueDateInput = selectedDueDateInput ?? DateTime.now();
  }

  DateTime? selectedDueDateInput;

  String dueDateInput;

  UpdateTaskModel copyWith({
    DateTime? selectedDueDateInput,
    String? dueDateInput,
  }) {
    return UpdateTaskModel(
      selectedDueDateInput: selectedDueDateInput ?? this.selectedDueDateInput,
      dueDateInput: dueDateInput ?? this.dueDateInput,
    );
  }

  @override
  List<Object?> get props => [selectedDueDateInput, dueDateInput];
}
