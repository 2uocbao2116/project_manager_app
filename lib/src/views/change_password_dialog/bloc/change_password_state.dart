import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ChangePasswordState extends Equatable {
  ChangePasswordState({
    this.passwordInputController,
    this.newPasswordInputController,
    this.confirmPasswordInputController,
  });

  TextEditingController? passwordInputController;

  TextEditingController? newPasswordInputController;

  TextEditingController? confirmPasswordInputController;

  @override
  List<Object?> get props => [
        passwordInputController,
        newPasswordInputController,
        confirmPasswordInputController,
      ];
  ChangePasswordState copyWith({
    TextEditingController? passwordInputController,
    TextEditingController? newPasswordInputController,
    TextEditingController? confirmPasswordInputController,
  }) {
    return ChangePasswordState(
      passwordInputController:
          passwordInputController ?? this.passwordInputController,
      newPasswordInputController:
          newPasswordInputController ?? this.newPasswordInputController,
      confirmPasswordInputController:
          confirmPasswordInputController ?? this.confirmPasswordInputController,
    );
  }
}

// ignore: must_be_immutable
class ChangePasswordSuccess extends ChangePasswordState {
  bool? isSuccess;

  ChangePasswordSuccess({this.isSuccess});

  @override
  List<Object?> get props => [isSuccess];
}

// ignore: must_be_immutable
class ChangePasswordFailure extends ChangePasswordState {
  String? message;

  ChangePasswordFailure({this.message});

  @override
  List<Object?> get props => [message];
}
