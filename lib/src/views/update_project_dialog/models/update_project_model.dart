import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class UpdateProjectModel extends Equatable {
  UpdateProjectModel({this.selectedDueDateInput, this.dueDateInput = "\"\""}) {
    selectedDueDateInput = selectedDueDateInput ?? DateTime.now();
  }

  DateTime? selectedDueDateInput;

  String dueDateInput;

  UpdateProjectModel copyWith({
    DateTime? selectedDueDateInput,
    String? dueDateInput,
  }) {
    return UpdateProjectModel(
      selectedDueDateInput: selectedDueDateInput ?? this.selectedDueDateInput,
      dueDateInput: dueDateInput ?? this.dueDateInput,
    );
  }

  @override
  List<Object?> get props => [selectedDueDateInput, dueDateInput];
}
