import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class EditProfileEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class EditProfileInitialEvent extends EditProfileEvent {
  @override
  List<Object?> get props => [];
}

// ignore: must_be_immutable
class UpdateProfileEvent extends EditProfileEvent {
  TextEditingController? firstName;
  TextEditingController? lastName;
  TextEditingController? email;
  TextEditingController? phoneNumber;
  UpdateProfileEvent({
    this.firstName,
    this.lastName,
    this.email,
    this.phoneNumber,
  });
  @override
  List<Object?> get props => [firstName, lastName, email, phoneNumber];
}
