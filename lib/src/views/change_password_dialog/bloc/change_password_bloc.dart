import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectmanager/src/data/models/response_error.dart';
import 'package:projectmanager/src/data/models/user/sign_in_req.dart';
import 'package:projectmanager/src/data/repository/repository.dart';
import 'package:projectmanager/src/utils/pref_utils.dart';
import 'package:projectmanager/src/views/change_password_dialog/bloc/change_password_event.dart';
import 'package:projectmanager/src/views/change_password_dialog/bloc/change_password_state.dart';

class ChangePasswordBloc
    extends Bloc<ChangePasswordEvent, ChangePasswordState> {
  ChangePasswordBloc(super.initialState) {
    on<ChangePasswordInitialEvent>(_onInitialize);
    on<UpdatePasswordEvent>(_onUpdatePassword);
  }

  final _repository = Repository();

  _onInitialize(
    ChangePasswordInitialEvent event,
    Emitter<ChangePasswordState> emit,
  ) async {
    emit(state.copyWith(
      passwordInputController: TextEditingController(),
      newPasswordInputController: TextEditingController(),
      confirmPasswordInputController: TextEditingController(),
    ));
  }

  _onUpdatePassword(
    UpdatePasswordEvent event,
    Emitter<ChangePasswordState> emit,
  ) async {
    UserLoginReq userLoginReq = UserLoginReq(
      username: PrefUtils().getUser()!.phoneNumber,
      password: event.oldPassword!.text,
      newPassword: event.newPassword!.text,
    );

    await _repository
        .updatePassword(requestData: userLoginReq.toJson())
        .then((onValue) async {
      if (onValue.status == 200) {
        emit(
          ChangePasswordSuccess(isSuccess: true),
        );
      }
    }).onError((handleError, strackTrace) async {
      String errorMessage = 'An unexpected error occurred.';
      if (handleError is DioException) {
        final errorResp = ResponseError.fromJson(handleError.response?.data);
        errorMessage = errorResp.detail!;
      }
      emit(
        ChangePasswordFailure(message: errorMessage),
      );
    });
  }
}
