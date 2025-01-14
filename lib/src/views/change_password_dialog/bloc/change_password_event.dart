import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class ChangePasswordEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ChangePasswordInitialEvent extends ChangePasswordEvent {
  @override
  List<Object?> get props => [];
}

// ignore: must_be_immutable
class UpdatePasswordEvent extends ChangePasswordEvent {
  TextEditingController? oldPassword;
  TextEditingController? newPassword;
  UpdatePasswordEvent({this.oldPassword, this.newPassword});
  @override
  List<Object?> get props => [oldPassword, newPassword];
}
