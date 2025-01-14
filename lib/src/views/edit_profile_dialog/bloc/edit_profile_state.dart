import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:projectmanager/src/views/edit_profile_dialog/models/edit_profile_model.dart';

// ignore: must_be_immutable
class EditProfileState extends Equatable {
  EditProfileState(
      {this.firstNameInputController,
      this.lastNameInputController,
      this.emailInputController,
      this.phoneNumberInputController,
      this.editProfileModelObj});

  TextEditingController? firstNameInputController;
  TextEditingController? lastNameInputController;
  TextEditingController? emailInputController;
  TextEditingController? phoneNumberInputController;
  EditProfileModel? editProfileModelObj;

  @override
  List<Object?> get props => [
        firstNameInputController,
        lastNameInputController,
        emailInputController,
        phoneNumberInputController,
        editProfileModelObj
      ];

  EditProfileState copyWith({
    TextEditingController? firstNameInputController,
    TextEditingController? lastNameInputController,
    TextEditingController? emailInputController,
    TextEditingController? phoneNumberInputController,
    EditProfileModel? editProfileModelObj,
  }) {
    return EditProfileState(
      firstNameInputController:
          firstNameInputController ?? this.firstNameInputController,
      lastNameInputController:
          lastNameInputController ?? this.lastNameInputController,
      emailInputController: emailInputController ?? this.emailInputController,
      phoneNumberInputController:
          phoneNumberInputController ?? this.phoneNumberInputController,
      editProfileModelObj: editProfileModelObj ?? this.editProfileModelObj,
    );
  }
}

// ignore: must_be_immutable
class UpdateProfileSuccess extends EditProfileState {
  bool? isSuccess;
  UpdateProfileSuccess({this.isSuccess});
  @override
  List<Object?> get props => [isSuccess];
}

// ignore: must_be_immutable
class UpdateProfileFailure extends EditProfileState {
  String? message;
  UpdateProfileFailure({this.message});
  @override
  List<Object?> get props => [message];
}
