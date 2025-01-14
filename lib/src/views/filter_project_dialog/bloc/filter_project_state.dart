import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class FilterProjectState extends Equatable {
  FilterProjectState({
    this.statusInputController,
    this.startDateInputController,
    this.endDateInputController,
  });

  TextEditingController? statusInputController;

  TextEditingController? startDateInputController;

  TextEditingController? endDateInputController;

  @override
  List<Object?> get props => [
        statusInputController,
        startDateInputController,
        endDateInputController,
      ];
  FilterProjectState copyWith({
    TextEditingController? statusInputController,
    TextEditingController? startDateInputController,
    TextEditingController? endDateInputController,
  }) {
    return FilterProjectState(
      statusInputController:
          statusInputController ?? this.statusInputController,
      startDateInputController:
          startDateInputController ?? this.startDateInputController,
      endDateInputController:
          endDateInputController ?? this.endDateInputController,
    );
  }
}
