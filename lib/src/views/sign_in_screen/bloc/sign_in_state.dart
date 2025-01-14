import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:projectmanager/src/views/sign_in_screen/models/sign_in_model.dart';

// ignore: must_be_immutable
class SignInState extends Equatable {
  SignInState(
      {this.userNameController, this.passwordController, this.signInModelObj});

  TextEditingController? userNameController;
  TextEditingController? passwordController;
  SignInModel? signInModelObj;

  @override
  List<Object?> get props =>
      [userNameController, passwordController, signInModelObj];
  SignInState copyWith({
    TextEditingController? userNameController,
    TextEditingController? passwordController,
    SignInModel? signInModelObj,
  }) {
    return SignInState(
      userNameController: userNameController ?? this.userNameController,
      passwordController: passwordController ?? this.passwordController,
      signInModelObj: signInModelObj ?? this.signInModelObj,
    );
  }
}

// ignore: must_be_immutable
class SignInFailure extends SignInState {
  String? error;

  SignInFailure({this.error});

  @override
  List<Object?> get props => [error];
}
