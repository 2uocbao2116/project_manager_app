import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:projectmanager/src/views/sign_up_screen/models/sign_up_model.dart';

// ignore: must_be_immutable
class SignUpState extends Equatable {
  SignUpState(
      {this.firstNameInputController,
      this.lastNameInputController,
      this.emailInputController,
      this.phoneNumberInputController,
      this.passwordInputController,
      this.confirmPasswordInputController,
      this.signUpModelObj});

  TextEditingController? firstNameInputController;

  TextEditingController? lastNameInputController;

  TextEditingController? emailInputController;

  TextEditingController? phoneNumberInputController;

  TextEditingController? passwordInputController;

  TextEditingController? confirmPasswordInputController;

  SignUpModel? signUpModelObj;

  @override
  List<Object?> get props => [
        firstNameInputController,
        lastNameInputController,
        emailInputController,
        phoneNumberInputController,
        passwordInputController,
        confirmPasswordInputController,
        signUpModelObj
      ];

  SignUpState copyWith({
    TextEditingController? firstNameInputController,
    TextEditingController? lastNameInputController,
    TextEditingController? emailInputController,
    TextEditingController? phoneNumberInputController,
    TextEditingController? passwordInputController,
    TextEditingController? confirmPasswordInputController,
    SignUpModel? signUpModelObj,
  }) {
    return SignUpState(
      firstNameInputController:
          firstNameInputController ?? this.firstNameInputController,
      lastNameInputController:
          lastNameInputController ?? this.lastNameInputController,
      emailInputController: emailInputController ?? this.emailInputController,
      phoneNumberInputController:
          phoneNumberInputController ?? this.phoneNumberInputController,
      passwordInputController:
          passwordInputController ?? this.passwordInputController,
      confirmPasswordInputController:
          confirmPasswordInputController ?? this.confirmPasswordInputController,
      signUpModelObj: signUpModelObj ?? this.signUpModelObj,
    );
  }
}

// ignore: must_be_immutable
class SignUpSuccess extends SignUpState {
  SignUpSuccess({this.isSuccess});

  bool? isSuccess;

  @override
  List<Object?> get props => [isSuccess];
}

// ignore: must_be_immutable
class SignUpFailure extends SignUpState {
  SignUpFailure({this.message});

  String? message;

  @override
  List<Object?> get props => [message];
}
