import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class SignUpEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SignUpInitialEvent extends SignUpEvent {
  @override
  List<Object?> get props => [];
}

// ignore: must_be_immutable
class SignUp extends SignUpEvent {
  TextEditingController? firstName;
  TextEditingController? lastName;
  TextEditingController? phoneNumber;
  TextEditingController? email;
  TextEditingController? password;

  SignUp({
    this.firstName,
    this.lastName,
    this.phoneNumber,
    this.email,
    this.password,
  });
  @override
  List<Object?> get props =>
      [firstName, lastName, phoneNumber, email, password];
}
